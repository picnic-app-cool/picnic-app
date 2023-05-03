import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/features/analytics/domain/model/analytics_parameter.dart';
import 'package:recase/recase.dart';

void main() {
  test(
    "parameters should be unique",
    () async {
      final values = AnalyticsParameter.values.map((e) => e.value);
      expect(values.length == values.toSet().length, true);
    },
  );

  test(
    "parameters should be snake case",
    () async {
      final values = AnalyticsParameter.values.map((e) => e.value);
      expect(values.every((value) => value == value.snakeCase), true);
    },
  );
}
