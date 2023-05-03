import 'package:dartz/dartz.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/domain/model/circle_custom_role_update_input.dart';
import 'package:picnic_app/features/circles/domain/model/update_circle_role_failure.dart';
import 'package:picnic_app/features/circles/domain/repositories/circle_moderator_actions_repository.dart';

class UpdateCircleRoleUseCase {
  const UpdateCircleRoleUseCase(this._circleModeratorActionsRepository);

  final CircleModeratorActionsRepository _circleModeratorActionsRepository;

  Future<Either<UpdateCircleRoleFailure, Id>> execute({
    required CircleCustomRoleUpdateInput circleCustomRoleUpdateInput,
  }) =>
      _circleModeratorActionsRepository.updateCircleRole(
        circleCustomRoleUpdateInput: circleCustomRoleUpdateInput,
      );
}
