import 'package:analyzer/dart/analysis/results.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

import '../utils/lint_codes.dart';
import '../utils/lint_utils.dart';

/// checks whether domain entity class (anything inside 'domain/model' folder except Failures)
/// has all its fields final (making it immutable)
class DomainEntityNonFinalFields extends PluginBase {
  @override
  Stream<Lint> getLints(ResolvedUnitResult unit) async* {
    final library = unit.libraryElement;
    if (!library.isDomainEntityFile) {
      return;
    }
    final entitiesClasses = library.domainEntitiesClasses;
    for (final clazz in entitiesClasses) {
      final invalidFields = clazz.fields.where((it) => !it.isFinal && !it.isStatic && !it.isConst);

      for (final field in invalidFields) {
        if (field.nameLintLocation != null) {
          yield Lint(
            code: LintCodes.nonFinalFieldInDomainEntity,
            message: 'non-final field in domain entity',
            location: field.nameLintLocation!,
            severity: LintSeverity.error,
            correction: "make '${field.name}' field final",
            getAnalysisErrorFixes: field.addFinalErrorFix,
          );
        }
      }
    }
  }
}
