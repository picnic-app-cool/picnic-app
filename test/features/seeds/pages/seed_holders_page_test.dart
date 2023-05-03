import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/seeds/seed_holders/seed_holders_initial_params.dart';
import 'package:picnic_app/features/seeds/seed_holders/seed_holders_navigator.dart';
import 'package:picnic_app/features/seeds/seed_holders/seed_holders_page.dart';
import 'package:picnic_app/features/seeds/seed_holders/seed_holders_presentation_model.dart';
import 'package:picnic_app/features/seeds/seed_holders/seed_holders_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/seeds_mocks.dart';

Future<void> main() async {
  late SeedHoldersPage page;
  late SeedHoldersInitialParams initParams;
  late SeedHoldersPresentationModel model;
  late SeedHoldersPresenter presenter;
  late SeedHoldersNavigator navigator;

  void _initMvp(bool isSeedHolder) {
    when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);
    when(() => Mocks.currentTimeProvider.currentTime).thenReturn(DateTime(2022, 9, 3));
    initParams = SeedHoldersInitialParams(isSeedHolder: isSeedHolder);
    model = SeedHoldersPresentationModel.initial(
      initParams,
      Mocks.currentTimeProvider,
    );
    navigator = SeedHoldersNavigator(Mocks.appNavigator, Mocks.userStore);
    presenter = SeedHoldersPresenter(
      model,
      navigator,
      SeedsMocks.getSeedholdersUseCase,
    );
    page = SeedHoldersPage(presenter: presenter);
    when(() => SeedsMocks.getSeedholdersUseCase.execute(circleId: Stubs.id)).thenAnswer((_) {
      return successFuture(PaginatedList.singlePage(List.filled(5, Stubs.seedHolder)));
    });
  }

  await screenshotTest(
    "seed_holders_page",
    variantName: "send_seeds_button_enabled",
    setUp: () async {
      _initMvp(true);
    },
    pageBuilder: () => page,
  );

  await screenshotTest(
    "seed_holders_page",
    variantName: "send_seeds_button_disabled",
    setUp: () async {
      _initMvp(false);
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp(true);
    final page = getIt<SeedHoldersPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
