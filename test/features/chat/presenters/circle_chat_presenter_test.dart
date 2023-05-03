import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/chat/circle_chat/circle_chat_initial_params.dart';
import 'package:picnic_app/features/chat/circle_chat/circle_chat_presentation_model.dart';
import 'package:picnic_app/features/chat/circle_chat/circle_chat_presenter.dart';
import 'package:picnic_app/features/chat/circle_chat_settings/circle_chat_settings_initial_params.dart';
import 'package:picnic_app/features/chat/domain/model/chat.dart';
import 'package:picnic_app/features/chat/domain/model/chat_messages_action.dart';
import 'package:picnic_app/features/chat/domain/model/circle_chat_settings_page_result.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/domain/model/message_action_result/chat_message_reaction_type.dart';
import 'package:picnic_app/features/chat/message_actions/model/message_actions_open_event.dart';
import 'package:picnic_app/features/media_picker/media_picker_initial_params.dart';
import 'package:picnic_app/features/media_picker/media_picker_presentation_model.dart';
import 'package:picnic_app/features/media_picker/media_picker_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../../circles/mocks/circles_mocks.dart';
import '../../in_app_notifications/mocks/in_app_notifications_mocks.dart';
import '../../media_picker/mocks/media_picker_mocks.dart';
import '../mocks/chat_mock_definitions.dart';
import '../mocks/chat_mocks.dart';

