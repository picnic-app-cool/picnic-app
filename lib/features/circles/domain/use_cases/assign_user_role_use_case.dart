import 'package:dartz/dartz.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/domain/model/assign_user_role_failure.dart';
import 'package:picnic_app/features/circles/domain/repositories/circle_moderator_actions_repository.dart';

class AssignUserRoleUseCase {
  const AssignUserRoleUseCase(this._circleModeratorActionsRepository);

  final CircleModeratorActionsRepository _circleModeratorActionsRepository;

  Future<Either<AssignUserRoleFailure, Unit>> execute({
    required Id circleId,
    required Id userId,
    required Id roleId,
  }) {
    return _circleModeratorActionsRepository.assignRole(
      circleId: circleId,
      userId: userId,
      roleId: roleId,
    );
  }
}
