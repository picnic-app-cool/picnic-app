import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flag_type.dart';
import 'package:picnic_app/features/settings/blocked_list/blocked_list_initial_params.dart';
import 'package:picnic_app/features/settings/community_guidelines/community_guidelines_initial_params.dart';
import 'package:picnic_app/features/settings/get_verified/get_verified_initial_params.dart';
import 'package:picnic_app/features/settings/settings_home/settings_home_initial_params.dart';
import 'package:picnic_app/features/settings/settings_home/settings_home_presentation_model.dart';
import 'package:picnic_app/features/settings/settings_home/settings_home_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../mocks/settings_mock_definitions.dart';

void main() {
  late SettingsHomePresentationModel model;
  late SettingsHomePresenter presenter;
  late MockSettingsHomeNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  test(
    'onTapBlockedList calls navigation openBlockedList method',
    () {
      presenter.onTapBlockedList();
      verify(() async => navigator.openBlockedList(const BlockedListInitialParams()));
    },
  );

  test(
    'onTapCommunityGuidelines calls navigation openCommunityGuidelines method',
    () {
      presenter.onTapCommunityGuidelines();
      verify(() async => navigator.openCommunityGuidelines(const CommunityGuidelinesInitialParams()));
    },
  );

  test(
    'onTapGetVerified calls navigation openGetVerified method',
    () {
      presenter.onTapGetVerified();
      verify(() async => navigator.openGetVerified(const GetVerifiedInitialParams()));
    },
  );

  setUp(() {
    when(() => Mocks.appInfoStore.appInfo).thenReturn(Stubs.appInfo);
    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);
    when(() => Mocks.featureFlagsStore.featureFlags).thenReturn(
      Stubs.featureFlags.enable(FeatureFlagType.phoneContactsSharingEnable),
    );
    model = SettingsHomePresentationModel.initial(
      SettingsHomeInitialParams(user: Stubs.user),
      Mocks.featureFlagsStore,
    );
    navigator = MockSettingsHomeNavigator();

    presenter = SettingsHomePresenter(
      model,
      navigator,
      Mocks.logOutUseCase,
      Mocks.appInfoStore,
      Mocks.copyTextUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
    );
  });
}