void main() {
  late CircleChatPresentationModel model;
  late CircleChatPresenter presenter;
  late MockCircleChatNavigator navigator;

  test(
    'init with chat',
    () async {
      fakeAsync(
        (async) {
          // GIVEN
          when(
            () => ChatMocks.chatMessagesUseCase.execute(action: any(named: "action")),
          ).thenAnswer(
            (_) => successFuture(Stubs.displayableMessagesStream),
          );

          // WHEN
          presenter.onInit();
          async.flushMicrotasks();

          // THEN
          verify(
            () => ChatMocks.chatMessagesUseCase.execute(action: any(named: "action")),
          );

          expect(presenter.state.displayableMessages.items[0].chatMessage.id, Stubs.chatMessages[0].id);
          expect(presenter.state.displayableMessages.items[1].chatMessage.id, Stubs.chatMessages[1].id);
          expect(presenter.state.displayableMessages.items[2].chatMessage.id, Stubs.chatMessages[2].id);
        },
      );
    },
  );

  test(
    'Tapping on circle chat settings should open CircleChatSettings page with non-empty chat object inside circle object',
    () async {
      //GIVEN
      when(
        () => navigator.openCircleChatSettingsBottomSheet(any()),
      ).thenAnswer((_) => Future.value());

      //WHEN
      await presenter.onTapCircleChatSettings();

      //THEN

      final verification = verify(() => navigator.openCircleChatSettingsBottomSheet(captureAny()));
      final captured = verification.captured.single as CircleChatSettingsInitialParams;
      expect(captured.circle.chat, isNot(equals(const Chat.empty())));
      expect(captured.circle.chat.id, isNot(equals(const Id.empty())));
    },
  );

  test(
    'on tap circle chat settings, close on circle left',
    () async {
      //GIVEN
      when(
        () => navigator.openCircleChatSettingsBottomSheet(any()),
      ).thenAnswer((_) => Future.value(CircleChatSettingsPageResult.didLeftCircle));

      //WHEN
      await presenter.onTapCircleChatSettings();

      //THEN
      verify(
        () => navigator.openCircleChatSettingsBottomSheet(any()),
      );
      verify(
        () => navigator.close(),
      );
    },
  );

  test(
    'onTapSendNewMassage',
    () async {
      // GIVEN
      when(
        () => ChatMocks.chatMessagesUseCase.execute(
          action: any(named: "action"),
        ),
      ).thenAnswer((_) => successFuture(Stubs.displayableMessagesStream));

      // WHEN
      presenter.onMessageTextUpdated("test");
      await presenter.onTapSendNewMassage();

      // THEN
      verify(
        () => ChatMocks.chatMessagesUseCase.execute(
          action: any(named: "action"),
        ),
      );
      expect(presenter.state.pendingMessage.content, "");
    },
  );

  test(
    'onTapSendNewMassage do nothing for empty message',
    () async {
      // GIVEN

      // WHEN
      await presenter.onTapSendNewMassage();

      // THEN
      verifyNever(
        () => ChatMocks.chatMessagesUseCase.execute(
          action: any(named: "action"),
        ),
      );
    },
  );

  test(
    'should navigate to public profile onTapFriendAvatar',
    () async {
      // GIVEN
      when(() => navigator.openPublicProfile(any())).thenAnswer((_) => Future.value());

      // WHEN
      presenter.onTapFriendAvatar(Stubs.id);

      // THEN
      verify(() => navigator.openPublicProfile(any()));
    },
  );

  test(
    'onTapUnblurAttachment test',
    () async {
      // GIVEN
      when(
        () => ChatMocks.chatMessagesUseCase.execute(
          action: any(named: "action"),
        ),
      ).thenAnswer((_) => successFuture(Stubs.displayableMessagesStream));

      // WHEN
      presenter.onTapUnblurAttachment(Stubs.attachment);

      // THEN
      verify(
        () => ChatMocks.chatMessagesUseCase.execute(
          action: any(named: "action"),
        ),
      );
    },
  );

  test(
    'onTapImageAttachment test',
    () async {
      // GIVEN
      when(
        () => ChatMocks.chatMessagesUseCase.execute(
          action: any(named: "action"),
        ),
      ).thenAnswer((_) => successFuture(Stubs.displayableMessagesStream));

      when(() => navigator.openFullscreenAttachment(any())).thenAnswer((_) => Future.value());

      // WHEN
      presenter.onTapAttachment(Stubs.chatMessageWithAttachment);

      // THEN
      verify(
        () => navigator.openFullscreenAttachment(any()),
      );
    },
  );

  test(
    'Tapping on send should be disabled for messages having only text containing only spaces',
    () async {
      // WHEN
      presenter.onMessageTextUpdated('     ');

      // THEN
      expect(presenter.state.sendMessageEnabled, false);
    },
  );

  test(
    'Tapping on send should be enabled for messages having any character different from space',
    () async {
      // WHEN
      presenter.onMessageTextUpdated('   a   ');

      // THEN
      expect(presenter.state.sendMessageEnabled, true);
    },
  );

  test(
    'onDoubleTapMessage should execute invertHeartReaction action',
    () async {
      // GIVEN
      final chatMessage = Stubs.chatMessage;
      when(
        () => ChatMocks.chatMessagesUseCase.execute(
          action: any(named: 'action'),
        ),
      ).thenAnswer((_) => successFuture(Stubs.displayableMessagesStream));

      // WHEN
      await presenter.onDoubleTapMessage(chatMessage);

      // THEN
      verify(
        () => ChatMocks.chatMessagesUseCase.execute(
          action: ChatMessagesAction.reaction(chatMessage, ChatMessageReactionType.heart()),
        ),
      );
    },
  );

  test(
    'onLongPressed should execute reaction action when result is ChatMessageReactionType',
    () async {
      // GIVEN
      final chatMessage = Stubs.chatMessage;
      final reactionType = ChatMessageReactionType.fire();
      const openEvent = MessageActionsOpenEvent.empty();

      when(
        () => ChatMocks.chatMessagesUseCase.execute(
          action: any(named: 'action'),
        ),
      ).thenAnswer((_) => successFuture(Stubs.displayableMessagesStream));

      when(
        () => navigator.openMessageActions(any()),
      ).thenAnswer(
        (_) async => reactionType,
      );
      presenter.emit(model.copyWith(selectedMessage: chatMessage));

      // WHEN
      await presenter.onMessageLongPress(openEvent);

      // THEN
      verify(
        () => ChatMocks.chatMessagesUseCase.execute(
          action: ChatMessagesAction.reaction(chatMessage, reactionType),
        ),
      );
    },
  );

  setUp(() {
    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);
    when(() => Mocks.currentTimeProvider.currentTime).thenReturn(DateTime(2022, 10, 26));
    model = CircleChatPresentationModel.initial(
      CircleChatInitialParams(chat: Stubs.chatWithCircle),
      Mocks.featureFlagsStore,
      Mocks.currentTimeProvider,
    );
    navigator = MockCircleChatNavigator();

    final mediaPickerPresenter = MediaPickerPresenter(
      MediaPickerPresentationModel.initial(const MediaPickerInitialParams()),
      MediaPickerMocks.imageVideoPickerNavigator,
      Mocks.requestRuntimePermissionUseCase,
      Mocks.videoThumbnailUseCase,
      Mocks.getAttachmentsUseCase,
      ChatMocks.getUploadChatAttachmentUseCase,
      Mocks.openNativeAppSettingsUseCase,
      Mocks.appInfoStore,
    );

    presenter = CircleChatPresenter(
      model,
      navigator,
      mediaPickerPresenter,
      ChatMocks.saveAttachmentUseCase,
      Mocks.requestRuntimePermissionUseCase,
      Mocks.appInfoStore,
      ChatMocks.chatMessagesUseCase,
      CirclesMocks.banUserUseCase,
      InAppNotificationsMocks.addInAppNotificationsFilterUseCase,
      InAppNotificationsMocks.removeInAppNotificationsFilterUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
    );
  });
}
