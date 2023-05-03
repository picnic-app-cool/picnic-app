import 'package:picnic_app/features/chat/chat_tabs/chat_tabs_initial_params.dart';
import 'package:picnic_app/features/chat/domain/model/chat_tab_type.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class ChatTabsPresentationModel implements ChatTabsViewModel {
  /// Creates the initial state
  ChatTabsPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    ChatTabsInitialParams initialParams,
  ) : selectedChatTabType = ChatTabType.feed;

  /// Used for the copyWith method
  ChatTabsPresentationModel._({required this.selectedChatTabType});

  @override
  final ChatTabType selectedChatTabType;

  ChatTabsPresentationModel copyWith({
    ChatTabType? selectedChatTabType,
  }) {
    return ChatTabsPresentationModel._(
      selectedChatTabType: selectedChatTabType ?? this.selectedChatTabType,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class ChatTabsViewModel {
  ChatTabType get selectedChatTabType;
}
