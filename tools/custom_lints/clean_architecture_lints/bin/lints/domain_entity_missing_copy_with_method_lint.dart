import 'package:analyzer/dart/analysis/results.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

import '../utils/lint_codes.dart';
import '../utils/lint_utils.dart';

/// checks whether any domain entity class (anything inside 'domain/model' folder except Failures)
/// contains the 'copyWith' method
class DomainEntityMissingCopyWithMethodLint extends PluginBase {
  @override
  Stream<Lint> getLints(ResolvedUnitResult unit) async* {
    final library = unit.libraryElement;
    if (!library.isDomainEntityFile) {
      return;
    }
    final entitiesClasses = library.domainEntitiesClasses;
    for (final clazz in entitiesClasses) {
      final equatableFields = clazz.equatableFields;
      final missingCopyWith = clazz.getMethod("copyWith") == null;

      if (equatableFields.isNotEmpty && missingCopyWith) {
        yield Lint(
          code: LintCodes.missingCopyWithMethod,
          message: 'Domain entity is missing "copyWith" method: "${clazz.displayName}"',
          location: clazz.nameLintLocation!,
          severity: LintSeverity.error,
          correction: "Add a copyWith method, ideally generated with"
              " VSCode plugin (Dart Data Class Generator)"
              " or IntelliJ Plugin (Dart Data Class)",
        );
      }
    }
  }
}
