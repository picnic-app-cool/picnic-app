import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/paginated_list_presenter/paginated_list_presentation_model.dart';
import 'package:picnic_app/features/chat/chat_feed/chat_feed_initial_params.dart';
import 'package:picnic_app/features/chat/domain/model/chat.dart';
import 'package:picnic_app/features/chat/domain/model/chat_excerpt.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message.dart';
import 'package:picnic_app/features/chat/domain/model/chat_messages_feed.dart';
import 'package:picnic_app/features/chat/domain/model/get_chat_failure.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class ChatFeedPresentationModel implements ChatFeedViewModel {
  /// Creates the initial state
  ChatFeedPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    ChatFeedInitialParams initialParams,
    UserStore userStore,
  )   : chatExcerpts = PaginatedListPresentationModel(),
        chatExcerptsResults = const FutureResult.empty(),
        ignoreViewDidAppear = true,
        privateProfile = userStore.privateProfile,
        chatOpenResult = const FutureResult.empty();

  /// Used for the copyWith method
  ChatFeedPresentationModel._({
    required this.chatExcerpts,
    required this.chatExcerptsResults,
    required this.privateProfile,
    required this.ignoreViewDidAppear,
    required this.chatOpenResult,
  });

  final PaginatedListPresentationModel<ChatExcerpt> chatExcerpts;

  final FutureResult<void> chatExcerptsResults;

  final PrivateProfile privateProfile;

  final bool ignoreViewDidAppear;

  final FutureResult<Either<GetChatFailure, Chat>> chatOpenResult;

  @override
  bool get chatDetailsButtonEnabled => !chatOpenResult.isPending();

  bool get isLoadingChatExcerpts => chatExcerptsResults.isPending();

  @override
  PaginatedList<ChatMessagesFeed> get chatMessagesFeedList => chatExcerpts.paginatedList.mapItems(
        (chatExcerpt) => chatExcerpt.chatMessagesFeed.copyWith(
          messages: chatExcerpt.chatMessagesFeed.messages.byUpdatingSender(privateProfile.user),
        ),
      );

  ChatFeedPresentationModel copyWith({
    PaginatedListPresentationModel<ChatExcerpt>? chatExcerpts,
    FutureResult<void>? chatExcerptsResults,
    PrivateProfile? privateProfile,
    bool? ignoreViewDidAppear,
    FutureResult<Either<GetChatFailure, Chat>>? chatOpenResult,
  }) {
    return ChatFeedPresentationModel._(
      chatExcerpts: chatExcerpts ?? this.chatExcerpts,
      chatExcerptsResults: chatExcerptsResults ?? this.chatExcerptsResults,
      privateProfile: privateProfile ?? this.privateProfile,
      ignoreViewDidAppear: ignoreViewDidAppear ?? this.ignoreViewDidAppear,
      chatOpenResult: chatOpenResult ?? this.chatOpenResult,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class ChatFeedViewModel {
  PaginatedList<ChatMessagesFeed> get chatMessagesFeedList;

  bool get chatDetailsButtonEnabled;
}

extension ChatExcerptMapper on ChatExcerpt {
  ChatMessagesFeed get chatMessagesFeed => ChatMessagesFeed(
        circle: circle,
        name: name,
        membersCount: participantsCount,
        messages: messages,
      );
}
