import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/repositories/circles_repository.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/domain/model/delete_role_failure.dart';

class DeleteRoleUseCase {
  const DeleteRoleUseCase(this._circlesRepository);

  final CirclesRepository _circlesRepository;

  Future<Either<DeleteRoleFailure, Unit>> execute({
    required Id roleId,
    required Id circleId,
  }) =>
      _circlesRepository.deleteCircleRole(
        roleId: roleId,
        circleId: circleId,
      );
}
