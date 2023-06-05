import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/get_circle_by_name_failure.dart';
import 'package:picnic_app/core/domain/repositories/circles_repository.dart';

class GetCircleByNameUseCase {
  const GetCircleByNameUseCase(this._circlesRepository);

  final CirclesRepository _circlesRepository;

  Future<Either<GetCircleByNameFailure, Circle>> execute({
    required String name,
  }) =>
      _circlesRepository.getCircleByName(name: name);
}
