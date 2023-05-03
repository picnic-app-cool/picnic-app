import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/repositories/circles_repository.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/domain/model/get_circle_details_failure.dart';

class GetCircleDetailsUseCase {
  const GetCircleDetailsUseCase(this._circlesRepository);

  final CirclesRepository _circlesRepository;

  Future<Either<GetCircleDetailsFailure, Circle>> execute({required Id circleId}) async {
    return _circlesRepository.getCircleDetails(circleId: circleId);
  }
}
