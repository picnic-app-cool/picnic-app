import 'package:analyzer/dart/analysis/results.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

import '../utils/lint_codes.dart';
import '../utils/lint_utils.dart';

/// checks whether domain entity class (anything inside 'domain/model' folder except Failures)
/// extemds Equatable
class DomainEntityMissingEquatableLint extends PluginBase {
  @override
  Stream<Lint> getLints(ResolvedUnitResult unit) async* {
    final library = unit.libraryElement;
    if (!library.isDomainEntityFile) {
      return;
    }
    final entitiesClasses = library.domainEntitiesClasses;
    for (final clazz in entitiesClasses) {
      if (!clazz.allSupertypes.any((it) => it.element.name == 'Equatable' || it.element.name == 'EquatableMixin')) {
        yield Lint(
          code: LintCodes.missingEquatable,
          message: 'Domain entity is not extending Equatable',
          location: clazz.nameLintLocation!,
          severity: LintSeverity.error,
          correction: "make ${clazz.name} extend from Equatable",
        );
      }
    }
  }
}
