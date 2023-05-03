import 'package:dartz/dartz.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/domain/model/circle_custom_role_input.dart';
import 'package:picnic_app/features/circles/domain/model/create_circle_role_failure.dart';
import 'package:picnic_app/features/circles/domain/repositories/circle_moderator_actions_repository.dart';

class CreateCircleRoleUseCase {
  const CreateCircleRoleUseCase(this._circleModeratorActionsRepository);

  final CircleModeratorActionsRepository _circleModeratorActionsRepository;

  Future<Either<CreateCircleRoleFailure, Id>> execute({
    required CircleCustomRoleInput circleCustomRoleInput,
  }) =>
      _circleModeratorActionsRepository.createCircleRole(
        circleCustomRoleInput: circleCustomRoleInput,
      );
}
