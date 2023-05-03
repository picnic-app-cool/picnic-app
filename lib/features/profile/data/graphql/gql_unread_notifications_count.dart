import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/features/profile/domain/model/unread_notifications_count.dart';

class GqlUnreadNotificationsCount {
  const GqlUnreadNotificationsCount({
    required this.count,
  });

  factory GqlUnreadNotificationsCount.fromJson(
    Map<String, dynamic> json,
  ) {
    return GqlUnreadNotificationsCount(
      count: asT<int>(json, 'count'),
    );
  }

  final int count;

  UnreadNotificationsCount toDomain() => UnreadNotificationsCount(
        count: count,
      );
}
