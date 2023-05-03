import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/features/circles/circle_groups_selection/circle_groups_selection_initial_params.dart';
import 'package:picnic_app/features/circles/circle_groups_selection/circle_groups_selection_presentation_model.dart';
import 'package:picnic_app/features/circles/circle_groups_selection/circle_groups_selection_presenter.dart';

import '../../onboarding/mocks/onboarding_mocks.dart';
import '../mocks/circles_mock_definitions.dart';

void main() {
  late CircleGroupsSelectionPresentationModel model;
  late CircleGroupsSelectionPresenter presenter;
  late MockCircleGroupsSelectionNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  setUp(() {
    model = CircleGroupsSelectionPresentationModel.initial(const CircleGroupsSelectionInitialParams());
    navigator = MockCircleGroupsSelectionNavigator();
    presenter = CircleGroupsSelectionPresenter(
      model,
      navigator,
      OnboardingMocks.getCircleGroupingsUseCase,
    );
  });
}
