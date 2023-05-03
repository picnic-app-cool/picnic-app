import 'dart:async';

import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/live_data_client.dart';
import 'package:picnic_app/core/domain/model/connection_status_changed_event.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/repositories/attachment_repository.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/domain/use_cases/join_circle_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/upload_attachment_use_case.dart';
import 'package:picnic_app/core/utils/current_time_provider.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/utils/logging.dart';
import 'package:picnic_app/features/chat/domain/model/attachment.dart';
import 'package:picnic_app/features/chat/domain/model/basic_chat.dart';
import 'package:picnic_app/features/chat/domain/model/chat_events/chat_event.dart';
import 'package:picnic_app/features/chat/domain/model/chat_events/message_deleted_chat_event.dart';
import 'package:picnic_app/features/chat/domain/model/chat_events/message_received_chat_event.dart';
import 'package:picnic_app/features/chat/domain/model/chat_events/message_updated_chat_event.dart';
import 'package:picnic_app/features/chat/domain/model/chat_events/messages_reaction_update_chat_event.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message_reaction.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message_status.dart';
import 'package:picnic_app/features/chat/domain/model/chat_messages_action.dart';
import 'package:picnic_app/features/chat/domain/model/chat_messages_failure.dart';
import 'package:picnic_app/features/chat/domain/model/displayable_chat_message.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/domain/use_cases/delete_message_use_case.dart';
import 'package:picnic_app/features/chat/domain/use_cases/get_messages_in_chat_use_case.dart';
import 'package:picnic_app/features/chat/domain/use_cases/get_upload_chat_attachment_use_case.dart';
import 'package:picnic_app/features/chat/domain/use_cases/mark_message_as_read_use_case.dart';
import 'package:picnic_app/features/chat/domain/use_cases/prepare_chat_live_data_client_use_case.dart';
import 'package:picnic_app/features/chat/domain/use_cases/react_on_chat_message_use_case.dart';
import 'package:picnic_app/features/chat/domain/use_cases/send_chat_message_use_case.dart';
import 'package:picnic_app/utils/clipboard_manager.dart';

class ChatMessagesUseCase {
  ChatMessagesUseCase(
    this._chat,
    this._clipboardManager,
    this._getChatEventUseCase,
    this._getMessagesInChatUseCase,
    this._sendChatMessageUseCase,
    this._deleteMessageUseCase,
    this._reactOnChatMessageUseCase,
    this._joinCircleUseCase,
    this._uploadAttachmentUseCase,
    this._attachmentRepository,
    this._getUploadChatAttachmentUseCase,
    this._markMessageAsReadUseCase,
    this._userStore,
    this._currentTimeProvider,
  ) : _messages = _chat.latestMessages;

  final BasicChat _chat;
  final ClipboardManager _clipboardManager;
  final PrepareChatLiveDataClientUseCase _getChatEventUseCase;
  final GetMessagesInChatUseCase _getMessagesInChatUseCase;
  final SendChatMessageUseCase _sendChatMessageUseCase;
  final DeleteMessageUseCase _deleteMessageUseCase;
  final ReactOnChatMessageUseCase _reactOnChatMessageUseCase;
  final JoinCircleUseCase _joinCircleUseCase;
  final UploadAttachmentUseCase _uploadAttachmentUseCase;
  final AttachmentRepository _attachmentRepository;
  final GetUploadChatAttachmentUseCase _getUploadChatAttachmentUseCase;
  final MarkMessageAsReadUseCase _markMessageAsReadUseCase;
  final UserStore _userStore;
  final CurrentTimeProvider _currentTimeProvider;
  LiveDataClient<ChatEvent>? _chatDataClient;
  StreamSubscription<dynamic>? _userUpdateSubscription;
  StreamSubscription<dynamic>? _getChatEventsSubscription;

  PaginatedList<ChatMessage> _messages;
  late StreamController<PaginatedList<DisplayableChatMessage>> _controller;

  Cursor get _messagesCursor => _messages.nextPageCursor();

  Stream<PaginatedList<DisplayableChatMessage>> get _stream => _controller.stream;

