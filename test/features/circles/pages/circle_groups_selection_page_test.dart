import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/circle_groups_selection/circle_groups_selection_initial_params.dart';
import 'package:picnic_app/features/circles/circle_groups_selection/circle_groups_selection_navigator.dart';
import 'package:picnic_app/features/circles/circle_groups_selection/circle_groups_selection_page.dart';
import 'package:picnic_app/features/circles/circle_groups_selection/circle_groups_selection_presentation_model.dart';
import 'package:picnic_app/features/circles/circle_groups_selection/circle_groups_selection_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../../onboarding/mocks/onboarding_mocks.dart';

Future<void> main() async {
  late CircleGroupsSelectionPage page;
  late CircleGroupsSelectionInitialParams initParams;
  late CircleGroupsSelectionPresentationModel model;
  late CircleGroupsSelectionPresenter presenter;
  late CircleGroupsSelectionNavigator navigator;

  void _initMvp() {
    initParams = const CircleGroupsSelectionInitialParams();
    model = CircleGroupsSelectionPresentationModel.initial(
      initParams,
    );
    navigator = CircleGroupsSelectionNavigator(Mocks.appNavigator);
    presenter = CircleGroupsSelectionPresenter(
      model,
      navigator,
      OnboardingMocks.getCircleGroupingsUseCase,
    );
    page = CircleGroupsSelectionPage(presenter: presenter);
  }

  await screenshotTest(
    "circle_groups_selection_page",
    setUp: () async {
      _initMvp();
      when(() => OnboardingMocks.getCircleGroupingsUseCase.execute(listGroupsInput: any(named: 'listGroupsInput')))
          .thenAnswer(
        (_) => successFuture(
          [
            Stubs.groupWithCircles,
            Stubs.groupWithCircles2,
            Stubs.groupWithCircles3,
            Stubs.groupWithCircles4,
          ],
        ),
      );
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<CircleGroupsSelectionPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
