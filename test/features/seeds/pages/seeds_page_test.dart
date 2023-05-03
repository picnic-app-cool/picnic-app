import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/page_info.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/seeds/seeds/seeds_initial_params.dart';
import 'package:picnic_app/features/seeds/seeds/seeds_navigator.dart';
import 'package:picnic_app/features/seeds/seeds/seeds_page.dart';
import 'package:picnic_app/features/seeds/seeds/seeds_presentation_model.dart';
import 'package:picnic_app/features/seeds/seeds/seeds_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/seeds_mocks.dart';

Future<void> main() async {
  late SeedsPage page;
  late SeedsInitialParams initParams;
  late SeedsPresentationModel model;
  late SeedsPresenter presenter;
  late SeedsNavigator navigator;

  void _initMvp() {
    initParams = const SeedsInitialParams();
    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);
    model = SeedsPresentationModel.initial(
      initParams,
      Mocks.featureFlagsStore,
    );
    navigator = SeedsNavigator(Mocks.appNavigator);
    presenter = SeedsPresenter(
      model,
      navigator,
      SeedsMocks.getSeedsUseCase,
    );
    when(
      () => SeedsMocks.getSeedsUseCase.execute(
        nextPageCursor: any(named: "nextPageCursor"),
      ),
    ).thenAnswer(
      (_) => successFuture(
        PaginatedList(
          items: List.filled(12, Stubs.seed),
          pageInfo: const PageInfo.empty(),
        ),
      ),
    );
    page = SeedsPage(presenter: presenter);
  }

  await screenshotTest(
    "seeds_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<SeedsPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
