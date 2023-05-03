import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/chat_member.dart';
import 'package:picnic_app/core/domain/model/notify_meta.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message.dart';
import 'package:picnic_app/features/chat/domain/model/chat_messages_action.dart';
import 'package:picnic_app/features/chat/domain/model/group_chat_more_page_result.dart';
import 'package:picnic_app/features/chat/domain/model/message_action_result/chat_message_reaction_type.dart';
import 'package:picnic_app/features/chat/domain/model/message_action_result/pop_up_menu_item.dart';
import 'package:picnic_app/features/chat/group_chat/group_chat_initial_params.dart';
import 'package:picnic_app/features/chat/group_chat/group_chat_presentation_model.dart';
import 'package:picnic_app/features/chat/group_chat/group_chat_presenter.dart';
import 'package:picnic_app/features/chat/message_actions/model/message_actions_open_event.dart';
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
  late GroupChatPresentationModel model;
  late GroupChatPresenter presenter;
  late MockGroupChatNavigator navigator;

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
    'Should navigate to group chat more page on tap more',
    () async {
      //GIVEN
      when(() => navigator.openGroupChatMore(any())).thenAnswer((_) => Future.value());

      //WHEN
      await presenter.onTapMore();

      //THEN
      verify(() => navigator.openGroupChatMore(any()));
    },
  );

  test(
    'On tap more options, close on group chat left',
    () async {
      //GIVEN
      when(
        () => navigator.openGroupChatMore(any()),
      ).thenAnswer((_) => Future.value(GroupChatMorePageResult.groupAbandoned));

      //WHEN
      await presenter.onTapMore();

      //THEN
      verify(
        () => navigator.openGroupChatMore(any()),
      );
      verify(
        () => navigator.close(),
      );
    },
  );

  test(
    'Load more messages',
    () async {
      // GIVEN
      when(
        () => ChatMocks.chatMessagesUseCase.execute(
          action: ChatMessagesAction.loadMore(),
        ),
      ).thenAnswer((_) => successFuture(Stubs.displayableMessagesStream));

      // WHEN
      await presenter.loadMoreMessages();

      // THEN
      verify(
        () => ChatMocks.chatMessagesUseCase.execute(
          action: ChatMessagesAction.loadMore(),
        ),
      ).called(1);
    },
  );

  test(
    'Message to reply should be deselected on tap close reply',
    () async {
      // GIVEN
      presenter.emit(model.copyWith(members: Stubs.chatMembers));
      when(() => navigator.openMessageActions(any())).thenAnswer((_) => Future.value(PopUpMenuItem.replyAction()));

      // WHEN
      await presenter.onMessageLongPress(Stubs.messageActionsOpenEvent);
      presenter.onMessageSelected(Stubs.chatMessage);
      presenter.onTapCloseReply();

      // THEN
      expect(presenter.state.replyMessage.selected, false);
    },
  );

  test(
    'Chat message should be selected on message selected',
    () async {
      // GIVEN

      // WHEN
      presenter.onMessageSelected(Stubs.chatMessage);

      // THEN
      expect(presenter.state.selectedMessage, Stubs.chatMessage);
    },
  );

  test(
    'Should navigate to private profile onTapOwnAvatar',
    () async {
      // GIVEN
      when(() => navigator.openPrivateProfile(any())).thenAnswer((_) => Future.value());

      // WHEN
      presenter.onTapOwnAvatar();

      // THEN
      verify(() => navigator.openPrivateProfile(any()));
    },
  );

  test(
    'Should navigate to message actions page onMessageLongPress',
    () async {
      // GIVEN
      presenter.emit(model.copyWith(members: Stubs.chatMembers));
      when(() => navigator.openMessageActions(any())).thenAnswer((_) => Future.value());

      // WHEN
      await presenter.onMessageLongPress(Stubs.messageActionsOpenEvent);

      // THEN
      verify(() => navigator.openMessageActions(any()));
    },
  );

  test(
    'Should open web view onTapLink',
    () async {
      // GIVEN
      const url = 'https://getpicnic.app';
      when(() => navigator.openWebView(any())).thenAnswer((_) => Future.value());

      // WHEN
      presenter.onTapLink(url);

      // THEN
      verify(() => navigator.openWebView(url));
    },
  );

  test(
    'Drag offset should be updated on drag start',
    () async {
      // GIVEN

      // WHEN
      presenter.onDragStart(100);

      // THEN
      expect(presenter.state.dragOffset, 100);
    },
  );

  test(
    'Drag offset should be zero on drag end',
    () async {
      // GIVEN
      presenter.onDragStart(100);

      // WHEN
      presenter.onDragEnd();

      // THEN
      expect(presenter.state.dragOffset, 0);
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
      const members = PaginatedList.singlePage([ChatMember.empty()]);

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
      presenter.emit(model.copyWith(selectedMessage: chatMessage, members: members));

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
    when(() => Mocks.currentTimeProvider.currentTime).thenReturn(DateTime(2022, 12, 12));
    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);
    when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);
    when(
      () => ChatMocks.getChatMembersUseCase.execute(
        chatId: any(named: 'chatId'),
        nextPageCursor: any(named: 'nextPageCursor'),
      ),
    ).thenAnswer((_) => successFuture(const PaginatedList.singlePage()));
    when(
      () => Mocks.mentionUserUseCase.execute(
        query: any(named: 'query'),
        notifyMeta: const NotifyMeta.empty(),
      ),
    ).thenAnswer((_) => successFuture(const PaginatedList.singlePage()));
    model = GroupChatPresentationModel.initial(
      GroupChatInitialParams.fromNewMessage(
        chat: Stubs.basicChat,
        chatMessage: const ChatMessage.empty(),
      ),
      Mocks.featureFlagsStore,
      Mocks.userStore,
      Mocks.currentTimeProvider,
    );
    navigator = MockGroupChatNavigator();

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

    presenter = GroupChatPresenter(
      model,
      navigator,
      mediaPickerPresenter,
      ChatMocks.saveAttachmentUseCase,
      Mocks.requestRuntimePermissionUseCase,
      Mocks.appInfoStore,
      ChatMocks.chatMessagesUseCase,
      ChatMocks.getChatMembersUseCase,
      InAppNotificationsMocks.addInAppNotificationsFilterUseCase,
      InAppNotificationsMocks.removeInAppNotificationsFilterUseCase,
      Mocks.mentionUserUseCase,
      ChatMocks.updateUsersToMentionByUserUseCase,
      ChatMocks.updateContentByMentionUseCase,
      ChatMocks.updateUsersToMentionByMentionsUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
      Mocks.unreadCountersStore,
    );
  });
}
