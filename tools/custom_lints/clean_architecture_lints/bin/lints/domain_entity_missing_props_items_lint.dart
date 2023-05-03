import 'package:analyzer/dart/analysis/results.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

import '../utils/lint_codes.dart';
import '../utils/lint_utils.dart';

/// checks whether domain entity class (anything inside 'domain/model' folder except Failures)
/// has all its fields listed in the `props` list used by Equatable to generate `==` operator
class DomainEntityMissingPropsItemsLint extends PluginBase {
  @override
  Stream<Lint> getLints(ResolvedUnitResult unit) async* {
    final library = unit.libraryElement;
    if (!library.isDomainEntityFile) {
      return;
    }
    final entitiesClasses = library.domainEntitiesClasses;
    for (final clazz in entitiesClasses) {
      final props = clazz.getGetter("props");
      final propsListElems = clazz.propsListElements;
      final equatableFields = clazz.equatableFields;

      if (props != null && equatableFields.length > propsListElems.length) {
        final missingFields = equatableFields //
            .where((field) => !propsListElems.any((it) => it == field.name))
            .map((e) => e.name)
            .toList();
        yield Lint(
          code: LintCodes.missingPropsItems,
          message: 'props list is missing some fields: $missingFields',
          location: unit.lintLocationFromOffset(props.variable.nameOffset, length: props.variable.nameLength),
          severity: LintSeverity.error,
          correction: "add '${missingFields.join("', '").replaceAll(", '\$", "")} to the `props` list.",
        );
      }
    }
  }
}
