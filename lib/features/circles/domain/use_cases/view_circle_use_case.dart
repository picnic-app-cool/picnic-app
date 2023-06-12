import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/repositories/circles_repository.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/domain/model/view_circle_failure.dart';

class ViewCircleUseCase {
  const ViewCircleUseCase(this._circlesRepository);

  final CirclesRepository _circlesRepository;

  Future<Either<ViewCircleFailure, Unit>> execute({
    required Id circleId,
  }) =>
      _circlesRepository.viewCircle(
        circleId: circleId,
      );
}
