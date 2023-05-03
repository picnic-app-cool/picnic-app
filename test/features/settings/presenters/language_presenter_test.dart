import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/settings/language/language_initial_params.dart';
import 'package:picnic_app/features/settings/language/language_presentation_model.dart';
import 'package:picnic_app/features/settings/language/language_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../../profile/mocks/profile_mocks.dart';
import '../mocks/settings_mock_definitions.dart';

void main() {
  late LanguagePresentationModel model;
  late LanguagePresenter presenter;
  late MockLanguageNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  setUp(() {
    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);
    model = LanguagePresentationModel.initial(
      const LanguageInitialParams(),
      Mocks.featureFlagsStore,
    );
    navigator = MockLanguageNavigator();
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
  });
}
