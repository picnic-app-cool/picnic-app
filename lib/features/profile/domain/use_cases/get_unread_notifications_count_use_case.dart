import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/repositories/private_profile_repository.dart';
import 'package:picnic_app/features/profile/domain/model/get_unread_notifications_count_failure.dart';
import 'package:picnic_app/features/profile/domain/model/unread_notifications_count.dart';

class GetUnreadNotificationsCountUseCase {
  const GetUnreadNotificationsCountUseCase(this._privateProfileRepository);

  final PrivateProfileRepository _privateProfileRepository;

  Future<Either<GetUnreadNotificationsCountFailure, UnreadNotificationsCount>> execute() async {
    return _privateProfileRepository.getUnreadNotificationsCount();
  }
}
