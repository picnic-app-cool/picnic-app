import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/use_cases/update_slice_use_case.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/slices/edit_slices/edit_slice_rules_navigator.dart';
import 'package:picnic_app/features/slices/edit_slices/edit_slice_rules_presentation_model.dart';

class EditSliceRulesPresenter extends Cubit<EditSliceRulesViewModel> {
  EditSliceRulesPresenter(
    super.model,
    this.navigator,
    this._updateSliceUseCase,
  );

  final EditSliceRulesNavigator navigator;
  final UpdateSliceUseCase _updateSliceUseCase;

  // ignore: unused_element
  EditSliceRulesPresentationModel get _model => state as EditSliceRulesPresentationModel;

  void onChangedRules(String rules) => tryEmit(_model.byUpdatingRulesText(rules));

  Future<void> onTapSave() async => _updateSliceUseCase
      .execute(
        sliceId: _model.sliceId,
        input: _model.sliceInput,
      )
      .doOn(
        success: (resultedSlice) => navigator.closeWithResult(resultedSlice),
        fail: (fail) => navigator.showError(fail.displayableFailure()),
      );
}
