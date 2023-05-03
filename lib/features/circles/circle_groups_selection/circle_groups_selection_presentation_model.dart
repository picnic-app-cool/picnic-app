import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/group_with_circles.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/features/circles/circle_groups_selection/circle_groups_selection_initial_params.dart';
import 'package:picnic_app/features/circles/circle_groups_selection/model/selectable_circle_group.dart';
import 'package:picnic_app/features/circles/domain/model/get_groups_of_circles_failure.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class CircleGroupsSelectionPresentationModel implements CircleGroupsSelectionViewModel {
  /// Creates the initial state
  CircleGroupsSelectionPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    CircleGroupsSelectionInitialParams initialParams,
  )   : getGroupingsResult = const FutureResult.empty(),
        selectedCircleGroup = SelectableCircleGroup.fromCircleGroup(
          const GroupWithCircles.empty(),
        );

  /// Used for the copyWith method
  CircleGroupsSelectionPresentationModel._({
    required this.getGroupingsResult,
    required this.selectedCircleGroup,
  });

  final FutureResult<Either<GetGroupsOfCirclesFailure, List<SelectableCircleGroup>>> getGroupingsResult;

  final SelectableCircleGroup selectedCircleGroup;

  @override
  List<SelectableCircleGroup> get circleGroups => getGroupingsResult.getSuccess() ?? [];

  @override
  bool get isLoading => getGroupingsResult.isPending();

  CircleGroupsSelectionPresentationModel copyWith({
    FutureResult<Either<GetGroupsOfCirclesFailure, List<SelectableCircleGroup>>>? getGroupingsResult,
    SelectableCircleGroup? selectedCircleGroup,
  }) {
    return CircleGroupsSelectionPresentationModel._(
      getGroupingsResult: getGroupingsResult ?? this.getGroupingsResult,
      selectedCircleGroup: selectedCircleGroup ?? this.selectedCircleGroup,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class CircleGroupsSelectionViewModel {
  List<SelectableCircleGroup> get circleGroups;

  bool get isLoading;
}
