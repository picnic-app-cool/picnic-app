import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/repositories/circles_repository.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/onboarding/domain/model/get_circles_for_interests_failure.dart';

class GetCirclesForInterestsUseCase {
  const GetCirclesForInterestsUseCase(this._circlesRepository);

  final CirclesRepository _circlesRepository;

  Future<Either<GetCirclesForInterestsFailure, List<Id>>> execute(List<Id> interestsListId) async =>
      _circlesRepository.getCirclesForInterests(interestsListId);
}
