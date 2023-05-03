import "package:mason/mason.dart";
import "package:template_utils/file_utils.dart";

Future<void> run(HookContext context) async {
  var useCaseName = (context.vars["use_case_name"] as String? ?? "").trim().pascalCase;
  final featureName = (context.vars["feature_name"] as String? ?? "").trim().snakeCase;

  if (useCaseName.isEmpty) {
    throw "Cannot use empty name for use case";
  }

  final rootDir = projectRootDir(context.vars["root_folder_path"]);
  final stem = useCaseName.replaceAll("UseCase", "");
  useCaseName = "${stem}UseCase";

  final failureName = "${stem}Failure";
  final useCaseFileName = "${stem.snakeCase}_use_case.dart";
  final failureFileName = "${stem.snakeCase}_failure.dart";
  final featurePath = featureName.isEmpty ? "core" : "features/${featureName}";
  final relativeRoot = relativeRootDir(rootDir);

  context.vars = {
    ...context.vars,
    "app_package": await getAppPackage(rootDir),
    "import_path": "${featurePath}",
    "stem": "${stem}",
    "failure_name": failureName,
    "use_case_name": useCaseName,
    "use_case_file_name": useCaseFileName,
    "failure_file_name": failureFileName,
    "use_case_absolute_path": "$relativeRoot/lib/${featurePath}/domain/use_cases/$useCaseFileName",
    "failure_absolute_path": "$relativeRoot/lib/${featurePath}/domain/model/$failureFileName",
    "use_case_test_absolute_path": "$relativeRoot/test/${featurePath}/domain/${stem.snakeCase}_use_case_test.dart",
    "feature": featureName,
    "root_dir": rootDir,
  };
  context.logger.info("Generating useCase, variables: ${context.vars}");
}
