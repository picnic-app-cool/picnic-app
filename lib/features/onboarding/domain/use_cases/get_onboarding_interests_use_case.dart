import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/repositories/circles_repository.dart';
import 'package:picnic_app/features/onboarding/domain/model/gender.dart';
import 'package:picnic_app/features/onboarding/domain/model/get_interests_failure.dart';
import 'package:picnic_app/features/onboarding/domain/model/interest.dart';

class GetOnBoardingInterestsUseCase {
  const GetOnBoardingInterestsUseCase(this._circlesRepository);

  final CirclesRepository _circlesRepository;

  Future<Either<GetInterestsFailure, List<Interest>>> execute(Gender gender) async =>
      _circlesRepository.getOnBoardingInterests(gender);
}
