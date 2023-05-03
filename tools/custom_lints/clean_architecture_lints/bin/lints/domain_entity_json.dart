import 'package:analyzer/dart/analysis/results.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

import '../utils/lint_codes.dart';
import '../utils/lint_utils.dart';

/// checks whether domain entity class contains toJson/fromJson
class DomainEntityJsonLint extends PluginBase {
  @override
  Stream<Lint> getLints(ResolvedUnitResult unit) async* {
    final library = unit.libraryElement;
    if (!library.isDomainEntityFile) {
      return;
    }
    final invalidNames = ["tojson", "fromjson"];
    final entitiesClasses = library.domainEntitiesClasses;
    for (final clazz in entitiesClasses) {
      final invalidMethods = clazz.methods.where((it) => invalidNames.contains(it.name.trim().toLowerCase()));
      final invalidConstructors = clazz.constructors.where((it) => invalidNames.contains(it.name.trim().toLowerCase()));

      for (final field in [...invalidMethods, ...invalidConstructors]) {
        if (field.nameLintLocation != null) {
          yield Lint(
            code: LintCodes.domainJson,
            message: 'domain entity contains fromJson/toJson, but its not its responsibility',
            location: field.nameLintLocation!,
            severity: LintSeverity.error,
            correction: "use data layer models for jsons instead",
          );
        }
      }
    }
  }
}
