import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/seeds/sell_seeds/sell_seeds_navigator.dart';
import 'package:picnic_app/features/seeds/sell_seeds_second_step/sell_seeds_second_step_initial_params.dart';
import 'package:picnic_app/features/seeds/sell_seeds_second_step/sell_seeds_second_step_page.dart';
import 'package:picnic_app/features/seeds/sell_seeds_second_step/sell_seeds_second_step_presentation_model.dart';
import 'package:picnic_app/features/seeds/sell_seeds_second_step/sell_seeds_second_step_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../mocks/seeds_mocks.dart';

Future<void> main() async {
  late SellSeedsSecondStepPage page;
  late SellSeedsSecondStepInitialParams initParams;
  late SellSeedsSecondStepPresentationModel model;
  late SellSeedsSecondStepPresenter presenter;
  late SellSeedsNavigator sellSeedsNavigator;

  void _initMvp() {
    final key = SellSeedsNavigatorKey();
    initParams = SellSeedsSecondStepInitialParams(
      seed: Stubs.seed,
      onTransferSeedsCallback: () {},
    );
    model = SellSeedsSecondStepPresentationModel.initial(
      initParams,
    );
    sellSeedsNavigator = SellSeedsNavigator(Mocks.appNavigator, key);
    presenter = SellSeedsSecondStepPresenter(
      model,
      sellSeedsNavigator,
      SeedsMocks.sellSeedsUseCase,
      SeedsMocks.transferSeedsUseCase,
    );
    page = SellSeedsSecondStepPage(presenter: presenter);
  }

  await screenshotTest(
    "sell_seeds_second_step_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<SellSeedsSecondStepPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
