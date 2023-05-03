import 'dart:async';

import 'package:collection/collection.dart';
import 'package:picnic_app/core/domain/live_data_client.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/features/chat/domain/model/chat_events/chat_event.dart';
import 'package:picnic_app/features/chat/domain/model/chat_events/message_deleted_chat_event.dart';
import 'package:picnic_app/features/chat/domain/model/chat_events/message_received_chat_event.dart';
import 'package:picnic_app/features/chat/domain/model/chat_events/message_updated_chat_event.dart';
import 'package:picnic_app/features/chat/domain/model/chat_events/messages_reaction_update_chat_event.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message_reaction.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/domain/use_cases/prepare_chat_live_data_client_use_case.dart';
import 'package:picnic_app/utils/extensions/list_extension.dart';

typedef GetChatMessagesProvider = List<ChatMessage>? Function({required Id chatId});
typedef OnChatMessagesUpdatedCallback = Function({required Id chatId, required List<ChatMessage> chatMessages});

/// [LiveChatsPresenter] helps handle live updates to [ChatMessage] lists for one or multiple chats at the same moment.
class LiveChatsPresenter {
  LiveChatsPresenter(
    this.getChatEventUseCase,
    this.userStore,
  );

  final PrepareChatLiveDataClientUseCase getChatEventUseCase;
  final UserStore userStore;
  LiveDataClient<ChatEvent>? liveDataClient;

  late final GetChatMessagesProvider getChatMessagesProvider;
  late final OnChatMessagesUpdatedCallback onChatMessagesUpdatedCallback;

  StreamSubscription<dynamic>? _getChatEventsSubscription;

  /// [onInit] needs to be called to initialize chatLiveDataClient and provide callback functions.
  /// [getChatMessagesProvider] is used to get current [ChatMessage] list in the chat by [Id].
  /// [onChatMessagesUpdatedCallback] will be called with updated [ChatMessage] list for the chat by [Id].
  /// [onChatMessagesUpdatedCallback] will be called each time the new event was received from the server.
  Future<void> onInit({
    required GetChatMessagesProvider getChatMessagesProvider,
    required OnChatMessagesUpdatedCallback onChatMessagesUpdatedCallback,
  }) async {
    this.getChatMessagesProvider = getChatMessagesProvider;
    this.onChatMessagesUpdatedCallback = onChatMessagesUpdatedCallback;
    await _createChatLiveDataClient();
  }

  Future<void> dispose() async {
    await _getChatEventsSubscription?.cancel();
    await liveDataClient?.dispose();
  }

  Future<void> subscribeToChannels({required List<Id> chatIds}) async {
    await Future.wait(chatIds.map((id) => liveDataClient?.subscribeToChannel(id) ?? Future.value()));
  }

  Future<void> connect() async {
    await _createChatLiveDataClient();
  }

  Future<void> disconnect() async {
    await liveDataClient?.disconnect();
  }

  Future<void> _createChatLiveDataClient() async {
    final client = await getChatEventUseCase.execute();
    liveDataClient = client;

    _getChatEventsSubscription = client.eventsStream.listen((event) {
      event.when(
        channelEventReceived: (channelEvent, channelId) {
          channelEvent.when(
            newMessagesReceived: (event) => _handleOnNewMessageReceived(event: event, chatId: channelId),
            messageDeleted: (event) => _handleOnMessageDeleted(event: event, chatId: channelId),
            messageUpdated: (event) => _handleOnMessageUpdatedReceived(event: event, chatId: channelId),
            messageReactionUpdated: (event) => _handleOnMessagesReactionUpdateReceived(event: event, chatId: channelId),
          );
        },
      );
    });
  }

  void _handleOnNewMessageReceived({required MessageReceivedChatEvent event, required Id chatId}) {
    final message = event.message;
    if (message.author.id == userStore.privateProfile.user.id) {
      return;
    }

    final chatMessages = getChatMessagesProvider(chatId: chatId);

    if (chatMessages != null) {
      onChatMessagesUpdatedCallback(
        chatId: chatId,
        chatMessages: List.unmodifiable([message] + chatMessages),
      );
    }
  }

  void _handleOnMessageDeleted({required MessageDeletedChatEvent event, required Id chatId}) {
    final chatMessages = getChatMessagesProvider(chatId: chatId);
    final message = chatMessages?.firstWhereOrNull((x) => x.id == event.messageId);

    if (chatMessages != null && message != null) {
      onChatMessagesUpdatedCallback(
        chatId: chatId,
        chatMessages: List.unmodifiable([...chatMessages]..remove(message)),
      );
    }
  }

  void _handleOnMessageUpdatedReceived({required MessageUpdatedChatEvent event, required Id chatId}) {
    final chatMessages = getChatMessagesProvider(chatId: chatId);
    final message = event.message;

    if (chatMessages != null) {
      onChatMessagesUpdatedCallback(
        chatId: chatId,
        chatMessages: chatMessages.byUpdatingItem(
          itemFinder: (it) => it.id == message.id,
          update: (_) => message,
        ),
      );
    }
  }

  void _handleOnMessagesReactionUpdateReceived({required MessagesReactionUpdateChatEvent event, required Id chatId}) {
    final chatMessages = getChatMessagesProvider(chatId: chatId);

    if (chatMessages != null) {
      onChatMessagesUpdatedCallback(
        chatId: chatId,
        chatMessages: chatMessages.byUpdatingItem(
          itemFinder: (it) => it.id == event.messageId,
          update: (message) {
            final reaction =
                message.reactions.firstWhereOrNull((reaction) => reaction.reactionType == event.reactionType) ??
                    const ChatMessageReaction.empty().copyWith(reactionType: event.reactionType);
            return message.byUpdatingReaction(
              reaction.copyWith(
                count: event.count,
              ),
            );
          },
        ),
      );
    }
  }
}
