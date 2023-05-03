import 'package:analyzer/dart/analysis/results.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

import '../utils/lint_codes.dart';
import '../utils/lint_utils.dart';

/// check for invalid naming in various classes
class InvalidNamingLint extends PluginBase {
  @override
  Stream<Lint> getLints(ResolvedUnitResult unit) async* {
    final library = unit.libraryElement;
    if (library.topLevelElementNames.any((it) => it.endsWith('Impl'))) {
      yield Lint(
        code: LintCodes.invalidName,
        message: 'never use Impl suffix in names: https://octoperf.com/blog/2016/10/27/impl-classes-are-evil/',
        location: unit.lintLocationFromLines(startLine: 1, endLine: 1),
        severity: LintSeverity.error,
        correction: "remove `Impl` suffix",
      );
    }
  }
}
