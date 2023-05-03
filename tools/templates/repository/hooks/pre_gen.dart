import "package:mason/mason.dart";
import 'package:template_utils/template_utils.dart';

Future<void> run(HookContext context) async {
  final rootDir = projectRootDir(context.vars["root_folder_path"]);
  var interfaceName = (context.vars["interface_name"] as String? ?? "").trim().pascalCase;
  var implementationPrefix = (context.vars["implementation_prefix"] as String? ?? "").trim().pascalCase;
  final featureName = (context.vars["feature_name"] as String? ?? "").trim().snakeCase;

  if (interfaceName.isEmpty) {
    throw "Cannot use empty name for repository";
  }
  if (implementationPrefix.isEmpty) {
    throw "Cannot use empty prefix for repository implementation";
  }

  final stem = interfaceName.replaceAll("Repository", "");
  interfaceName = "${stem}Repository";
  final implementationName = "${implementationPrefix}${stem}Repository";

  final interfaceFileName = "${stem.snakeCase}_repository.dart";
  final implementationFileName = "${implementationPrefix.snakeCase}_${interfaceFileName}";

  final featurePath = featureName.isEmpty ? "core" : "features/${featureName}";
  final relativeRoot = relativeRootDir(rootDir);

  final appPackage = await getAppPackage(rootDir);
  context.vars = {
    ...context.vars,
    "app_package": appPackage,
    "stem": "${stem}",
    "interface_name": interfaceName,
    "implementation_name": implementationName,
    "interface_file_name": interfaceFileName,
    "implementation_file_name": implementationFileName,
    "interface_absolute_path": "$relativeRoot/lib/$featurePath/domain/repositories/$interfaceFileName",
    "implementation_absolute_path": "$relativeRoot/lib/$featurePath/data/$implementationFileName",
    "interface_import": "import 'package:$appPackage/$featurePath/domain/repositories/$interfaceFileName';",
    "implementation_import": "import 'package:$appPackage/$featurePath/data/$implementationFileName';",
    "feature": featureName,
    "root_dir": rootDir,
  };
  context.logger.info(
    "Generating repository, variables:\n${context.vars.entries.map((e) => "${e.key} -> ${e.value}").join("\n")}",
  );
}
