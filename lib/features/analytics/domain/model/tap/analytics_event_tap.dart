import 'package:picnic_app/features/analytics/domain/model/analytics_event.dart';
import 'package:picnic_app/features/analytics/domain/model/analytics_parameter.dart';
import 'package:picnic_app/features/analytics/domain/model/tap/analytics_tap_target.dart';

//ignore_for_file: missing_empty_constructor, missing_equatable, missing_copy_with_method, nullable_field_in_domain_entity
class AnalyticsEventTap implements AnalyticsEvent {
  const AnalyticsEventTap({
    required this.target,
    this.targetValue,
    this.secondaryTargetValue,
  });

  final AnalyticsTapTarget target;

  final dynamic targetValue;

  final dynamic secondaryTargetValue;

  @override
  String get name => 'tap';

  @override
  Map<String, Object?> get parameters => {
        AnalyticsParameter.target.value: target.value,
        if (targetValue != null) AnalyticsParameter.targetValue.value: targetValue,
        if (secondaryTargetValue != null) AnalyticsParameter.secondaryTargetValue.value: secondaryTargetValue,
      };
}
