import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/update_circle_input.dart';
import 'package:picnic_app/features/circles/edit_rules/edit_rules_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class EditRulesPresentationModel implements EditRulesViewModel {
  /// Creates the initial state
  EditRulesPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    EditRulesInitialParams initialParams,
  )   : circle = initialParams.circle,
        updateCircleInput = UpdateCircleInput.updateRulesTextForCircle(initialParams.circle);

  /// Used for the copyWith method
  EditRulesPresentationModel._({
    required this.updateCircleInput,
    required this.circle,
  });

  final Circle circle;
  final UpdateCircleInput updateCircleInput;

  @override
  String get rules => circle.rulesText;

  EditRulesViewModel byUpdatingRulesText(String rules) => copyWith(
        updateCircleInput: updateCircleInput.byUpdatingRulesText(rules),
      );

  EditRulesPresentationModel copyWith({
    UpdateCircleInput? updateCircleInput,
    Circle? circle,
  }) {
    return EditRulesPresentationModel._(
      updateCircleInput: updateCircleInput ?? this.updateCircleInput,
      circle: circle ?? this.circle,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class EditRulesViewModel {
  String get rules;
}
