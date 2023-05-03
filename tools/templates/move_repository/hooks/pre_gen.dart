import 'dart:io';

import "package:mason/mason.dart";
import 'package:path/path.dart' as path;
import 'package:template_utils/template_utils.dart';

Future<void> run(HookContext context) async {
  try {
    final rootDir = projectRootDir(context.vars["root_folder_path"] as String? ?? '');
    final appPackage = await getAppPackage(rootDir);
    final libDir = rootDir.libDir;

    final oldInterfacePath = File(path.join(rootDir, context.vars["interface_path"]));
    final oldImplementationPath = File(path.join(rootDir, context.vars["implementation_path"]));
    if (!oldInterfacePath.existsSync()) {
      throw "Cannot find old repository at ${oldInterfacePath.absolute}";
    }
    if (!oldImplementationPath.existsSync()) {
      throw "Cannot find old repository at ${oldImplementationPath.absolute}";
    }

    final newFeatureName = (context.vars["new_feature_name"] as String? ?? '').snakeCase;
    final newRepositoryName = context.vars["new_repository_name"] as String? ?? "";
    final newRepositoryPrefix = context.vars["new_repository_prefix"] as String? ?? '';

    final oldInterfaceFileName = oldInterfacePath.fileNameWithExtension;
    final oldImplementationFileName = oldImplementationPath.fileNameWithExtension;

    final newInterfaceFileName =
        newRepositoryName.isEmpty ? oldInterfaceFileName : "${newRepositoryName.suffixed("Repository").snakeCase}.dart";

    final newImplementationFileName = newRepositoryPrefix.isEmpty && newRepositoryName.isEmpty
        ? oldImplementationFileName
        : "${newRepositoryPrefix.snakeCase}_$newInterfaceFileName";

    final newInterfacePath = File(
      newFeatureName.isEmpty
          ? path.join(libDir, 'core/domain/repositories/$newInterfaceFileName')
          : path.join(libDir, 'features/${newFeatureName.snakeCase}/domain/repositories/$newInterfaceFileName'),
    );

    final newImplementationPath = File(
      newFeatureName.isEmpty
          ? path.join(libDir, 'core/data/$newImplementationFileName')
          : path.join(libDir, 'features/${newFeatureName.snakeCase}/data/$newImplementationFileName'),
    );

    final newInterfaceName = newInterfaceFileName.classNameFromFile;

    final newInterfacePackage = "package:$appPackage/${libDir.relativePathTo(newInterfacePath.path)}";

    final newMocksFile = mocksFilePath(feature: newFeatureName, rootDir: rootDir);
    await ensureFeaturesFiles(appPackage: appPackage, featureName: newFeatureName, rootDir: rootDir);

    ///remove imports from old feature_component file
    await replaceAllInFileLineByLine(
      filePath: featureComponentFilePath(feature: oldInterfacePath.path.featureName, rootDir: rootDir),
      replacements: [
        StringReplacement.string(
          from: RegExp(".*import.*\\/${oldInterfacePath.fileNameWithoutExtension}\\.dart.*;"),
          to: '',
        ),
        StringReplacement.string(
          from: RegExp(".*import .*\\/${oldImplementationPath.fileNameWithoutExtension}\\.dart.*"),
          to: '',
          failIfNotFound: false,
        ),
      ],
    );
    await renameTpe(
      rootPath: rootDir,
      renameParams: RenameParams.fromFilePaths(
        oldFilePath: oldImplementationPath.path,
        newFilePath: newImplementationPath.path,
      ),
    );
    await renameTpe(
      rootPath: rootDir,
      renameParams: RenameParams.fromFilePaths(
        oldFilePath: oldInterfacePath.path,
        newFilePath: newInterfacePath.path,
      ),
    );

    ///add new imports to feature_component file
    await replaceAllInFileLineByLine(
      filePath: featureComponentFilePath(feature: newInterfacePath.path.featureName, rootDir: rootDir),
      replacements: [
        StringReplacement.prepend(
          before: '//DO-NOT-REMOVE APP_COMPONENT_IMPORTS',
          text: "${templateImport(newImplementationPath.path.importPath(rootDir, appPackage: appPackage))}\n"
              "${templateImport(newInterfacePath.path.importPath(rootDir, appPackage: appPackage))}",
        ),
      ],
    );
    await replaceAllInFileLineByLine(
      filePath: mockDefinitionsFilePath(feature: newFeatureName, rootDir: rootDir),
      replacements: [
        StringReplacement.prepend(
          before: "//DO-NOT-REMOVE REPOSITORIES_MOCK_DEFINITION",
          text: templateMockClassDefinition(newInterfaceName),
        ),
        StringReplacement.prepend(
          before: "//DO-NOT-REMOVE IMPORTS_MOCK_DEFINITIONS",
          text: templateImport(newInterfacePackage),
        ),
      ],
    );
    await replaceAllInFileLineByLine(
      filePath: newMocksFile,
      replacements: [
        StringReplacement.prepend(
          before: "//DO-NOT-REMOVE REPOSITORIES_MOCKS_STATIC_FIELD",
          text: templateMockStaticField(newInterfaceName),
        ),
        StringReplacement.prepend(
          before: "//DO-NOT-REMOVE REPOSITORIES_INIT_MOCKS",
          text: templateMockFieldInit(newInterfaceName),
        ),
        StringReplacement.prepend(
          before: "//DO-NOT-REMOVE REPOSITORIES_MOCK_FALLBACK_VALUE",
          text: templateRegisterFallback(newInterfaceName),
        ),
      ],
    );
  } catch (ex, stack) {
    print("EXCEPTION: $ex");
    print("stack: $stack");
    rethrow;
  }
}