  Future<Either<ChatMessagesFailure, Stream<PaginatedList<DisplayableChatMessage>>>> execute({
    required ChatMessagesAction action,
  }) =>
      action
          .when(
            init: _init,
            loadMore: _loadMore,
            deleteMessage: _deleteMessage,
            sendMessage: _sendMessage,
            reaction: _reaction,
            copy: _copy,
            joinCircle: _joinCircle,
            unblur: _unblur,
            resend: _resendMessage,
            disconnect: _stopChatEventsListening,
          )
          .mapSuccess((_) => _stream);

  Future<Either<ChatMessagesFailure, Unit>> _init(ChatMessagesActionInit action) async {
    _controller = StreamController<PaginatedList<DisplayableChatMessage>>(
      //Dispose all subscriptions when there is no longer active listeners
      onCancel: () => _dispose(),
    );
    await _startChatEventsListening(chatIds: action.chatIds);
    await _markMessagesAsRead();
    return success(unit);
  }

  Future<void> _dispose() async {
    await _getChatEventsSubscription?.cancel();
    await _userUpdateSubscription?.cancel();
    await _chatDataClient?.dispose();
  }

  Future<void> _startChatEventsListening({required List<Id> chatIds}) async {
    final client = await _getChatEventUseCase.execute();
    _chatDataClient = client;

    _getChatEventsSubscription = client.eventsStream.listen(
      (event) => event.when(
        channelEventReceived: (channelEvent, channelId) {
          if (!chatIds.contains(channelId)) {
            return;
          }
          channelEvent.when(
            connectionStatusChanged: _handleOnConnectionStatusChangedChatEvent,
            newMessagesReceived: _handleOnNewMessageReceived,
            messageReactionUpdated: _handleOnMessagesReactionUpdateReceived,
            messageUpdated: _handleOnMessageUpdatedReceived,
            messageDeleted: _handleOnMessageDeleted,
          );
        },
      ),
    );
    await Future.wait(chatIds.map((id) => client.subscribeToChannel(id)));
  }

  Future<Either<ChatMessagesFailure, Unit>> _stopChatEventsListening(ChatMessagesActionDisconnect action) async {
    await _chatDataClient?.disconnect();
    return success(unit);
  }

  void _handleOnConnectionStatusChangedChatEvent(ConnectionStatusChangedEvent event) => debugLog("$event");

  void _handleOnNewMessageReceived(MessageReceivedChatEvent event) {
    final message = event.message;
    //For the glitter bomb message we should display regardless of author
    if (message.isGlitterBomb || message.author.id != _userStore.privateProfile.user.id) {
      _emitMessages(
        _messages.byAppendingSingleMessageToHead(message),
      );
    }
  }

