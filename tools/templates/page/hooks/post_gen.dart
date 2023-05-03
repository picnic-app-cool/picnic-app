import 'package:mason/mason.dart';
import 'package:template_utils/template_utils.dart';

Future<void> run(HookContext context) async {
  final appPackage = context.vars["app_package"] as String;
  final importPath = context.vars["import_path"] as String;
  final pageName = context.vars["page_name"] as String;
  final presenterName = context.vars["presenter_name"] as String;
  final presentationModelName = context.vars["presentation_model_name"] as String;
  final viewModelName = context.vars["view_model_name"] as String;
  final initialParamsName = context.vars["initial_params_name"] as String;
  final navigatorName = context.vars["navigator_name"] as String;
  final navigatorFileName = context.vars["navigator_file_name"] as String;
  final presentationModelFileName = context.vars["presentation_model_file_name"] as String;
  final initialParamsFileName = context.vars["initial_params_file_name"] as String;
  final presenterFileName = context.vars["presenter_file_name"] as String;
  final pageFileName = context.vars["page_file_name"] as String;
  final feature = context.vars["feature"] as String;
  final rootDir = context.vars["root_dir"] as String;

  await _replaceInMockDefinitions(
    context: context,
    appPackage: appPackage,
    importPath: importPath,
    navigatorName: navigatorName,
    viewModelName: viewModelName,
    presentationModelName: presentationModelName,
    initialParamsName: initialParamsName,
    presenterName: presenterName,
    pageName: pageName,
    navigatorFileName: navigatorFileName,
    presentationModelFileName: presentationModelFileName,
    initialParamsFileName: initialParamsFileName,
    presenterFileName: presenterFileName,
    pageFileName: pageFileName,
    feature: feature,
    rootDir: rootDir,
  );

  await _replaceInMocks(
    context: context,
    navigatorName: navigatorName,
    presentationModelName: presentationModelName,
    initialParamsName: initialParamsName,
    presenterName: presenterName,
    pageName: pageName,
    feature: feature,
    rootDir: rootDir,
  );

  await _replaceInAppComponent(
    context: context,
    appPackage: appPackage,
    importPath: importPath,
    navigatorName: navigatorName,
    viewModelName: viewModelName,
    presentationModelName: presentationModelName,
    initialParamsName: initialParamsName,
    presenterName: presenterName,
    pageName: pageName,
    navigatorFileName: navigatorFileName,
    presentationModelFileName: presentationModelFileName,
    initialParamsFileName: initialParamsFileName,
    presenterFileName: presenterFileName,
    pageFileName: pageFileName,
    feature: feature,
    rootDir: rootDir,
  );
}

Future<void> _replaceInMockDefinitions({
  required HookContext context,
  required String appPackage,
  required String importPath,
  required String navigatorName,
  required String navigatorFileName,
  required String presentationModelName,
  required String viewModelName,
  required String presentationModelFileName,
  required String initialParamsName,
  required String initialParamsFileName,
  required String presenterName,
  required String presenterFileName,
  required String pageName,
  required String pageFileName,
  required String feature,
  required String rootDir,
}) async {
  await ensureMockDefinitionsFile(feature: feature, rootDir: rootDir);
  await replaceAllInFileLineByLine(
    filePath: mockDefinitionsFilePath(feature: feature, rootDir: rootDir),
    replacements: [
      StringReplacement.prepend(
        before: "//DO-NOT-REMOVE IMPORTS_MOCK_DEFINITIONS",
        text: """
${templateImport("$appPackage/$importPath/$initialParamsFileName")}
${templateImport("$appPackage/$importPath/$navigatorFileName")}
${templateImport("$appPackage/$importPath/$presentationModelFileName")}
${templateImport("$appPackage/$importPath/$presenterFileName")}
      """,
      ),
      StringReplacement.prepend(
        before: "//DO-NOT-REMOVE MVP_MOCK_DEFINITION",
        text: """
class Mock$presenterName extends MockCubit<$viewModelName> implements $presenterName {}
${templateMockClassDefinition(presentationModelName)}
${templateMockClassDefinition(initialParamsName)}
${templateMockClassDefinition(navigatorName)}
      """,
      ),
    ],
  );
}

