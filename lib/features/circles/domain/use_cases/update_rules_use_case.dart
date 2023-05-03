import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/update_circle_failure.dart';
import 'package:picnic_app/core/domain/model/update_circle_input.dart';
import 'package:picnic_app/core/domain/repositories/circles_repository.dart';

class UpdateRulesUseCase {
  const UpdateRulesUseCase(
    this._circlesRepository,
  );
  final CirclesRepository _circlesRepository;

  Future<Either<UpdateCircleFailure, Circle>> execute({
    required UpdateCircleInput input,
  }) async {
    return _circlesRepository.updateCircle(input: input);
  }
}
