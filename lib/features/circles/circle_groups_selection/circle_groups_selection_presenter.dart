import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/model/basic_circle.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/core/presentation/model/selectable.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/features/circles/circle_groups_selection/circle_groups_selection_navigator.dart';
import 'package:picnic_app/features/circles/circle_groups_selection/circle_groups_selection_presentation_model.dart';
import 'package:picnic_app/features/circles/circle_groups_selection/model/selectable_circle_group.dart';
import 'package:picnic_app/features/onboarding/domain/model/list_groups_input.dart';
import 'package:picnic_app/features/onboarding/domain/use_cases/get_groups_with_circles_use_case.dart';

class CircleGroupsSelectionPresenter extends Cubit<CircleGroupsSelectionViewModel> {
  CircleGroupsSelectionPresenter(
    CircleGroupsSelectionPresentationModel model,
    this.navigator,
    this._getCircleGroupingsUseCase,
  ) : super(model);

  final CircleGroupsSelectionNavigator navigator;
  final GetGroupsWithCirclesUseCase _getCircleGroupingsUseCase;

  // ignore: unused_element
  CircleGroupsSelectionPresentationModel get _model => state as CircleGroupsSelectionPresentationModel;

  void onInit() => _getGroupings();

  void onTapCircle(Selectable<BasicCircle> circle, SelectableCircleGroup group) => notImplemented();

  void onTapCircleGrouping(SelectableCircleGroup value) {
    tryEmit(
      _model.copyWith(
        selectedCircleGroup: value,
      ),
    );
    navigator.closeWithResult(value);
  }

  void _getGroupings() => _getCircleGroupingsUseCase
      .execute(
        listGroupsInput: const ListGroupsInput(isWithCircles: true),
      )
      .observeStatusChanges(
        (result) => tryEmit(
          _model.copyWith(
            getGroupingsResult: result.mapSuccess(
              (success) => success.toSelectableCircleGroupList(),
            ),
          ),
        ),
      );
}