Future<void> _replaceInMocks({
  required HookContext context,
  required String navigatorName,
  required String presentationModelName,
  required String initialParamsName,
  required String presenterName,
  required String pageName,
  required String feature,
  required String rootDir,
}) async {
  await ensureMocksFile(feature: feature, rootDir: rootDir);
  await replaceAllInFileLineByLine(
    filePath: mocksFilePath(feature: feature, rootDir: rootDir),
    replacements: [
      StringReplacement.prepend(
        before: "//DO-NOT-REMOVE MVP_MOCKS_STATIC_FIELD",
        text: """
  ${templateMockStaticField(presenterName)}
  ${templateMockStaticField(presentationModelName)}
  ${templateMockStaticField(initialParamsName)}
  ${templateMockStaticField(navigatorName)}
      """,
      ),
      StringReplacement.prepend(
        before: "//DO-NOT-REMOVE MVP_INIT_MOCKS",
        text: """
    ${templateMockFieldInit(presenterName)}
    ${templateMockFieldInit(presentationModelName)}
    ${templateMockFieldInit(initialParamsName)}
    ${templateMockFieldInit(navigatorName)}
      """,
      ),
      StringReplacement.prepend(
        before: "//DO-NOT-REMOVE MVP_MOCK_FALLBACK_VALUE",
        text: """
    ${templateRegisterFallback(presenterName)}
    ${templateRegisterFallback(presentationModelName)}
    ${templateRegisterFallback(initialParamsName)}
    ${templateRegisterFallback(navigatorName)}
      """,
      ),
    ],
  );
}

Future<void> _replaceInAppComponent({
  required HookContext context,
  required String appPackage,
  required String importPath,
  required String navigatorName,
  required String navigatorFileName,
  required String presentationModelName,
  required String viewModelName,
  required String presentationModelFileName,
  required String initialParamsName,
  required String initialParamsFileName,
  required String presenterName,
  required String presenterFileName,
  required String pageName,
  required String pageFileName,
  required String feature,
  required String rootDir,
}) async {
  await ensureFeatureComponentFile(appPackage: appPackage, feature: feature, rootDir: rootDir);
  await replaceAllInFileLineByLine(
    filePath: featureComponentFilePath(feature: feature, rootDir: rootDir),
    replacements: [
      StringReplacement.prepend(
        before: "//DO-NOT-REMOVE APP_COMPONENT_IMPORTS",
        text: """
${templateImport("$appPackage/$importPath/$initialParamsFileName")}
${templateImport("$appPackage/$importPath/$navigatorFileName")}
${templateImport("$appPackage/$importPath/$pageFileName")}
${templateImport("$appPackage/$importPath/$presentationModelFileName")}
${templateImport("$appPackage/$importPath/$presenterFileName")}
      """,
      ),
      StringReplacement.prepend(
        before: "//DO-NOT-REMOVE MVP_GET_IT_CONFIG",
        text: """
${templateRegisterFactory(
          implementationName: navigatorName,
          params: ["getIt()"],
          useConst: false,
        )}
${templateRegisterFactoryParam(
          implementationName: presentationModelName,
          interfaceName: viewModelName,
          params: ["params"],
          param1TypeName: initialParamsName,
          param1varName: "params",
          constructorName: "initial",
          useConst: false,
        )}
${templateRegisterFactoryParam(
          implementationName: presenterName,
          params: ["getIt(param1: params)", "getIt()"],
          param1TypeName: initialParamsName,
          param1varName: "params",
          useConst: false,
        )}
      """,
      ),
    ],
  );
}
