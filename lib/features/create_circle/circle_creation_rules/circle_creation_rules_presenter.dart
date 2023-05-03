import 'package:bloc/bloc.dart';
import 'package:picnic_app/features/create_circle/circle_creation_rules/circle_creation_rules_navigator.dart';
import 'package:picnic_app/features/create_circle/circle_creation_rules/circle_creation_rules_presentation_model.dart';
import 'package:picnic_app/features/create_circle/rule_selection/rule_selection_initial_params.dart';

class CircleCreationRulesPresenter extends Cubit<CircleCreationRulesViewModel> {
  CircleCreationRulesPresenter(
    CircleCreationRulesPresentationModel model,
    this.navigator,
  ) : super(model);

  final CircleCreationRulesNavigator navigator;

  // ignore: unused_element
  CircleCreationRulesPresentationModel get _model => state as CircleCreationRulesPresentationModel;

  void onTapGo() => navigator.openCircleRuleSelection(
        RuleSelectionInitialParams(
          circle: _model.circle,
          createPostInput: _model.createPostInput,
        ),
      );
}
