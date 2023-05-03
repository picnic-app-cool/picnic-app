import 'package:analyzer/dart/analysis/results.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

import '../utils/lint_codes.dart';

/// prevents from using `DateTime.now` anywhere in the code
class DontUseDateTimeNowLint extends PluginBase {
  //ignore: no_date_time_now
  final forbiddenText = "DateTime.now()";

  @override
  Stream<Lint> getLints(ResolvedUnitResult unit) async* {
    final library = unit.libraryElement;
    final source = library.source.contents.data;

    var index = 0;
    final locations = <LintLocation>[];
    while (index != -1) {
      index = source.indexOf(forbiddenText, index + 1);
      if (index != -1) {
        locations.add(unit.lintLocationFromOffset(index, length: forbiddenText.length));
      }
    }
    for (final location in locations) {
      yield Lint(
        code: LintCodes.noDateTimeNow,
        message: "Don't use $forbiddenText in code, use `CurrentTimeProvider` instead",
        location: location,
        severity: LintSeverity.error,
        correction: "Use `CurrentTimeProvider` instead",
      );
    }
  }
}
