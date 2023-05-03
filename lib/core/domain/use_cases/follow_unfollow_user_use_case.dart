import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/follow_unfollow_user_failure.dart';
import 'package:picnic_app/core/domain/repositories/users_repository.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class FollowUnfollowUserUseCase {
  const FollowUnfollowUserUseCase(this._usersRepository);

  final UsersRepository _usersRepository;

  Future<Either<FollowUnfollowUserFailure, Unit>> execute({required Id userId, required bool follow}) =>
      _usersRepository.followUnFollowUser(userId: userId, follow: follow);
}
