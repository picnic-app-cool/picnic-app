import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/current_time_provider.dart';
import 'package:picnic_app/core/utils/paginated_list_presenter/paginated_list_presentation_model.dart';
import 'package:picnic_app/features/chat/chat_dms/chat_dms_initial_params.dart';
import 'package:picnic_app/features/chat/domain/model/basic_chat.dart';
import 'package:picnic_app/features/chat/domain/model/chat_list_item_displayable.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message.dart';
import 'package:picnic_app/features/chat/domain/model/get_chat_messages_list_failure.dart';
import 'package:picnic_app/features/chat/domain/model/get_single_chat_recipient_failure.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class ChatDmsPresentationModel implements ChatDmsViewModel {
  /// Creates the initial state
  ChatDmsPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    ChatDmsInitialParams initialParams,
    this.currentTimeProvider,
  )   : messagesResult = const FutureResult.empty(),
        chats = PaginatedListPresentationModel(),
        ignoreViewDidAppear = true,
        chatResults = const FutureResult.empty(),
        chatOpenResult = const FutureResult.empty();

  /// Used for the copyWith method
  ChatDmsPresentationModel._({
    required this.currentTimeProvider,
    required this.messagesResult,
    required this.chats,
    required this.ignoreViewDidAppear,
    required this.chatResults,
    required this.chatOpenResult,
  });

  @override
  final PaginatedListPresentationModel<ChatListItemDisplayable> chats;

  final CurrentTimeProvider currentTimeProvider;

  final FutureResult<Either<GetChatMessagesListFailure, PaginatedList<ChatMessage>>> messagesResult;

  final FutureResult<void> chatResults;

  final FutureResult<Either<GetSingleChatRecipientFailure, User>> chatOpenResult;

  final bool ignoreViewDidAppear;

  @override
  bool get chatDetailsButtonEnabled => !chatOpenResult.isPending();

  bool get isLoadingChat => chatResults.isPending();

  @override
  PaginatedList<ChatMessage> get dmMessages => messagesResult.getSuccess() ?? const PaginatedList.empty();

  @override
  DateTime get now => currentTimeProvider.currentTime;

  ChatDmsPresentationModel byUpdatingUnreadMessageCounter({required BasicChat chat, required int count}) => copyWith(
        chats: chats.copyWith(
          paginatedList: chats.paginatedList.byUpdatingItem(
            itemFinder: (it) => it.chat.id == chat.id,
            update: (it) => it.copyWith(
              chat: it.chat.copyWith(unreadMessagesCount: count),
            ),
          ),
        ),
      );

  ChatDmsPresentationModel byRemovingChat(BasicChat chat) => copyWith(
        chats: chats.copyWith(
          paginatedList: chats.paginatedList.byRemovingWhere((element) => element.chat == chat),
        ),
      );

  ChatDmsPresentationModel copyWith({
    PaginatedListPresentationModel<ChatListItemDisplayable>? chats,
    CurrentTimeProvider? currentTimeProvider,
    FutureResult<Either<GetChatMessagesListFailure, PaginatedList<ChatMessage>>>? messagesResult,
    FutureResult<void>? chatResults,
    FutureResult<Either<GetSingleChatRecipientFailure, User>>? chatOpenResult,
    bool? ignoreViewDidAppear,
  }) {
    return ChatDmsPresentationModel._(
      chats: chats ?? this.chats,
      currentTimeProvider: currentTimeProvider ?? this.currentTimeProvider,
      messagesResult: messagesResult ?? this.messagesResult,
      chatResults: chatResults ?? this.chatResults,
      chatOpenResult: chatOpenResult ?? this.chatOpenResult,
      ignoreViewDidAppear: ignoreViewDidAppear ?? this.ignoreViewDidAppear,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class ChatDmsViewModel {
  PaginatedListPresentationModel<ChatListItemDisplayable> get chats;

  DateTime get now;

  PaginatedList<ChatMessage> get dmMessages;

  bool get chatDetailsButtonEnabled;
}
