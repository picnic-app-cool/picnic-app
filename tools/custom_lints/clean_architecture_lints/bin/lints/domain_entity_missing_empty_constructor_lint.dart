import 'package:analyzer/dart/analysis/results.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

import '../utils/lint_codes.dart';
import '../utils/lint_utils.dart';

/// checks whether any domain entity class (anything inside 'domain/model' folder except Failures)
/// contains the non-parametrized named constructor called 'empty' that creates
/// empty instance of the class with default values
class DomainEntityMissingEmptyConstructorLint extends PluginBase {
  @override
  Stream<Lint> getLints(ResolvedUnitResult unit) async* {
    final library = unit.libraryElement;
    if (!library.isDomainEntityFile) {
      return;
    }
    final entitiesClasses = library.domainEntitiesClasses;
    for (final clazz in entitiesClasses) {
      final constructor = clazz.getNamedConstructor("empty");
      if (constructor == null) {
        yield Lint(
          code: LintCodes.missingEmptyConstructor,
          message: 'Domain entity is missing "empty" constructor',
          location: clazz.nameLintLocation!,
          severity: LintSeverity.error,
        );
      } else if (constructor.parameters.isNotEmpty) {
        yield Lint(
          code: LintCodes.emptyConstructorContainsParams,
          message: '"empty" constructor contains params, but it shouldn\'t have any',
          location: constructor.nameLintLocation!,
          severity: LintSeverity.error,
          correction: "Add a non-parametrized, named constructor 'empty()'"
              " that sets all fields to their default values "
              "like 0, null, '' or \$CLASS_NAME\$.empty()",
        );
      }
    }
  }
}
