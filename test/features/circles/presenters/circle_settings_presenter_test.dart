import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/circle_role.dart';
import 'package:picnic_app/features/circles/circle_settings/circle_settings_initial_params.dart';
import 'package:picnic_app/features/circles/circle_settings/circle_settings_presentation_model.dart';
import 'package:picnic_app/features/circles/circle_settings/circle_settings_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/circles_mock_definitions.dart';
import '../mocks/circles_mocks.dart';

void main() {
  late CircleSettingsPresentationModel model;
  // ignore: unused_local_variable
  late CircleSettingsPresenter presenter;
  late MockCircleSettingsNavigator navigator;

  setUp(() {
    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);
    when(() => Mocks.currentTimeProvider.currentTime).thenAnswer((_) => DateTime(2022, 8, 20));
    when(() => Mocks.userStore.privateProfile).thenAnswer((_) => Stubs.privateProfile);

    model = CircleSettingsPresentationModel.initial(
      CircleSettingsInitialParams(
        circleRole: CircleRole.director,
        circle: Stubs.circle.copyWith(name: '#roblox', id: Stubs.circle.id),
      ),
      Mocks.featureFlagsStore,
      Mocks.currentTimeProvider,
    );
    navigator = MockCircleSettingsNavigator();
    presenter = CircleSettingsPresenter(
      model,
      navigator,
      Mocks.clipboardManager,
      CirclesMocks.getCircleDetailsUseCase,
    );
  });

  tearDown(() {
    reset(CirclesMocks.getCircleMembersByRoleUseCase);
  });

  test(
    'tapping black listed words should trigger navigation to black listed words',
    () async {
      //GIVEN
      when(() => navigator.openBlacklistedWords(any())).thenAnswer((_) => Future.value());

      //WHEN
      presenter.onTapOpenBlackListedWords();

      //THEN
      verify(() => navigator.openBlacklistedWords(any()));
    },
  );

  test('tapping on edit should open EditCircleForm', () async {
    //GIVEN
    when(() => navigator.openEditCircle(any())).thenAnswer(
      (_) => Future.value(),
    );

    //WHEN
    await presenter.onTapEditCircle();

    //THEN
    verify(() => navigator.openEditCircle(any()));
  });

  test('tapping on reports should trigger a navigation to Reports List page', () async {
    //GIVEN
    when(() => navigator.openReportsList(any())).thenAnswer(
      (_) => Future.value(),
    );

    when(
      () => CirclesMocks.getCircleDetailsUseCase.execute(
        circleId: any(named: 'circleId'),
      ),
    ).thenAnswer(
      (invocation) => successFuture(Stubs.circle),
    );

    //WHEN
    await presenter.onTapReportsList();

    //THEN
    verify(() => navigator.openReportsList(any()));
  });

  test('tapping on ban users trigger a navigation to Ban Users page', () async {
    //GIVEN
    when(() => navigator.openBannedUsers(any())).thenAnswer(
      (_) => Future.value(),
    );

    //WHEN
    presenter.onTapBannedUsersList();

    //THEN
    verify(() => navigator.openBannedUsers(any()));
  });
}
