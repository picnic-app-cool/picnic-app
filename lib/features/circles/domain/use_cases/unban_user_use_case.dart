import 'package:dartz/dartz.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/domain/model/unban_user_failure.dart';
import 'package:picnic_app/features/circles/domain/repositories/circle_moderator_actions_repository.dart';

class UnbanUserUseCase {
  const UnbanUserUseCase(this._circleModeratorUsersRepository);

  final CircleModeratorActionsRepository _circleModeratorUsersRepository;

  Future<Either<UnbanUserFailure, Id>> execute({
    required Id userId,
    required Id circleId,
  }) async =>
      _circleModeratorUsersRepository.unbanUser(circleId: circleId, userId: userId);
}
