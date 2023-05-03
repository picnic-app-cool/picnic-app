import 'package:picnic_app/features/analytics/domain/model/analytics_event.dart';
import 'package:picnic_app/features/analytics/domain/model/analytics_parameter.dart';
import 'package:picnic_app/features/analytics/domain/model/change/analytics_change_target.dart';

//ignore_for_file: missing_empty_constructor, missing_equatable, missing_copy_with_method, nullable_field_in_domain_entity
class AnalyticsEventChange implements AnalyticsEvent {
  const AnalyticsEventChange({
    required this.target,
    this.targetValue,
    this.secondaryTargetValue,
  });

  final AnalyticsChangeTarget target;

  final dynamic targetValue;

  final dynamic secondaryTargetValue;

  @override
  String get name => 'change';

  @override
  Map<String, Object?> get parameters => {
        AnalyticsParameter.target.value: target.value,
        if (targetValue != null) AnalyticsParameter.targetValue.value: targetValue,
        if (secondaryTargetValue != null) AnalyticsParameter.secondaryTargetValue.value: secondaryTargetValue,
      };
}
