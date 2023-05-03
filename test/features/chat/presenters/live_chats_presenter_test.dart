import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/live_event/channel_live_event.dart';
import 'package:picnic_app/features/chat/domain/model/chat_events/chat_event.dart';
import 'package:picnic_app/features/chat/domain/model/chat_events/message_deleted_chat_event.dart';
import 'package:picnic_app/features/chat/domain/model/chat_events/message_received_chat_event.dart';
import 'package:picnic_app/features/chat/domain/model/chat_events/message_updated_chat_event.dart';
import 'package:picnic_app/features/chat/domain/model/chat_events/messages_reaction_update_chat_event.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message_reaction.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/domain/model/message_action_result/chat_message_reaction_type.dart';
import 'package:picnic_app/features/chat/utils/live_chats_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_live_data_client.dart';
import '../mocks/chat_mocks.dart';

void main() {
  late LiveChatsPresenter presenter;
  late TestLiveDataClient<ChatEvent> testLiveDataClient;

  const chatId = Id('chat1');
  const chat2Id = Id('chat2');
  const chat3Id = Id('chat3');
  final chatMessages = Stubs.chatMessages;
  final newMessage = Stubs.chatMessage.copyWith(
    id: const Id('newMessage'),
    author: Stubs.user2,
  );
  final firstMessage = chatMessages.first;
  final updatedMessage = chatMessages.first.copyWith(content: 'updatedMessage');

  final messageReaction = const ChatMessageReaction.empty().copyWith(
    reactionType: ChatMessageReactionType.heart(),
    hasReacted: false,
    count: 5,
  );

  setUp(() {
    when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);

    testLiveDataClient = TestLiveDataClient<ChatEvent>();

    presenter = LiveChatsPresenter(
      ChatMocks.prepareChatLiveDataClientUseCase,
      Mocks.userStore,
    );

    when(
      () => ChatMocks.getChatMessagesProvider(
        chatId: chatId,
      ),
    ).thenAnswer((_) => chatMessages);
  });

  Future<void> _evaluateInitAction() async {
    when(
      () => ChatMocks.prepareChatLiveDataClientUseCase.execute(),
    ).thenAnswer((_) => Future.value(testLiveDataClient));

    await presenter.onInit(
      getChatMessagesProvider: ChatMocks.getChatMessagesProvider,
      onChatMessagesUpdatedCallback: ChatMocks.onChatMessagesUpdatedCallback,
    );
  }

  test("onInit should initialize liveDataClient successfully", () async {
    // WHEN
    await _evaluateInitAction();

    // THEN
    verify(
      () => ChatMocks.prepareChatLiveDataClientUseCase.execute(),
    );
    expect(presenter.liveDataClient, isNotNull);
  });

  test("subscribeToChannels should subscribe to all channels provided", () async {
    // GIVEN
    await _evaluateInitAction();
    final channelsList = [chatId, chat2Id, chat3Id];

    // WHEN
    await presenter.subscribeToChannels(chatIds: channelsList);

    // THEN
    expect(testLiveDataClient.channelSubscriptions, channelsList);
  });

  test("Receiving MessageReceivedChatEvent should call onChatMessagesUpdatedCallback with updates chatMessages list",
      () async {
    fakeAsync((async) {
      // GIVEN
      _evaluateInitAction();
      async.flushMicrotasks();

      // WHEN
      testLiveDataClient.streamController.add(
        ChannelLiveEvent<ChatEvent>(
          event: MessageReceivedChatEvent(message: newMessage),
          channelId: chatId,
        ),
      );

      async.flushMicrotasks();

      // THEN
      verify(
        () => presenter.onChatMessagesUpdatedCallback(
          chatId: chatId,
          chatMessages: [newMessage] + chatMessages,
        ),
      );
    });
  });

  test("Receiving MessageUpdatedChatEvent should call onChatMessagesUpdatedCallback with updates chatMessages list",
      () async {
    fakeAsync((async) {
      // GIVEN
      _evaluateInitAction();
      async.flushMicrotasks();

      // WHEN
      testLiveDataClient.streamController.add(
        ChannelLiveEvent<ChatEvent>(
          event: MessageUpdatedChatEvent(message: updatedMessage),
          channelId: chatId,
        ),
      );

      async.flushMicrotasks();

      // THEN
      verify(
        () => presenter.onChatMessagesUpdatedCallback(
          chatId: chatId,
          chatMessages: [...chatMessages]
            ..remove(firstMessage)
            ..insert(0, updatedMessage),
        ),
      );
    });
  });

  test("Receiving MessageDeletedChatEvent should call onChatMessagesUpdatedCallback with updates chatMessages list",
      () async {
    fakeAsync((async) {
      // GIVEN
      _evaluateInitAction();
      async.flushMicrotasks();

      // WHEN
      testLiveDataClient.streamController.add(
        ChannelLiveEvent<ChatEvent>(
          event: MessageDeletedChatEvent(chatId: chatId, messageId: firstMessage.id),
          channelId: chatId,
        ),
      );

      async.flushMicrotasks();

      // THEN
      verify(
        () => presenter.onChatMessagesUpdatedCallback(
          chatId: chatId,
          chatMessages: [...chatMessages]..remove(firstMessage),
        ),
      );
    });
  });

  test(
      "Receiving MessagesReactionUpdateChatEvent should call onChatMessagesUpdatedCallback with updates chatMessages list",
      () async {
    fakeAsync((async) {
      // GIVEN
      _evaluateInitAction();
      async.flushMicrotasks();

      // WHEN
      testLiveDataClient.streamController.add(
        ChannelLiveEvent<ChatEvent>(
          event: MessagesReactionUpdateChatEvent(
            messageId: firstMessage.id,
            reactionType: messageReaction.reactionType,
            count: messageReaction.count,
          ),
          channelId: chatId,
        ),
      );

      async.flushMicrotasks();

      // THEN
      verify(
        () => presenter.onChatMessagesUpdatedCallback(
          chatId: chatId,
          chatMessages: [...chatMessages]
            ..remove(firstMessage)
            ..insert(0, firstMessage.byUpdatingReaction(messageReaction)),
        ),
      );
    });
  });

  test('unsubscribing from events in close method', () async {
    await _evaluateInitAction();
    await presenter.dispose();
    expect(testLiveDataClient.streamController.isClosed, true);
  });
}
