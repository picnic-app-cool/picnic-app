import 'package:dartz/dartz.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/chat/circle_chat_settings/circle_chat_settings_initial_params.dart';
import 'package:picnic_app/features/chat/circle_chat_settings/circle_chat_settings_presentation_model.dart';
import 'package:picnic_app/features/chat/circle_chat_settings/circle_chat_settings_presenter.dart';
import 'package:picnic_app/features/chat/domain/model/circle_chat_settings_page_result.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../mocks/chat_mock_definitions.dart';
import '../mocks/chat_mocks.dart';

void main() {
  late CircleChatSettingsPresentationModel model;
  late CircleChatSettingsPresenter presenter;
  late MockCircleChatSettingsNavigator navigator;

  late final chatSettings = Stubs.chatSettings;
  late final chatWithCircle = Stubs.chatWithCircle;
  late final circleWithChat = Stubs.chatWithCircle.circle.toCircle(chat: Stubs.chatWithCircle.toBasicChat());

  test(
    'init',
    () async {
      fakeAsync(
        (async) {
          // GIVEN
          when(
            () => ChatMocks.getChatSettingsUseCase.execute(chatId: any(named: "chatId")),
          ).thenAnswer(
            (_) => successFuture(chatSettings),
          );

          // WHEN
          presenter.onInit();
          async.flushMicrotasks();

          // THEN
          verify(
            () => ChatMocks.getChatSettingsUseCase.execute(chatId: any(named: "chatId")),
          );
        },
      );
    },
  );

  test(
    'on tap mute chat',
    () async {
      //GIVEN
      when(
        () => ChatMocks.updateChatSettingsUseCase.execute(
          chatId: any(named: "chatId"),
          chatSettings: chatSettings.copyWith(
            isMuted: true,
          ),
        ),
      ).thenAnswer(
        (_) => successFuture(unit),
      );

      //WHEN
      presenter.onTapMute();

      //THEN
      verify(
        () => ChatMocks.updateChatSettingsUseCase.execute(
          chatId: any(named: "chatId"),
          chatSettings: chatSettings.copyWith(
            isMuted: true,
          ),
        ),
      );
    },
  );

  test(
    'on tap unmute chat',
    () async {
      //GIVEN
      when(
        () => ChatMocks.updateChatSettingsUseCase.execute(
          chatId: any(named: "chatId"),
          chatSettings: chatSettings.copyWith(
            isMuted: false,
          ),
        ),
      ).thenAnswer(
        (_) => successFuture(unit),
      );

      //WHEN
      presenter.onTapUnMute();

      //THEN
      verify(
        () => ChatMocks.updateChatSettingsUseCase.execute(
          chatId: any(named: "chatId"),
          chatSettings: chatSettings.copyWith(
            isMuted: false,
          ),
        ),
      );
    },
  );

  test(
    'on tap circlePage chat',
    () async {
      //GIVEN
      when(
        () => navigator.openCircleDetails(any()),
      ).thenAnswer((_) => Future.value());

      //WHEN
      presenter.onTapCirclePage();

      //THEN
      verify(
        () => navigator.openCircleDetails(any()),
      );
    },
  );

  test(
    'on tap leave circle',
    () async {
      fakeAsync(
        (async) {
          //GIVEN
          when(
            () => Mocks.leaveCircleUseCase.execute(
              circle: any(named: "circle"),
            ),
          ).thenAnswer(
            (_) => successFuture(unit),
          );

          when(
            () => navigator.closeWithResult(CircleChatSettingsPageResult.didLeftCircle),
          ).thenAnswer((_) => unit);

          //WHEN
          presenter.onTapLeave();
          async.flushMicrotasks();

          //THEN
          verify(
            () => Mocks.leaveCircleUseCase.execute(
              circle: any(named: "circle"),
            ),
          );
          verify(
            () => navigator.closeWithResult(CircleChatSettingsPageResult.didLeftCircle),
          );
        },
      );
    },
  );

  test(
    'on tap close',
    () async {
      //GIVEN
      when(
        () => navigator.close(),
      ).thenAnswer((_) => Future.value());

      //WHEN
      presenter.onTapClose();

      //THEN
      verify(
        () => navigator.close(),
      );
    },
  );

  test(
    'on tap report',
    () async {
      //GIVEN
      when(
        () => navigator.openReportForm(any()),
      ).thenAnswer((_) => Future.value());

      //WHEN
      await presenter.onTapReport();

      //THEN
      verify(
        () => navigator.openReportForm(any()),
      );
    },
  );

  test(
    'on tap share',
    () async {
      //GIVEN
      when(
        () => navigator.close(),
      ).thenAnswer((_) => Future.value());

      when(
        () => navigator.shareText(text: any(named: "text")),
      ).thenAnswer((_) => Future.value());

      //WHEN
      presenter.onTapShare();

      //THEN
      verify(
        () => navigator.close(),
      );
      verify(
        () => navigator.shareText(text: chatWithCircle.circle.inviteCircleLink),
      );
    },
  );

  setUp(() {
    model = CircleChatSettingsPresentationModel.initial(
      CircleChatSettingsInitialParams(circle: circleWithChat),
    );
    navigator = MockCircleChatSettingsNavigator();
    presenter = CircleChatSettingsPresenter(
      model,
      navigator,
      Mocks.leaveCircleUseCase,
      ChatMocks.getChatSettingsUseCase,
      ChatMocks.updateChatSettingsUseCase,
      Mocks.joinCircleUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
    );
  });
}
