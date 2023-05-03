import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/features/chat/domain/model/chat_settings.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/settings/single_chat_settings.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../mocks/chat_mock_definitions.dart';
import '../mocks/chat_mocks.dart';

void main() {
  late SingleChatSettingsPresentationModel model;
  late SingleChatSettingsPresenter presenter;
  late MockSingleChatSettingsNavigator navigator;

  test(
    'presenter init not followed and not muted',
    () async {
      // WHEN
      await presenter.init();

      // THEN
      expect(presenter.state.followed, false);
      expect(presenter.state.muted, false);
    },
  );

  test(
    'on tap follow should change the followed state',
    () async {
      // WHEN
      await presenter.init();
      await presenter.onTapActionButton(SingleChatSettingsActions.follow);

      // THEN
      expect(presenter.state.followed, true);
    },
  );

  test(
    'on tap mute should change the followed state',
    () async {
      // WHEN
      await presenter.init();
      await presenter.onTapActionButton(SingleChatSettingsActions.mute);

      // THEN
      expect(presenter.state.muted, true);
    },
  );

  test(
    'on tap glitter bomb should start glitter bomb use case',
    () async {
      // GIVEN
      when(() => navigator.showFxEffect(any())).thenAnswer((_) => Future.value());

      // WHEN
      await presenter.init();
      await presenter.onTapActionButton(SingleChatSettingsActions.glitterbomb);

      // THEN
      verify(
        () => Mocks.sendGlitterBombUseCase.execute(any()),
      ).called(1);
    },
  );

  test(
    'on tap user should navigate to public profile',
    () async {
      // GIVEN
      when(() => navigator.openPublicProfile(any())).thenAnswer((_) => Future.value());

      // WHEN
      presenter.onTapUser();

      // THEN
      verify(() => navigator.openPublicProfile(any()));
    },
  );

  setUp(() {
    model = SingleChatSettingsPresentationModel.initial(
      const SingleChatSettingsInitialParams(
        Id.empty(),
        User.empty(),
      ),
    );
    navigator = MockSingleChatSettingsNavigator();
    presenter = SingleChatSettingsPresenter(
      model,
      navigator,
      Mocks.followUserUseCase,
      ChatMocks.updateChatSettingsUseCase,
      Mocks.getUserUseCase,
      ChatMocks.getChatSettingsUseCase,
      Mocks.sendGlitterBombUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
    );

    when(
      () => Mocks.followUserUseCase.execute(
        follow: true,
        userId: any(named: 'userId'),
      ),
    ).thenAnswer((_) => successFuture(unit));

    when(
      () => Mocks.getUserUseCase.execute(
        userId: any(named: 'userId'),
      ),
    ).thenAnswer((_) => successFuture(const PublicProfile.empty()));

    when(
      () => ChatMocks.getChatSettingsUseCase.execute(
        chatId: any(named: 'chatId'),
      ),
    ).thenAnswer((_) => successFuture(const ChatSettings.empty()));

    when(
      () => ChatMocks.updateChatSettingsUseCase.execute(
        chatId: any(named: 'chatId'),
        chatSettings: any(named: 'chatSettings'),
      ),
    ).thenAnswer((_) => successFuture(unit));
    when(
      () => Mocks.sendGlitterBombUseCase.execute(
        any(),
      ),
    ).thenAnswer((_) => successFuture(unit));
  });
}
