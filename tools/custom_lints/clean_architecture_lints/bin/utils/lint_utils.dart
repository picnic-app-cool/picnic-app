import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

/// returns the package name for given uri, for example `package:bloc/bloc.dart` will return `bloc`
String packageFromUri(String? uri) {
  if (uri == null) {
    return '';
  }
  try {
    return uri.substring(uri.indexOf(":") + 1, uri.indexOf("/"));
  } catch (ex) {
    return '';
  }
}

/// List of fields that should be part of props list for Equatable class
extension ClassElementExtensions on ClassElement {
  Iterable<FieldElement> get equatableFields =>
      fields.where((field) => !field.isStatic && !field.isAbstract && (field.getter?.isSynthetic ?? false));

  /// Returns list of all elements in the `List<Object> get props` getter
  List<String> get propsListElements {
    final props = getGetter("props");
    final data = props?.variable.source?.contents.data;
    if (data == null) {
      return [];
    }
    try {
      const startMarker = " props => [";

      final startIndex = data.indexOf(startMarker) + startMarker.length;
      final endIndex = data.indexOf('];', startIndex);

      final substring = data.substring(startIndex, endIndex);
      final variables = substring.split(",").map((e) => e.trim()).where((element) => element.isNotEmpty);
      return variables.toList();
    } catch (ex) {
      return [];
    }
  }
}

extension LibraryElementExtensions on Element {
  /// returns offset to the first character in the start line
  int get startLineOffset {
    final location = nameLintLocation;
    final unit = library?.definingCompilationUnit;
    if (location == null || unit == null) {
      return -1;
    }

    final startOfLine = unit.lineInfo.getOffsetOfLine(location.startLine - 1); // line counting starts from 1 not 0
    final indexOfFirstCharInLine = unit.source.contents.data.indexOf(RegExp(r"\S"), startOfLine);
    return indexOfFirstCharInLine == -1 ? startOfLine : indexOfFirstCharInLine;
  }

  /// prepares analysisErrorFix that adds `final` keyword at the beginning of the line for this element.
  Stream<AnalysisErrorFixes> Function(Lint lint)? get addFinalErrorFix => (lint) async* {
        final changesBuilder = ChangeBuilder(session: library!.definingCompilationUnit.session);
        await changesBuilder.addDartFileEdit(
          library!.source.fullName,
          (builder) {
            return builder.addSimpleInsertion(
              startLineOffset,
              "final ",
            );
          },
        );
        yield AnalysisErrorFixes(
          lint.asAnalysisError(),
          fixes: [
            PrioritizedSourceChange(
              3,
              changesBuilder.sourceChange..message = "Add final keyword",
            ),
          ],
        );
      };

  bool get isDomainEntityFile => library?.source.fullName.contains("domain/model") ?? false;

  bool get isTestFile => library?.source.fullName.contains("/test/") ?? false;

  bool get isDomainFile => !isTestFile && (library?.source.fullName.contains("/domain/") ?? false);

  bool get isRepositoryFile => library?.source.shortName.endsWith("repository.dart") ?? false;

  List<String> get topLevelElementNames =>
      library?.topLevelElements.map((e) => e.name ?? '').where((element) => element.isNotEmpty).toList() ?? [];

  List<ClassElement> get repositoriesInterfaces =>
      library?.topLevelElements //
          .whereType<ClassElement>()
          .where(
            (it) => [
              it.name.contains("Repository"),
              it.isAbstract,
            ].every((it) => it),
          )
          .toList() ??
      [];

  bool get isDataFile => !isTestFile && (library?.source.fullName.contains("/data/") ?? false);

  bool get isFailureFile => library?.source.shortName.endsWith("failure.dart") ?? false;

  List<ClassElement> get domainEntitiesClasses =>
      library?.topLevelElements //
          .whereType<ClassElement>()
          .where(
            (it) => [
              !it.name.endsWith("Failure"),
              !it.isDartCoreEnum,
              !it.isAbstract,
            ].every((it) => it),
          )
          .toList() ??
      [];

  Iterable<LibraryImportElement> get nonCoreImports =>
      library?.libraryImports.where((element) {
        final lib = element.importedLibrary;
        if (lib == null) {
          return false;
        }
        return !lib.isDartAsync && //
            !lib.isDartCore &&
            !lib.isInSdk;
      }) ??
      [];
}
