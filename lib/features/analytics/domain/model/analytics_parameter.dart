enum AnalyticsParameter {
  method('method'),
  result('result'),
  target('target'),
  targetValue('target_value'),
  secondaryTargetValue('secondary_target_value');

  final String value;

  const AnalyticsParameter(this.value);
}
