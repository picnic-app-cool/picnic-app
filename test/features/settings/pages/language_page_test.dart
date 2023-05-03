import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/settings/language/language_initial_params.dart';
import 'package:picnic_app/features/settings/language/language_navigator.dart';
import 'package:picnic_app/features/settings/language/language_page.dart';
import 'package:picnic_app/features/settings/language/language_presentation_model.dart';
import 'package:picnic_app/features/settings/language/language_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../../profile/mocks/profile_mocks.dart';

Future<void> main() async {
  late LanguagePage page;
  late LanguageInitialParams initParams;
  late LanguagePresentationModel model;
  late LanguagePresenter presenter;
  late LanguageNavigator navigator;

  void _initMvp() {
    initParams = const LanguageInitialParams();
    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);
    model = LanguagePresentationModel.initial(
      initParams,
      Mocks.featureFlagsStore,
    );
    navigator = LanguageNavigator(Mocks.appNavigator);
    presenter = LanguagePresenter(
      model,
      navigator,
      Mocks.getLanguagesListUseCase,
      ProfileMocks.getPrivateProfileUseCase,
      Mocks.setLanguageUseCase,
      Mocks.updateCurrentUserUseCase,
      Mocks.userStore,
      AnalyticsMocks.logAnalyticsEventUseCase,
    );
    when(() => ProfileMocks.getPrivateProfileUseCase.execute()).thenAnswer((_) => successFuture(Stubs.privateProfile));

    when(() => Mocks.getLanguagesListUseCase.execute()).thenAnswer((_) => successFuture(Stubs.languages));

    when(() => Mocks.setLanguageUseCase.execute(languagesCodes: [])).thenAnswer((_) => successFuture(unit));

    page = LanguagePage(presenter: presenter);
  }

  await screenshotTest(
    "language_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<LanguagePage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
