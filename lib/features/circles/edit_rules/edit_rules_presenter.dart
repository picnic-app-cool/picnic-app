import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/circles/domain/use_cases/update_rules_use_case.dart';
import 'package:picnic_app/features/circles/edit_rules/edit_rules_navigator.dart';
import 'package:picnic_app/features/circles/edit_rules/edit_rules_presentation_model.dart';

class EditRulesPresenter extends Cubit<EditRulesViewModel> {
  EditRulesPresenter(
    super.model,
    this.navigator,
    this._updateRulesUseCase,
  );

  final EditRulesNavigator navigator;
  final UpdateRulesUseCase _updateRulesUseCase;

  // ignore: unused_element
  EditRulesPresentationModel get _model => state as EditRulesPresentationModel;

  void onTapSave() => _updateRulesUseCase.execute(input: _model.updateCircleInput).doOn(
        success: (resultedCircle) => navigator.closeWithResult(resultedCircle.rulesText),
        fail: (fail) => navigator.showError(fail.displayableFailure()),
      );

  void onChangedRules(String rules) => tryEmit(_model.byUpdatingRulesText(rules));
}
