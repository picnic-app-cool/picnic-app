import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flag_type.dart';
import 'package:picnic_app/core/domain/model/page_info.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/blacklisted_words/blacklisted_words_initial_params.dart';
import 'package:picnic_app/features/circles/blacklisted_words/blacklisted_words_navigator.dart';
import 'package:picnic_app/features/circles/blacklisted_words/blacklisted_words_page.dart';
import 'package:picnic_app/features/circles/blacklisted_words/blacklisted_words_presentation_model.dart';
import 'package:picnic_app/features/circles/blacklisted_words/blacklisted_words_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/circles_mocks.dart';

Future<void> main() async {
  late BlacklistedWordsPage page;
  late BlacklistedWordsInitialParams initParams;
  late BlacklistedWordsPresentationModel model;
  late BlacklistedWordsPresenter presenter;
  late BlacklistedWordsNavigator navigator;

  void _initMvp() {
    initParams = BlacklistedWordsInitialParams(circleId: Stubs.id);
    model = BlacklistedWordsPresentationModel.initial(
      initParams,
      Mocks.featureFlagsStore,
    );

    navigator = BlacklistedWordsNavigator(Mocks.appNavigator);
    presenter = BlacklistedWordsPresenter(
      model,
      navigator,
      CirclesMocks.getBlacklistedWordsUseCase,
      CirclesMocks.removeBlacklistedWordsUseCase,
      Mocks.debouncer,
    );
    page = BlacklistedWordsPage(presenter: presenter);
    when(
      () => CirclesMocks.getBlacklistedWordsUseCase.execute(
        circleId: any(named: 'circleId'),
        cursor: any(
          named: 'cursor',
        ),
      ),
    ).thenAnswer(
      (invocation) => successFuture(
        const PaginatedList(
          pageInfo: PageInfo.empty(),
          items: ['fork', 'beach', 'dig'],
        ),
      ),
    );
  }

  await screenshotTest(
    "blacklisted_words_page",
    variantName: "search_enabled",
    setUp: () async {
      when(() => Mocks.featureFlagsStore.featureFlags).thenReturn(
        Stubs.featureFlags,
      );

      _initMvp();
    },
    pageBuilder: () => page,
  );

  await screenshotTest(
    "blacklisted_words_page",
    variantName: "search_disabled",
    setUp: () async {
      when(() => Mocks.featureFlagsStore.featureFlags).thenReturn(
        Stubs.featureFlags.disable(FeatureFlagType.searchBlacklistWordsEnabled),
      );
      _initMvp();
    },
    pageBuilder: () => page,
  );
  test("getIt page resolves successfully", () async {
    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);
    _initMvp();
    final page = getIt<BlacklistedWordsPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
