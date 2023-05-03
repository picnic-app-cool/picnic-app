import 'package:picnic_app/features/analytics/domain/model/analytics_operation_result.dart';
import 'package:picnic_app/features/analytics/domain/model/change/analytics_change_target.dart';
import 'package:picnic_app/features/analytics/domain/model/change/analytics_event_change.dart';
import 'package:picnic_app/features/analytics/domain/model/login/analytics_event_login.dart';
import 'package:picnic_app/features/analytics/domain/model/post_viewing_time/analytics_event_post_viewing_time.dart';
import 'package:picnic_app/features/analytics/domain/model/tap/analytics_event_tap.dart';
import 'package:picnic_app/features/analytics/domain/model/tap/analytics_tap_target.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/onboarding/domain/model/credentials/log_in_type.dart';

abstract class AnalyticsEvent {
  factory AnalyticsEvent.login({
    required LogInType logInType,
    required AnalyticsOperationResult result,
  }) =>
      AnalyticsEventLogin(
        logInType: logInType,
        result: result,
      );

  /// User pressed a button or tapped any another element they can interact with.
  factory AnalyticsEvent.tap({
    required AnalyticsTapTarget target,
    dynamic targetValue,
    dynamic secondaryTargetValue,
  }) =>
      AnalyticsEventTap(
        target: target,
        targetValue: targetValue,
        secondaryTargetValue: secondaryTargetValue,
      );

  /// Some action that happened as a result of user action, e.g. a page changed as a result of user's swipe gesture.
  factory AnalyticsEvent.change({
    required AnalyticsChangeTarget target,
    dynamic targetValue,
    dynamic secondaryTargetValue,
  }) =>
      AnalyticsEventChange(
        target: target,
        targetValue: targetValue,
        secondaryTargetValue: secondaryTargetValue,
      );

  factory AnalyticsEvent.postViewingTime({
    required Id postId,
    required Id userId,
    required int durationMilliseconds,
  }) =>
      AnalyticsEventPostViewingTime(
        postId: postId,
        userId: userId,
        durationMilliseconds: durationMilliseconds,
      );

  String get name;

  Map<String, Object?> get parameters;
}
