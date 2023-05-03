import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/onboarding_circles_section.dart';
import 'package:picnic_app/core/domain/repositories/circles_repository.dart';
import 'package:picnic_app/features/circles/domain/model/get_onboarding_circles_failure.dart';

class GetOnBoardingCirclesUseCase {
  const GetOnBoardingCirclesUseCase(this._circlesRepository);

  final CirclesRepository _circlesRepository;

  Future<Either<GetOnBoardingCirclesFailure, List<OnboardingCirclesSection>>> execute() async =>
      _circlesRepository.getOnBoardingCircles();
}
