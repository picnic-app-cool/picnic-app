import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/circle_stats.dart';
import 'package:picnic_app/core/domain/model/get_circle_stats_failure.dart';
import 'package:picnic_app/core/domain/repositories/circles_repository.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class GetCircleStatsUseCase {
  const GetCircleStatsUseCase(
    this._circlesRepository,
  );

  final CirclesRepository _circlesRepository;

  Future<Either<GetCircleStatsFailure, CircleStats>> execute({
    required Id circleId,
  }) {
    return _circlesRepository.getCircleStats(circleId: circleId);
  }
}
