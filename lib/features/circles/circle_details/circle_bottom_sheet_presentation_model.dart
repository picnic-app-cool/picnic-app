import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/circle_stats.dart';
import 'package:picnic_app/core/domain/model/get_circle_stats_failure.dart';
import 'package:picnic_app/core/utils/future_result.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/circle_details/circle_bottom_sheet_initial_params.dart';
import 'package:picnic_app/features/circles/domain/model/get_circle_details_failure.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class CircleBottomSheetPresentationModel implements CircleBottomSheetViewModel {
  /// Creates the initial state
  CircleBottomSheetPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    CircleBottomSheetInitialParams initialParams,
  )   : circleId = initialParams.circleId,
        circle = const Circle.empty(),
        circleStats = const CircleStats.empty(),
        circleDetailsResult = const FutureResult.empty(),
        circleStatsResult = const FutureResult.empty();

  /// Used for the copyWith method
  CircleBottomSheetPresentationModel._({
    required this.circleId,
    required this.circle,
    required this.circleStats,
    required this.circleDetailsResult,
    required this.circleStatsResult,
  });

  final FutureResult<Either<GetCircleDetailsFailure, Circle>> circleDetailsResult;
  final FutureResult<Either<GetCircleStatsFailure, CircleStats>> circleStatsResult;
  final Id circleId;

  @override
  final Circle circle;

  @override
  final CircleStats circleStats;

  CircleBottomSheetPresentationModel byUpdatingCircle(Circle circle) =>
      copyWith(circle: circle.copyWith(iJoined: circle.iJoined));

  CircleBottomSheetPresentationModel copyWith({
    Id? circleId,
    Circle? circle,
    CircleStats? circleStats,
    FutureResult<Either<GetCircleDetailsFailure, Circle>>? circleDetailsResult,
    FutureResult<Either<GetCircleStatsFailure, CircleStats>>? circleStatsResult,
  }) {
    return CircleBottomSheetPresentationModel._(
      circleId: circleId ?? this.circleId,
      circle: circle ?? this.circle,
      circleStats: circleStats ?? this.circleStats,
      circleDetailsResult: circleDetailsResult ?? this.circleDetailsResult,
      circleStatsResult: circleStatsResult ?? this.circleStatsResult,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class CircleBottomSheetViewModel {
  Circle get circle;

  CircleStats get circleStats;
}
