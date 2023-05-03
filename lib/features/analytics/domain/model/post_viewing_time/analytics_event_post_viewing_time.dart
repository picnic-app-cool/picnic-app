import 'package:picnic_app/features/analytics/domain/model/analytics_event.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

//ignore_for_file: missing_empty_constructor, missing_equatable, missing_copy_with_method, nullable_field_in_domain_entity
class AnalyticsEventPostViewingTime implements AnalyticsEvent {
  const AnalyticsEventPostViewingTime({
    required this.postId,
    required this.userId,
    required this.durationMilliseconds,
  });

  static const eventName = 'post_viewing_time';
  final Id postId;
  final Id userId;
  final int durationMilliseconds;

  @override
  String get name => eventName;

  @override
  Map<String, Object?> get parameters => {
        'post_id': postId.value,
        'user_id': userId.value,
        'duration': durationMilliseconds,
      };
}
