import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/group_with_circles.dart';
import 'package:picnic_app/core/domain/repositories/circles_repository.dart';
import 'package:picnic_app/features/circles/domain/model/get_groups_of_circles_failure.dart';
import 'package:picnic_app/features/onboarding/domain/model/list_groups_input.dart';

class GetGroupsWithCirclesUseCase {
  const GetGroupsWithCirclesUseCase(this._circlesRepository);

  final CirclesRepository _circlesRepository;

  Future<Either<GetGroupsOfCirclesFailure, List<GroupWithCircles>>> execute({
    required ListGroupsInput listGroupsInput,
  }) async =>
      _circlesRepository.getGroupsOfCircles(listGroupsInput: listGroupsInput);
}
