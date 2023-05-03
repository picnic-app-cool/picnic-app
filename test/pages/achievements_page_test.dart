import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/profile/achievements/achievements_initial_params.dart';
import 'package:picnic_app/features/profile/achievements/achievements_navigator.dart';
import 'package:picnic_app/features/profile/achievements/achievements_page.dart';
import 'package:picnic_app/features/profile/achievements/achievements_presentation_model.dart';
import 'package:picnic_app/features/profile/achievements/achievements_presenter.dart';

import '../mocks/mocks.dart';
import '../test_utils/golden_tests_utils.dart';
import '../test_utils/test_utils.dart';

Future<void> main() async {
  late AchievementsPage page;
  late AchievementsInitialParams initParams;
  late AchievementsPresentationModel model;
  late AchievementsPresenter presenter;
  late AchievementsNavigator navigator;

  void _initMvp() {
    initParams = const AchievementsInitialParams();
    model = AchievementsPresentationModel.initial(
      initParams,
    );
    navigator = AchievementsNavigator(Mocks.appNavigator);
    presenter = AchievementsPresenter(
      model,
      navigator,
    );
    page = AchievementsPage(presenter: presenter);
  }

  await screenshotTest(
    "achievements_test",
    setUp: () async {
      await configureDependenciesForTests();

      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    await configureDependenciesForTests();

    _initMvp();
    final page = getIt<AchievementsPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
