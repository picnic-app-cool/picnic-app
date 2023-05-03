import 'package:mason/mason.dart';
import 'package:template_utils/template_utils.dart';

Future<void> run(HookContext context) async {
  final appPackage = context.vars["app_package"] as String;
  final feature = context.vars["feature"] as String;
  final interfaceName = context.vars["interface_name"] as String;
  final implementationName = context.vars["implementation_name"] as String;
  final interfaceFileName = context.vars["interface_file_name"] as String;
  final implementationFileName = context.vars["implementation_file_name"] as String;
  final implementationImport = context.vars["implementation_import"] as String;
  final interfaceImport = context.vars["interface_import"] as String;
  final rootDir = context.vars["root_dir"] as String;

  await _replaceInMockDefinitions(
    context: context,
    interfaceName: interfaceName,
    interfaceFileName: interfaceFileName,
    interfaceImport: interfaceImport,
    feature: feature,
    rootDir: rootDir,
  );

  await _replaceInMocks(
    context: context,
    interfaceName: interfaceName,
    feature: feature,
    rootDir: rootDir,
  );

  await _replaceInAppComponent(
    appPackage: appPackage,
    context: context,
    interfaceName: interfaceName,
    implementationName: implementationName,
    interfaceFileName: interfaceFileName,
    implementationFileName: implementationFileName,
    implementationImport: implementationImport,
    interfaceImport: interfaceImport,
    feature: feature,
    rootDir: rootDir,
  );
}

Future<void> _replaceInAppComponent({
  required HookContext context,
  required String appPackage,
  required String interfaceName,
  required String implementationName,
  required String interfaceFileName,
  required String implementationFileName,
  required String implementationImport,
  required String interfaceImport,
  required String feature,
  required String rootDir,
}) async {
  await ensureFeatureComponentFile(appPackage: appPackage, feature: feature, rootDir: rootDir);
  await replaceAllInFileLineByLine(
    filePath: featureComponentFilePath(feature: feature, rootDir: rootDir),
    replacements: [
      StringReplacement.prepend(
        before: "//DO-NOT-REMOVE REPOSITORIES_GET_IT_CONFIG",
        text: templateRegisterFactory(interfaceName: interfaceName, implementationName: implementationName),
      ),
    ],
  );
  await replaceAllInFileLineByLine(
    filePath: featureComponentFilePath(feature: feature, rootDir: rootDir),
    replacements: [
      StringReplacement.prepend(
        before: "//DO-NOT-REMOVE APP_COMPONENT_IMPORTS",
        text: "$implementationImport\n$interfaceImport",
      ),
    ],
  );
}

Future<void> _replaceInMockDefinitions({
  required HookContext context,
  required String interfaceName,
  required String interfaceFileName,
  required String interfaceImport,
  required String feature,
  required String rootDir,
}) async {
  await ensureMockDefinitionsFile(feature: feature, rootDir: rootDir);
  await replaceAllInFileLineByLine(
    filePath: mockDefinitionsFilePath(feature: feature, rootDir: rootDir),
    replacements: [
      StringReplacement.prepend(
        before: "//DO-NOT-REMOVE IMPORTS_MOCK_DEFINITIONS",
        text: interfaceImport,
      ),
    ],
  );

  await replaceAllInFileLineByLine(
    filePath: mockDefinitionsFilePath(feature: feature, rootDir: rootDir),
    replacements: [
      StringReplacement.prepend(
        before: "//DO-NOT-REMOVE REPOSITORIES_MOCK_DEFINITION",
        text: templateMockClassDefinition(interfaceName),
      ),
    ],
  );
}

Future<void> _replaceInMocks({
  required HookContext context,
  required String interfaceName,
  required String feature,
  required String rootDir,
}) async {
  await ensureMocksFile(feature: feature, rootDir: rootDir);
  await replaceAllInFileLineByLine(
    filePath: mocksFilePath(feature: feature, rootDir: rootDir),
    replacements: [
      StringReplacement.prepend(
        before: "//DO-NOT-REMOVE REPOSITORIES_MOCKS_STATIC_FIELD",
        text: templateMockStaticField(interfaceName),
      ),
    ],
  );
  await replaceAllInFileLineByLine(
    filePath: mocksFilePath(feature: feature, rootDir: rootDir),
    replacements: [
      StringReplacement.prepend(
        before: "//DO-NOT-REMOVE REPOSITORIES_INIT_MOCKS",
        text: templateMockFieldInit(interfaceName),
      ),
    ],
  );
  await replaceAllInFileLineByLine(
    filePath: mocksFilePath(feature: feature, rootDir: rootDir),
    replacements: [
      StringReplacement.prepend(
        before: "//DO-NOT-REMOVE REPOSITORIES_MOCK_FALLBACK_VALUE",
        text: templateRegisterFallback(interfaceName),
      ),
    ],
  );
}
