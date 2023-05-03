import 'package:picnic_app/features/analytics/domain/model/analytics_event.dart';
import 'package:picnic_app/features/analytics/domain/model/analytics_operation_result.dart';
import 'package:picnic_app/features/analytics/domain/model/analytics_parameter.dart';
import 'package:picnic_app/features/onboarding/domain/model/credentials/log_in_type.dart';

//ignore_for_file: missing_empty_constructor, missing_equatable, missing_copy_with_method
class AnalyticsEventLogin implements AnalyticsEvent {
  const AnalyticsEventLogin({required this.logInType, required this.result});

  final LogInType logInType;

  final AnalyticsOperationResult result;

  @override
  String get name => 'login';

  @override
  Map<String, Object?> get parameters => {
        AnalyticsParameter.method.value: logInType.value,
        AnalyticsParameter.result.value: result.value,
      };
}
