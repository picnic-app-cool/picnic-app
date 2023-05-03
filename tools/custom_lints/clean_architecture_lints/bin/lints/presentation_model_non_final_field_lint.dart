import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

import '../utils/lint_codes.dart';
import '../utils/lint_utils.dart';

/// checks whether presentationModel class
/// has all its fields final (making it immutable)
class PresentationModelNonFinalFieldLint extends PluginBase {
  @override
  Stream<Lint> getLints(ResolvedUnitResult unit) async* {
    final library = unit.libraryElement;
    if (!library.source.shortName.endsWith("presentation_model.dart")) {
      return;
    }
    final nonFinalFields = library.topLevelElements
        .whereType<ClassElement>()
        .where((element) => element.name.endsWith("PresentationModel"))
        .expand((clazz) => clazz.fields.where((field) => !field.isFinal && !field.isStatic && !field.isConst));

    if (nonFinalFields.isEmpty) {
      return;
    }

    for (final field in nonFinalFields) {
      if (field.nameLintLocation != null) {
        yield Lint(
          code: LintCodes.presentationModelNonFinalField,
          message: 'PresentationModel can have only final fields: "${field.displayName}"',
          location: field.nameLintLocation!,
          severity: LintSeverity.error,
          correction: "make ${field.name} final",
          getAnalysisErrorFixes: field.addFinalErrorFix,
        );
      }
    }
  }
}