  void _handleOnMessagesReactionUpdateReceived(MessagesReactionUpdateChatEvent event) => _emitMessages(
        _messages.byUpdatingItem(
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

  void _handleOnMessageUpdatedReceived(MessageUpdatedChatEvent event) {
    final message = event.message;
    _emitMessages(
      _messages.byUpdatingItem(
        itemFinder: (it) => it.id == message.id,
        update: (_) => message,
      ),
    );
  }

  void _handleOnMessageDeleted(MessageDeletedChatEvent event) {
    final message = _messages.items.firstWhereOrNull((x) => x.id == event.messageId);
    if (message != null) {
      _emitMessages(
        _messages.byRemoving(element: message),
      );
    }
  }

  // ignore: long-method
  Future<void> _emitMessages(PaginatedList<ChatMessage> messages) async {
    final newMessagesItems = await Future.wait(
      messages.items.map((message) async {
        var resultMessage = message;
        if (message.author.id == _userStore.privateProfile.id) {
          resultMessage = message.copyWith(
            author: _userStore.privateProfile.user,
          );
        }

        if (resultMessage.attachments.isNotEmpty) {
          resultMessage = resultMessage.copyWith(
            attachments: await _getUpdatedIsBlurredAttachments(resultMessage.attachments),
          );
        }

        final repliedContentAttachments = resultMessage.repliedContent?.attachments;

        if (repliedContentAttachments != null && repliedContentAttachments.isNotEmpty) {
          resultMessage = resultMessage.copyWith(
            repliedContent: resultMessage.repliedContent!.copyWith(
              attachments: await _getUpdatedIsBlurredAttachments(repliedContentAttachments),
            ),
          );
        }

        return resultMessage;
      }),
    );

    _messages = messages.copyWith(items: newMessagesItems);
    _controller.add(
      _getDisplayableChatMessages(),
    );
  }

  Future<List<Attachment>> _getUpdatedIsBlurredAttachments(List<Attachment> attachments) async {
    return Future.wait(
      attachments.map((attachment) async {
        final isBlurred =
            (await _attachmentRepository.getIsBlurredAttachment(attachmentId: attachment.id)).getSuccess();
        return isBlurred != null ? attachment.copyWith(isBlurred: isBlurred) : attachment;
      }),
    );
  }

  Future<Either<ChatMessagesFailure, Unit>> _loadMore(ChatMessagesActionLoadMore action) => _getMessagesInChatUseCase
      .execute(
        chatId: _chat.id,
        nextPageCursor: _messagesCursor,
      )
      .mapFailure((fail) => ChatMessagesFailure.unknown(fail))
      .doOn(
        success: (list) => _emitMessages(
          _messages.byAppending(list),
        ),
      )
      .mapSuccess((_) => unit);

  Future<Either<ChatMessagesFailure, Unit>> _deleteMessage(ChatMessagesActionDeleteMessage action) async {
    final message = action.message;

    if (message.isNotSent) {
      await _emitMessages(_messages.byRemoving(element: message));
      return success(unit);
    }

    return _deleteMessageUseCase
        .execute(
          messageId: message.id,
        )
        .mapFailure((fail) => ChatMessagesFailure.unknown(fail))
        .doOn(
          success: (_) => _emitMessages(
            _messages.byRemoving(element: message),
          ),
        )
        .mapSuccess((_) => unit);
  }

  ChatMessage _preparePendingMessage(ChatMessagesActionSendMessage action) {
    return action.message.copyWith(
      repliedContent: action.replyToMessage,
      author: _userStore.privateProfile.user,
      createdAtString: _currentTimeProvider.currentTime.toIso8601String(),
    );
  }

  //ignore: long-method
  Future<Either<ChatMessagesFailure, Unit>> _sendMessage(ChatMessagesActionSendMessage action) async {
    final pendingMessage = _preparePendingMessage(action);

    await _emitMessages(
      _messages.byAppendingSingleMessageToHead(pendingMessage),
    );

    return action.message.attachments
        .map((attachment) => _getUploadChatAttachmentUseCase.execute(attachment: attachment))
        .zip()
        .mapFailure(ChatMessagesFailure.unknown)
        .flatMap(
          (attachments) =>
              _uploadAttachmentUseCase.execute(attachments: attachments).mapFailure(ChatMessagesFailure.unknown),
        )
        .mapSuccess(
          (attachments) => action.getMessageInput(withAttachments: attachments),
        )
        .flatMap(
          (messageInput) => _sendChatMessageUseCase
              .execute(
                chatId: _chat.id,
                message: messageInput,
              )
              .mapFailure((fail) => ChatMessagesFailure.unknown(fail))
              .doOnSuccessWait(
                (message) => _emitMessages(
                  _messages
                      .byRemoving(element: pendingMessage) //
                      .byAppendingSingleMessageToHead(
                        message.copyWith(
                          author: _userStore.privateProfile.user,
                        ),
                      ),
                ),
              )
              .doOn(
                fail: (_) => _emitMessages(
                  _messages.byUpdatingSentStatus(message: pendingMessage, status: ChatMessageStatus.notSent),
                ),
              )
              .mapSuccess((_) => unit),
        );
  }

  Future<Either<ChatMessagesFailure, Unit>> _markMessagesAsRead() => _markMessageAsReadUseCase
      .execute(
        lastSeenMessageId: _messages.firstOrNull?.id,
      )
      .mapFailure((fail) => ChatMessagesFailure.unknown(fail))
      .mapSuccess((_) => unit);

  Future<Either<ChatMessagesFailure, Unit>> _reaction(ChatMessagesActionReaction action) async {
    final result = await _unreactPreviousReaction(action);

    if (result.isFailure) {
      return result;
    }

    final reaction =
        action.message.reactions.firstWhereOrNull((element) => element.reactionType == action.reactionType);

    final reactAction =
        (reaction == null || !reaction.hasReacted) ? ReactOnChatMessageAction.react : ReactOnChatMessageAction.unreact;

    return _reactOnChatMessageUseCase
        .execute(
          messageId: action.message.id,
          action: reactAction,
          reactionType: action.reactionType,
        )
        .mapFailure((fail) => ChatMessagesFailure.unknown(fail))
        .doOn(
          success: (reaction) => _emitMessages(
            _messages.byUpdatingReaction(
              messageId: action.message.id,
              reaction: reaction,
            ),
          ),
        )
        .mapSuccess((_) => unit);
  }

  Future<Either<ChatMessagesFailure, Unit>> _unreactPreviousReaction(ChatMessagesActionReaction action) async {
    final previousReaction = action.message.reactions.firstWhereOrNull((element) => element.hasReacted);

    if (previousReaction == null) {
      return success(unit);
    }

    return _reactOnChatMessageUseCase
        .execute(
          messageId: action.message.id,
          action: ReactOnChatMessageAction.unreact,
          reactionType: previousReaction.reactionType,
        )
        .mapFailure((fail) => ChatMessagesFailure.unknown(fail))
        .doOnSuccessWait(
          (reaction) => _emitMessages(
            _messages.byUpdatingReaction(
              messageId: action.message.id,
              reaction: reaction,
            ),
          ),
        )
        .mapSuccess((_) => unit);
  }

  Future<Either<ChatMessagesFailure, Unit>> _copy(ChatMessagesActionCopy action) async {
    final content = action.message.content;
    await _clipboardManager.saveText(content);
    return success(unit);
  }

  Future<Either<ChatMessagesFailure, Unit>> _joinCircle(ChatMessagesActionJoinCircle action) => _joinCircleUseCase
      .execute(
        circle: action.circle,
      )
      .mapFailure((fail) => ChatMessagesFailure.unknown(fail))
      .mapSuccess((_) => unit);

  Future<Either<ChatMessagesFailure, Unit>> _unblur(ChatMessagesActionUnblur action) => _attachmentRepository
      .unBlurAttachment(
        attachmentId: action.attachmentId,
      )
      .mapFailure(ChatMessagesFailure.unknown)
      .doOn(
        success: (_) => _emitMessages(_messages),
      );

  PaginatedList<DisplayableChatMessage> _getDisplayableChatMessages() => _messages.toDisplayableChatMessages(
        privateProfile: _userStore.privateProfile,
      );

  Future<Either<ChatMessagesFailure, Unit>> _resendMessage(ChatMessagesActionResendMessage action) async {
    await _emitMessages(_messages.byRemoving(element: action.message));
    return _sendMessage(action);
  }
}

extension ChatMessagesListExtension on PaginatedList<ChatMessage> {
  PaginatedList<DisplayableChatMessage> toDisplayableChatMessages({
    required PrivateProfile privateProfile,
  }) =>
      PaginatedList(
        pageInfo: pageInfo,
        items: items.byUpdatingSender(privateProfile.user).byWrappingMessages(),
      );

  PaginatedList<ChatMessage> byAppendingSingleMessageToHead(ChatMessage message) => copyWith(
        items: List.unmodifiable([message] + items),
      );

  PaginatedList<ChatMessage> byUpdatingReaction({
    required Id messageId,
    required ChatMessageReaction reaction,
  }) =>
      byUpdatingItem(
        update: (message) => message.byUpdatingReaction(reaction),
        itemFinder: (it) => it.id == messageId,
      );

  PaginatedList<ChatMessage> byUpdatingSentStatus({
    required ChatMessage message,
    required ChatMessageStatus status,
  }) =>
      byUpdatingItem(
        update: (message) => message.copyWith(chatMessageStatus: status),
        itemFinder: (it) => it.id == message.id,
      );
}
