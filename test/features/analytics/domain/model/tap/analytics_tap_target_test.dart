import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/features/analytics/domain/model/tap/analytics_tap_target.dart';
import 'package:recase/recase.dart';

void main() {
  test(
    "parameters values should be unique",
    () async {
      final values = AnalyticsTapTarget.values.map((e) => e.value);
      expect(values.length == values.toSet().length, true);
    },
  );

  test(
    "parameters values should be snake case",
    () async {
      final values = AnalyticsTapTarget.values.map((e) => e.value);
      expect(values.every((value) => value == value.snakeCase), true);
    },
  );
}
