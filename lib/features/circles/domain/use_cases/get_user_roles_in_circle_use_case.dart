import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/repositories/circles_repository.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/domain/model/circle_member_custom_roles.dart';
import 'package:picnic_app/features/circles/domain/model/get_user_roles_in_circle_failure.dart';

class GetUserRolesInCircleUseCase {
  const GetUserRolesInCircleUseCase(this._circlesRepository);

  final CirclesRepository _circlesRepository;

  Future<Either<GetUserRolesInCircleFailure, CircleMemberCustomRoles>> execute({
    required Id circleId,
    required Id userId,
  }) =>
      _circlesRepository.getUserRolesInCircle(
        circleId: circleId,
        userId: userId,
      );
}
