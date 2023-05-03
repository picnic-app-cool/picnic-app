import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

import '../utils/lint_codes.dart';

/// checks whether a useCase class contains only one public accessor, a method, called 'execute'
class UseCaseMultipleAccessorsLint extends PluginBase {
  @override
  Stream<Lint> getLints(ResolvedUnitResult unit) async* {
    final library = unit.libraryElement;
    if (!library.source.shortName.endsWith("use_case.dart")) {
      return;
    }
    final useCaseClass = library.topLevelElements.whereType<ClassElement>().first;
    final publicFields = useCaseClass.fields.where((element) => element.isPublic && !element.isConst);
    final publicMethods = useCaseClass.methods.where((element) => element.isPublic);
    final publicAccessors = useCaseClass.accessors.where((element) => element.isPublic);

    for (final field in publicFields) {
      if (field.nameLintLocation != null) {
        yield Lint(
          code: LintCodes.publicFieldInUseCase,
          message: 'use case cannot expose public fields, only one execute() method',
          location: field.nameLintLocation!,
          severity: LintSeverity.error,
        );
      }
    }
    for (final method in publicMethods) {
      if (method.name != "execute") {
        yield Lint(
          code: LintCodes.publicMethodInUseCase,
          message: 'use case can only expose one public method called "execute"',
          location: method.nameLintLocation!,
          severity: LintSeverity.error,
          correction: "remove or rename ${method.name} to 'execute'",
        );
      }
    }
    for (final accessor in publicAccessors) {
      if (accessor.nameLintLocation != null) {
        yield Lint(
          code: LintCodes.publicAccessorInUseCase,
          message: 'use case cannot expose public getters/setters, only one execute() method',
          location: accessor.nameLintLocation!,
          severity: LintSeverity.error,
        );
      }
    }
  }
}
