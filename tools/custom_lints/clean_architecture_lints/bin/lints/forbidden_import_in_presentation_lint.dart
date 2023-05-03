// This is the entrypoint of our custom linter
import 'package:analyzer/dart/analysis/results.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

import '../utils/lint_codes.dart';
import '../utils/lint_utils.dart';

/// checks whether any presentation class (presenter or presentationModel) contains only allowed imports
/// from [allowedPackages]
class ForbiddenImportInPresentationLint extends PluginBase {
  static const allowedPackages = [
    "bloc",
    "dartz",
    "collection",
    "picnic_app",
    "async",
  ];

  @override
  Stream<Lint> getLints(ResolvedUnitResult unit) async* {
    final library = unit.libraryElement;
    if (!library.source.shortName.endsWith("presenter.dart") &&
        !library.source.shortName.endsWith("presentation_model.dart")) {
      return;
    }

    final appPackage = packageFromUri(unit.uri.toString());
    final imports = library.nonCoreImports.map((it) => MapEntry(it, it.importedLibrary)).where((lib) {
      final package = packageFromUri(lib.value?.source.uri.toString());
      return ![...allowedPackages, appPackage].contains(package);
    }).toList();
    if (imports.isEmpty) {
      return;
    }

    for (final entry in imports) {
      yield Lint(
        code: LintCodes.forbiddenImportInPresentation,
        message:
            'presenter and presentation model can only import app packages or following libraries: "${allowedPackages.join(", ")}"',
        location: unit.lintLocationFromOffset(
          entry.key.nameOffset,
          length: "import '${entry.key.uri}';".length,
        ),
        correction: "remove forbidden imports",
        severity: LintSeverity.error,
      );
    }
  }
}
