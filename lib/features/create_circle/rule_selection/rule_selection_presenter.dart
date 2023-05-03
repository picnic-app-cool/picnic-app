import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/model/circle_moderation_type.dart';
import 'package:picnic_app/core/domain/use_cases/update_circle_use_case.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/create_circle/rule_selection/rule_selection_navigator.dart';
import 'package:picnic_app/features/create_circle/rule_selection/rule_selection_presentation_model.dart';
import 'package:picnic_app/features/seeds/about_elections/about_elections_initial_params.dart';

class RuleSelectionPresenter extends Cubit<RuleSelectionViewModel> {
  RuleSelectionPresenter(
    RuleSelectionPresentationModel model,
    this.navigator,
    this._updateCircleUseCase,
  ) : super(model);

  final RuleSelectionNavigator navigator;
  final UpdateCircleUseCase _updateCircleUseCase;

  // ignore: unused_element
  RuleSelectionPresentationModel get _model => state as RuleSelectionPresentationModel;

  void onTapConfirm() => _updateCircleUseCase
      .execute(input: _model.updateCircleInput) //
      .observeStatusChanges(
        (result) => tryEmit(_model.copyWith(updateCircleFutureResult: result)),
      )
      .doOn(
        fail: (fail) => navigator.showError(fail.displayableFailure()),
        success: (circle) => navigator.openAboutElections(
          AboutElectionsInitialParams(
            circle: circle,
            createPostInput: _model.createPostInput,
            createCircleWithoutPost: false,
          ),
        ),
      );

  void onDecisionChanged(CircleModerationType value) {
    tryEmit(_model.byUpdatingModerationType(value));
  }
}
