import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/features/create_circle/circle_creation_rules/circle_creation_rules_initial_params.dart';
import 'package:picnic_app/features/create_circle/circle_creation_rules/circle_creation_rules_presentation_model.dart';
import 'package:picnic_app/features/create_circle/circle_creation_rules/circle_creation_rules_presenter.dart';

import '../../../mocks/stubs.dart';
import '../../create_circle/mocks/create_circle_mock_definitions.dart';

void main() {
  late CircleCreationRulesPresentationModel model;
  late CircleCreationRulesPresenter presenter;
  late MockCircleCreationRulesNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  setUp(() {
    model = CircleCreationRulesPresentationModel.initial(
      CircleCreationRulesInitialParams(
        circle: Stubs.circle,
        createPostInput: Stubs.createTextPostInput,
      ),
    );
    navigator = MockCircleCreationRulesNavigator();
    presenter = CircleCreationRulesPresenter(
      model,
      navigator,
    );
  });
}
