import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/features/chat/domain/model/basic_chat.dart';
import 'package:picnic_app/features/chat/domain/model/chat_messages_action.dart';
import 'package:picnic_app/features/chat/domain/model/message_action_result/chat_message_reaction_type.dart';
import 'package:picnic_app/features/chat/message_actions/model/message_actions_open_event.dart';
import 'package:picnic_app/features/chat/single_chat/single_chat_initial_params.dart';
import 'package:picnic_app/features/chat/single_chat/single_chat_presentation_model.dart';
import 'package:picnic_app/features/chat/single_chat/single_chat_presenter.dart';
import 'package:picnic_app/features/media_picker/media_picker_initial_params.dart';
import 'package:picnic_app/features/media_picker/media_picker_presentation_model.dart';
import 'package:picnic_app/features/media_picker/media_picker_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../../in_app_notifications/mocks/in_app_notifications_mocks.dart';
import '../../media_picker/mocks/media_picker_mocks.dart';
import '../mocks/chat_mock_definitions.dart';
import '../mocks/chat_mocks.dart';

void main() {
  late SingleChatPresentationModel model;
  late SingleChatPresenter presenter;
  late MockSingleChatNavigator navigator;

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

          when(
            () => ChatMocks.getChatParticipantsUseCase
                .execute(chatId: any(named: "chatId"), nextPageCursor: any(named: "nextPageCursor")),
          ).thenAnswer(
            (_) => successFuture(
              const PaginatedList<User>.empty().copyWith(items: [Stubs.user, Stubs.user2]),
            ),
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
      when(
        () => ChatMocks.chatMessagesUseCase.execute(
          action: any(named: 'action'),
        ),
      ).thenAnswer((_) => successFuture(Stubs.displayableMessagesStream));

      final chatMessage = Stubs.chatMessage;

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
    when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);
    model = SingleChatPresentationModel.initial(
      const SingleChatInitialParams(
        chat: BasicChat.empty(),
      ),
      Mocks.featureFlagsStore,
      Mocks.userStore,
      Mocks.currentTimeProvider,
    );
    navigator = MockSingleChatNavigator();

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
    presenter = SingleChatPresenter(
      model,
      navigator,
      mediaPickerPresenter,
      ChatMocks.saveAttachmentUseCase,
      Mocks.requestRuntimePermissionUseCase,
      Mocks.appInfoStore,
      ChatMocks.chatMessagesUseCase,
      ChatMocks.getChatParticipantsUseCase,
      InAppNotificationsMocks.addInAppNotificationsFilterUseCase,
      InAppNotificationsMocks.removeInAppNotificationsFilterUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
      Mocks.unreadCountersStore,
    );
  });
}
