import 'package:dartz/dartz.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/domain/model/un_assign_user_role_failure.dart';
import 'package:picnic_app/features/circles/domain/repositories/circle_moderator_actions_repository.dart';

class UnAssignUserRoleUseCase {
  const UnAssignUserRoleUseCase(this._circleModeratorActionsRepository);

  final CircleModeratorActionsRepository _circleModeratorActionsRepository;

  Future<Either<UnAssignUserRoleFailure, Unit>> execute({
    required Id circleId,
    required Id userId,
    required Id roleId,
  }) {
    return _circleModeratorActionsRepository.unAssignRole(
      circleId: circleId,
      userId: userId,
      roleId: roleId,
    );
  }
}
