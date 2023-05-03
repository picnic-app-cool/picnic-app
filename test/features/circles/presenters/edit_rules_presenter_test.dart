import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/features/circles/edit_rules/edit_rules_initial_params.dart';
import 'package:picnic_app/features/circles/edit_rules/edit_rules_presentation_model.dart';
import 'package:picnic_app/features/circles/edit_rules/edit_rules_presenter.dart';

import '../../../mocks/stubs.dart';
import '../mocks/circles_mock_definitions.dart';
import '../mocks/circles_mocks.dart';

void main() {
  late EditRulesPresentationModel model;
  late EditRulesPresenter presenter;
  late MockEditRulesNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  setUp(() {
    model = EditRulesPresentationModel.initial(EditRulesInitialParams(circle: Stubs.circle));
    navigator = MockEditRulesNavigator();
    presenter = EditRulesPresenter(
      model,
      navigator,
      CirclesMocks.editRulesUseCase,
    );
  });
}
