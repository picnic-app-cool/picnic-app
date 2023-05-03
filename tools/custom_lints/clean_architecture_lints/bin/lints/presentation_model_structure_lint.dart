// This is the entrypoint of our custom linter
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:collection/collection.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

import '../utils/lint_codes.dart';
import '../utils/lint_utils.dart';

/// checks if presentation model contains proper structure
class PresentationModelStructureLint extends PluginBase {
  static const allowedPackages = [
    "bloc",
    "dartz",
    "collection",
  ];

  @override
  Stream<Lint> getLints(ResolvedUnitResult unit) async* {
    final library = unit.libraryElement;
    if (!library.source.shortName.endsWith("presentation_model.dart")) {
      return;
    }

    final modelClass = library.topLevelElements //
        .whereType<ClassElement>()
        .firstWhereOrNull((it) => it.name.endsWith("PresentationModel"));
    final constructor = modelClass //
        ?.constructors
        .firstWhereOrNull((element) => element.name == '_');
    final invalidConstructorParams =
        constructor?.parameters.where((it) => !it.isRequired || !it.isNamed || it.defaultValueCode != null) ?? [];
    if (modelClass != null) {
      if (constructor == null) {
        yield Lint(
          code: LintCodes.presentationModelStructure,
          message: 'missing a named constructor `_`',
          location: modelClass.nameLintLocation!,
          correction: "add named constructor `_` to ${modelClass.name}",
          severity: LintSeverity.error,
        );
      } else if (constructor.parameters.length != modelClass.equatableFields.length) {
        final missingFields = modelClass.equatableFields
            .where((field) => constructor.parameters.none((param) => param.name == field.name));
        yield Lint(
          code: LintCodes.presentationModelStructure,
          message: 'some fields are missing in the `_` constructor',
          location: constructor.nameLintLocation!,
          correction: "add ${missingFields.join(", ")} to the constructor",
          severity: LintSeverity.error,
        );
      }
      for (final param in invalidConstructorParams) {
        yield Lint(
          code: LintCodes.presentationModelStructure,
          message: '`${param.name}` constructor param is not marked required and/or named, or contains default value',
          location: param.nameLintLocation!,
          correction: "make `${param.name}` a required, named parameter with no default value",
          severity: LintSeverity.error,
        );
      }
      if (modelClass.getMethod("copyWith") == null) {
        yield Lint(
          code: LintCodes.presentationModelStructure,
          message: 'missing `copyWith` method',
          location: modelClass.nameLintLocation!,
          correction: "add `copyWith` method to ${modelClass.name}",
          severity: LintSeverity.error,
        );
      }
    }
  }
}
