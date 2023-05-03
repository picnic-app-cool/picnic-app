import 'package:dartz/dartz.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/domain/model/ban_user_failure.dart';
import 'package:picnic_app/features/circles/domain/repositories/circle_moderator_actions_repository.dart';

class BanUserUseCase {
  const BanUserUseCase(this._circleModeratorActionsRepository);

  final CircleModeratorActionsRepository _circleModeratorActionsRepository;

  Future<Either<BanUserFailure, Id>> execute({
    required Id userId,
    required Id circleId,
  }) async =>
      _circleModeratorActionsRepository.banUser(circleId: circleId, userId: userId);
}
