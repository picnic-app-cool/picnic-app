import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/current_time_provider.dart';
import 'package:picnic_app/features/chat/chat_my_circles/chat_my_circles_initial_params.dart';
import 'package:picnic_app/features/chat/domain/model/chat.dart';
import 'package:picnic_app/features/chat/domain/model/chat_list_item_displayable.dart';
import 'package:picnic_app/ui/widgets/achievement_badge/model/badged_title_displayable.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class ChatMyCirclesPresentationModel implements ChatMyCirclesViewModel {
  /// Creates the initial state
  ChatMyCirclesPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    ChatMyCirclesInitialParams initialParams,
    this.currentTimeProvider,
  )   : circleChats = const PaginatedList.empty(),
        circlesSearchText = '',
        ignoreViewDidAppear = true,
        chatResults = const FutureResult.empty();

  /// Used for the copyWith method
  ChatMyCirclesPresentationModel._({
    required this.currentTimeProvider,
    required this.circleChats,
    required this.circlesSearchText,
    required this.ignoreViewDidAppear,
    required this.chatResults,
  });

  final CurrentTimeProvider currentTimeProvider;

  final String circlesSearchText;

  final PaginatedList<Chat> circleChats;

  final bool ignoreViewDidAppear;

  final FutureResult<void> chatResults;

  @override
  PaginatedList<ChatListItemDisplayable> get circleChatItems => circleChats.mapItems(
        (chat) => ChatListItemDisplayable(
          chat: chat.toBasicChat(),
          title: BadgedTitleDisplayable(name: chat.name),
          circle: chat.circle,
        ),
      );

  Cursor get nextPageCursor => circleChats.nextPageCursor(pageSize: Cursor.extendedPageSize);

  bool get isLoadingChat => chatResults.isPending();

  @override
  DateTime get now => currentTimeProvider.currentTime;

  ChatMyCirclesPresentationModel byAppendingCirclesList(PaginatedList<Chat> newList) => copyWith(
        circleChats: circleChats + newList,
      );

  ChatMyCirclesPresentationModel copyWith({
    CurrentTimeProvider? currentTimeProvider,
    String? circlesSearchText,
    PaginatedList<Chat>? circleChats,
    bool? ignoreViewDidAppear,
    FutureResult<void>? chatResults,
  }) {
    return ChatMyCirclesPresentationModel._(
      currentTimeProvider: currentTimeProvider ?? this.currentTimeProvider,
      circlesSearchText: circlesSearchText ?? this.circlesSearchText,
      circleChats: circleChats ?? this.circleChats,
      ignoreViewDidAppear: ignoreViewDidAppear ?? this.ignoreViewDidAppear,
      chatResults: chatResults ?? this.chatResults,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class ChatMyCirclesViewModel {
  PaginatedList<ChatListItemDisplayable> get circleChatItems;

  DateTime get now;
}
