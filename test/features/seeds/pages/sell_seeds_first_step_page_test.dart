import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/page_info.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/seeds/domain/model/seed.dart';
import 'package:picnic_app/features/seeds/sell_seeds/sell_seeds_navigator.dart';
import 'package:picnic_app/features/seeds/sell_seeds_first_step/sell_seeds_first_step_initial_params.dart';
import 'package:picnic_app/features/seeds/sell_seeds_first_step/sell_seeds_first_step_page.dart';
import 'package:picnic_app/features/seeds/sell_seeds_first_step/sell_seeds_first_step_presentation_model.dart';
import 'package:picnic_app/features/seeds/sell_seeds_first_step/sell_seeds_first_step_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/seeds_mocks.dart';

Future<void> main() async {
  late SellSeedsFirstStepPage page;
  late SellSeedsFirstStepInitialParams initParams;
  late SellSeedsFirstStepPresentationModel model;
  late SellSeedsFirstStepPresenter presenter;
  late SellSeedsNavigator sellSeedsNavigator;

  void _initMvp() {
    final key = SellSeedsNavigatorKey();
    initParams = SellSeedsFirstStepInitialParams(
      onChooseCircle: (Seed seed) {},
    );
    model = SellSeedsFirstStepPresentationModel.initial(
      initParams,
    );
    sellSeedsNavigator = SellSeedsNavigator(Mocks.appNavigator, key);
    presenter = SellSeedsFirstStepPresenter(
      model,
      sellSeedsNavigator,
      SeedsMocks.getSeedsUseCase,
      Mocks.debouncer,
    );
    page = SellSeedsFirstStepPage(presenter: presenter);

    when(
      () => SeedsMocks.getSeedsUseCase.execute(
        nextPageCursor: any(named: "nextPageCursor"),
      ),
    ).thenAnswer(
      (_) => successFuture(
        PaginatedList(
          items: [
            Stubs.seed.copyWith(amountAvailable: 100),
            Stubs.seed.copyWith(amountAvailable: 0),
            Stubs.seed,
            Stubs.seed,
            Stubs.seed.copyWith(amountAvailable: 5000),
            Stubs.seed,
            Stubs.seed,
            Stubs.seed.copyWith(amountAvailable: 0),
            Stubs.seed,
          ],
          pageInfo: const PageInfo.empty(),
        ),
      ),
    );
  }

  await screenshotTest(
    "sell_seeds_first_step_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<SellSeedsFirstStepPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
