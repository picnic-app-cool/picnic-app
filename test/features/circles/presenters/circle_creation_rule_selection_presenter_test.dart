import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/features/create_circle/rule_selection/rule_selection_initial_params.dart';
import 'package:picnic_app/features/create_circle/rule_selection/rule_selection_presentation_model.dart';
import 'package:picnic_app/features/create_circle/rule_selection/rule_selection_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../mocks/circles_mock_definitions.dart';

void main() {
  late RuleSelectionPresentationModel model;
  late RuleSelectionPresenter presenter;
  late MockCircleCreationRuleSelectionNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  setUp(() {
    model = RuleSelectionPresentationModel.initial(
      RuleSelectionInitialParams(
        circle: Stubs.circle,
        createPostInput: Stubs.createTextPostInput,
      ),
    );
    navigator = MockCircleCreationRuleSelectionNavigator();
    presenter = RuleSelectionPresenter(
      model,
      navigator,
      Mocks.updateCircleUseCase,
    );
  });
}
