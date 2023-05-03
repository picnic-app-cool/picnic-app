import 'package:picnic_app/features/chat/chat_deep_link_routing/chat_deeplink_routing.dart';
import 'package:picnic_app/features/chat/domain/model/chat.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class ChatDeeplinkRoutingPresentationModel implements ChatDeeplinkRoutingViewModel {
  /// Creates the initial state
  ChatDeeplinkRoutingPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    ChatDeeplinkRoutingInitialParams initialParams,
  ) : chatId = initialParams.chatId;

  /// Used for the copyWith method
  ChatDeeplinkRoutingPresentationModel._({
    required this.chatId,
  });

  final Id chatId;

  ChatDeeplinkRoutingPresentationModel copyWith({Chat? chat}) {
    return ChatDeeplinkRoutingPresentationModel._(
      chatId: chatId,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class ChatDeeplinkRoutingViewModel {}
