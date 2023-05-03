import 'package:mason/mason.dart';
import 'package:template_utils/template_utils.dart';

Future<void> run(HookContext context) async {
  try {
    final useCaseName = context.vars["use_case_name"] as String;
    final failureName = context.vars["failure_name"] as String;
    final importPath = context.vars["import_path"] as String;
    final useCaseFileName = context.vars["use_case_file_name"] as String;
    final failureFileName = context.vars["failure_file_name"] as String;
    final appPackage = context.vars["app_package"] as String;
    final feature = context.vars["feature"] as String;
    final rootDir = context.vars["root_dir"] as String;

    context.logger.info("Modifying mock definitions...");
    await _replaceInMockDefinitions(
      context: context,
      appPackage: appPackage,
      importPath: importPath,
      useCaseName: useCaseName,
      failureName: failureName,
      useCaseFileName: useCaseFileName,
      failureFileName: failureFileName,
      feature: feature,
      rootDir: rootDir,
    );

    context.logger.info("Modifying mocks...");
    await _replaceInMocks(
      context: context,
      useCaseName: useCaseName,
      failureName: failureName,
      feature: feature,
      rootDir: rootDir,
    );

    context.logger.info("Modifying feature component...");
    await _replaceInAppComponent(
      context: context,
      useCaseName: useCaseName,
      importPath: importPath,
      useCaseFileName: useCaseFileName,
      failureFileName: failureFileName,
      appPackage: appPackage,
      feature: feature,
      rootDir: rootDir,
    );
  } catch (ex, stack) {
    context.logger.err("$ex\n$stack");
  }
}

Future<void> _replaceInAppComponent({
  required HookContext context,
  required String useCaseName,
  required String importPath,
  required String useCaseFileName,
  required String failureFileName,
  required String appPackage,
  required String feature,
  required String rootDir,
}) async {
  await ensureFeatureComponentFile(appPackage: appPackage, feature: feature, rootDir: rootDir);
  await replaceAllInFileLineByLine(
    filePath: featureComponentFilePath(feature: feature, rootDir: rootDir),
    replacements: [
      StringReplacement.prepend(
        before: "//DO-NOT-REMOVE USE_CASES_GET_IT_CONFIG",
        text: templateRegisterFactory(implementationName: useCaseName),
      ),
      StringReplacement.prepend(
        before: "//DO-NOT-REMOVE APP_COMPONENT_IMPORTS",
        text: templateImport("$appPackage/$importPath/domain/use_cases/$useCaseFileName"),
      ),
    ],
  );
}

Future<void> _replaceInMockDefinitions({
  required HookContext context,
  required String appPackage,
  required String importPath,
  required String useCaseName,
  required String useCaseFileName,
  required String failureName,
  required String failureFileName,
  required String feature,
  required String rootDir,
}) async {
  await ensureMockDefinitionsFile(feature: feature, context: context, rootDir: rootDir);
  await replaceAllInFileLineByLine(
    filePath: mockDefinitionsFilePath(feature: feature, rootDir: rootDir),
    replacements: [
      StringReplacement.prepend(
        before: "//DO-NOT-REMOVE IMPORTS_MOCK_DEFINITIONS",
        text: """
${templateImport("$appPackage/$importPath/domain/use_cases/$useCaseFileName")}
${templateImport("$appPackage/$importPath/domain/model/$failureFileName")}
      """,
      ),
      StringReplacement.prepend(
        before: "//DO-NOT-REMOVE USE_CASE_MOCK_DEFINITION",
        text: """
${templateMockClassDefinition(failureName)}
${templateMockClassDefinition(useCaseName)}
      """,
      ),
    ],
  );
}

Future<void> _replaceInMocks({
  required HookContext context,
  required String useCaseName,
  required String failureName,
  required String feature,
  required String rootDir,
}) async {
  await ensureMocksFile(feature: feature, rootDir: rootDir);

  await replaceAllInFileLineByLine(
    filePath: mocksFilePath(feature: feature, rootDir: rootDir),
    replacements: [
      StringReplacement.prepend(
        before: "//DO-NOT-REMOVE USE_CASE_MOCKS_STATIC_FIELD",
        text: """
        ${templateMockStaticField(failureName)}
        ${templateMockStaticField(useCaseName)}
      """,
      ),
      StringReplacement.prepend(
        before: "//DO-NOT-REMOVE USE_CASE_INIT_MOCKS",
        text: """
        ${templateMockFieldInit(failureName)}
        ${templateMockFieldInit(useCaseName)}
      """,
      ),
      StringReplacement.prepend(
        before: "//DO-NOT-REMOVE USE_CASE_MOCK_FALLBACK_VALUE",
        text: """
        ${templateRegisterFallback(failureName)}
        ${templateRegisterFallback(useCaseName)}
      """,
      ),
    ],
  );
}
