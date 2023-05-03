import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/circle_input.dart';
import 'package:picnic_app/features/create_circle/domain/model/create_circle_failure.dart';
import 'package:picnic_app/features/create_circle/domain/repositories/circle_creation_repository.dart';

class CreateCircleUseCase {
  const CreateCircleUseCase(this._circleCreationRepository);

  final CircleCreationRepository _circleCreationRepository;

  Future<Either<CreateCircleFailure, Circle>> execute({
    required CircleInput input,
  }) async {
    return _circleCreationRepository.createCircle(input: input);
  }
}
