import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/join_circle_failure.dart';
import 'package:picnic_app/core/domain/repositories/circles_repository.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class JoinCirclesUseCase {
  const JoinCirclesUseCase(this._circlesRepository);

  final CirclesRepository _circlesRepository;

  Future<Either<JoinCircleFailure, Unit>> execute({
    required List<Id> circleIds,
  }) async {
    return _circlesRepository.joinCircles(circleIds: circleIds);
  }
}
