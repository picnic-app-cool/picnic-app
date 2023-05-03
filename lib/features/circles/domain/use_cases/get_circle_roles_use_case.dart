import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/repositories/circles_repository.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/domain/model/circle_custom_role.dart';
import 'package:picnic_app/features/circles/domain/model/get_circle_roles_failure.dart';

class GetCircleRolesUseCase {
  const GetCircleRolesUseCase(this._circlesRepository);

  final CirclesRepository _circlesRepository;

  Future<Either<GetCircleRolesFailure, PaginatedList<CircleCustomRole>>> execute({
    required Id circleId,
  }) async =>
      _circlesRepository.getCircleRoles(
        circleId: circleId,
      );
}
