import 'package:analyzer/dart/analysis/results.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:recase/recase.dart';

import '../utils/lint_codes.dart';

/// checks if the page file contains more top-level elements than needed
/// (only *Page and `_*PageState classes are expected)
class PageTooManyWidgetsLint extends PluginBase {
  @override
  Stream<Lint> getLints(ResolvedUnitResult unit) async* {
    final library = unit.libraryElement;
    if (!library.source.shortName.endsWith("page.dart")) {
      return;
    }
    final topMembers = library.topLevelElements.where((element) {
      final name = element.name ?? "";
      return !name.endsWith("State") && !name.endsWith(library.source.shortName.replaceAll(".dart", "").pascalCase);
    });
    for (final clazz in topMembers) {
      yield Lint(
        code: LintCodes.tooManyPageElements,
        message: "${clazz.name} should not be part of the page's source file "
            "or the element does not match the file name precisely: ${clazz.name}",
        location: clazz.nameLintLocation!,
        severity: LintSeverity.error,
        correction: "extract ${clazz.name} to separate file",
      );
    }
  }
}
