import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/repositories/private_profile_repository.dart';
import 'package:picnic_app/features/profile/domain/model/get_notifications_failure.dart';
import 'package:picnic_app/features/profile/domain/model/profile_notifications/profile_notification.dart';

class GetNotificationsUseCase {
  const GetNotificationsUseCase(this._privateProfileRepository);

  final PrivateProfileRepository _privateProfileRepository;

  Future<Either<GetNotificationsFailure, PaginatedList<ProfileNotification>>> execute({
    required Cursor nextPageCursor,
    bool refresh = false,
  }) {
    if (refresh) {
      _privateProfileRepository.markAllNotificationsAsRead();
    }
    return _privateProfileRepository.getNotificationList(cursor: nextPageCursor);
  }
}
