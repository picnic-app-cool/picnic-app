// This is the entrypoint of our custom linter
import 'package:analyzer/dart/analysis/results.dart';
import 'package:collection/collection.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

import '../utils/lint_codes.dart';
import '../utils/lint_utils.dart';

/// checks whether any domain class (the one that is in `domain` package) contains only allowed imports
/// from [allowedPackages] and does NOT contain any import matching anything from [forbiddenKeywords].
class ForbiddenImportInDomainLint extends PluginBase {
  static const allowedPackages = [
    "dartz",
    "collection",
    "equatable", // domain entities
    "bloc", //for stores
    "picnic_app", // for desktop app
  ];
  static const forbiddenKeywords = [
    "/data/",
    "/widgets/",
    "/ui/",
    "presenter.dart",
    "presentation_model.dart",
    "page.dart",
  ];

  @override
  Stream<Lint> getLints(ResolvedUnitResult unit) async* {
    final appPackage = packageFromUri(unit.uri.toString());

    final library = unit.libraryElement;

    if (appPackage.isEmpty || !unit.uri.toString().contains("/domain/")) {
      return;
    }

    final imports = library.nonCoreImports //
        .map((it) => MapEntry(it, it.importedLibrary))
        .where((entry) {
      final importUri = entry.value?.source.uri.toString() ?? '';
      final importPackage = packageFromUri(importUri);
      final onlyAllowedPackages = [...allowedPackages, appPackage].contains(importPackage);
      final noForbiddenImports = forbiddenKeywords.none((it) => importUri.contains(it));
      return !onlyAllowedPackages || !noForbiddenImports;
    }).toList();
    if (imports.isEmpty) {
      return;
    }

    for (final entry in imports) {
      yield Lint(
        code: LintCodes.forbiddenImportInDomain,
        message: 'domain can only import app packages or following libraries: "${allowedPackages.join(", ")}"'
            ' and cannot contain following keywords : "${forbiddenKeywords.join(", ")}"',
        location: unit.lintLocationFromOffset(
          entry.key.nameOffset,
          length: "import '${entry.key.uri}';".length,
        ),
        severity: LintSeverity.error,
        correction: "remove forbidden imports",
      );
    }
  }
}
