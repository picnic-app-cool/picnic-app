import 'dart:io';

import "package:mason/mason.dart";
import 'package:path/path.dart' as path;
import 'package:template_utils/template_utils.dart';

Future<void> run(HookContext context) async {
  try {
    final rootDir = projectRootDir(context.vars["root_folder_path"] as String? ?? '');
    final oldPagePath = context.vars["page_path"] as String? ?? '';
    if (!File(oldPagePath).existsSync()) {
      throw "Cannot find old page at ${path.absolute(oldPagePath)}";
    }
    final newPageName = (context.vars["new_page_name"] as String? ?? oldPagePath.fileNameWithoutExtension.pascalCase)
        .pascalCase
        .suffixed("Page");
    final newFeatureName = (context.vars["new_feature_name"] as String? ?? oldPagePath.featureName).snakeCase;
    final newSubdirectory = (context.vars["new_subdirectory"] as String? ?? '').snakeCase;
    final appPackage = await getAppPackage(rootDir);
    final libDir = rootDir.libDir;
    final oldTypeStem = oldPagePath.fileNameWithoutExtension.pascalCase.replaceAll("Page", "");
    final newTypeStem = newPageName.replaceAll("Page", "");

    final filesList = [
      _MoveArguments(typeSuffix: "Navigator", createMocks: true),
      _MoveArguments(
        typeSuffix: "PresentationModel",
        createMocks: true,
        additionalReplacements: [
          StringReplacement.string(
            from: "${oldTypeStem}ViewModel",
            to: "${newTypeStem}ViewModel",
            failIfNotFound: false,
          )
        ],
      ),
      _MoveArguments(typeSuffix: "Presenter", createMocks: true, mockType: "MockCubit<${newTypeStem}ViewModel>"),
      _MoveArguments(typeSuffix: "Page", createMocks: false),
      _MoveArguments(typeSuffix: "InitialParams", createMocks: true),
    ];
    for (final args in filesList) {
      final oldFilePath = oldPagePath.replaceAll("page.dart", "${args.typeSuffix.snakeCase}.dart");
      final newFileName = "${newPageName.replaceAll("Page", args.typeSuffix).snakeCase}.dart";

      final newFilePath = path.join(
        _newFileParentDirectory(
          libDir: libDir,
          featureName: newFeatureName,
          newSubdirectory: newSubdirectory,
        ),
        newFileName,
      );

      ///remove imports from old feature_component file
      await replaceAllInFileLineByLine(
        filePath: featureComponentFilePath(feature: oldFilePath.featureName, rootDir: rootDir),
        replacements: [
          StringReplacement.string(
            from: RegExp(".*import.*\\/${oldFilePath.fileNameWithoutExtension}\\.dart.*;"),
            to: '',
          ),
        ],
      );
      final newFilesPackage = "package:$appPackage/${libDir.relativePathTo(newFilePath)}";
      final newMocksFile = mocksFilePath(feature: newFeatureName, rootDir: rootDir);
      await ensureFeaturesFiles(appPackage: appPackage, featureName: newFeatureName, rootDir: rootDir);
      print("renaming\n$oldFilePath\n$newFilePath\n");
      await _renameType(
        rootDir: rootDir,
        oldFilePath: oldFilePath,
        newFilePath: newFilePath,
        appPackage: appPackage,
        newFeatureName: newFeatureName,
        newClassPackage: newFilesPackage,
        newMocksFile: newMocksFile,
        args: args,
      );
    }
  } catch (ex, stack) {
    print("EXCEPTION: $ex");
    print("stack: $stack");
    rethrow;
  }
}

String _newFileParentDirectory({
  required String libDir,
  required String featureName,
  required String newSubdirectory,
}) =>
    path.join(
      libDir,
      'features',
      '${(featureName).snakeCase}',
      '${newSubdirectory.snakeCase}',
    );

Future<void> _renameType({
  required String rootDir,
  required String oldFilePath,
  required String newFilePath,
  required String appPackage,
  required String newFeatureName,
  required String newClassPackage,
  required String newMocksFile,
  required _MoveArguments args,
}) async {
  final newClassName = newFilePath.classNameFromFile;

  await renameTpe(
    rootPath: rootDir,
    renameParams: RenameParams.fromFilePaths(
      oldFilePath: oldFilePath,
      newFilePath: newFilePath,
      additionalReplacements: args.additionalReplacements,
    ),
  );

  ///add new imports to feature_component file
  await replaceAllInFileLineByLine(
    filePath: featureComponentFilePath(feature: newFilePath.featureName, rootDir: rootDir),
    replacements: [
      StringReplacement.prepend(
        before: '//DO-NOT-REMOVE APP_COMPONENT_IMPORTS',
        text: templateImport(newFilePath.importPath(rootDir, appPackage: appPackage)),
      ),
    ],
  );
  if (args.createMocks) {
    await replaceAllInFileLineByLine(
      filePath: mockDefinitionsFilePath(feature: newFeatureName, rootDir: rootDir),
      replacements: [
        StringReplacement.prepend(
          before: "//DO-NOT-REMOVE MVP_MOCK_DEFINITION",
          text: templateMockClassDefinition(newClassName, mockType: args.mockType),
        ),
        StringReplacement.prepend(
          before: "//DO-NOT-REMOVE IMPORTS_MOCK_DEFINITIONS",
          text: templateImport(newClassPackage),
        ),
      ],
    );
    await replaceAllInFileLineByLine(
      filePath: newMocksFile,
      replacements: [
        StringReplacement.prepend(
          before: "//DO-NOT-REMOVE MVP_MOCKS_STATIC_FIELD",
          text: templateMockStaticField(newClassName),
        ),
        StringReplacement.prepend(
          before: "//DO-NOT-REMOVE MVP_INIT_MOCKS",
          text: templateMockFieldInit(newClassName),
        ),
        StringReplacement.prepend(
          before: "//DO-NOT-REMOVE MVP_MOCK_FALLBACK_VALUE",
          text: templateRegisterFallback(newClassName),
        ),
      ],
    );
  }
}

class _MoveArguments {
  _MoveArguments({
    required this.typeSuffix,
    required this.createMocks,
    this.mockType,
    this.additionalReplacements = const [],
  });

  final String typeSuffix;
  final String? mockType;
  final bool createMocks;
  final List<StringReplacement> additionalReplacements;
}
