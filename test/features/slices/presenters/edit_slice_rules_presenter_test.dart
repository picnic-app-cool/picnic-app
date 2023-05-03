import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/features/slices/edit_slices/edit_slice_rules_initial_params.dart';
import 'package:picnic_app/features/slices/edit_slices/edit_slice_rules_presentation_model.dart';
import 'package:picnic_app/features/slices/edit_slices/edit_slice_rules_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../mocks/slices_mock_definitions.dart';

void main() {
  late EditSliceRulesPresentationModel model;
  late EditSliceRulesPresenter presenter;
  late MockEditSliceRulesNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  setUp(() {
    model = EditSliceRulesPresentationModel.initial(EditSliceRulesInitialParams(Stubs.slice));
    navigator = MockEditSliceRulesNavigator();
    presenter = EditSliceRulesPresenter(
      model,
      navigator,
      Mocks.updateSliceUseCase,
    );
  });
}
