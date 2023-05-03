import 'package:picnic_app/features/chat/domain/model/message_action_result/pop_up_menu_item.dart';
import 'package:picnic_app/features/chat/message_actions/message_actions_initial_params.dart';
import 'package:picnic_app/features/chat/message_actions/model/message_actions_open_event.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class MessageActionsPresentationModel extends MessageActionsViewModel {
  /// Creates the initial state
  MessageActionsPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    MessageActionsInitialParams initialParams,
  )   : event = initialParams.event,
        popupMenuItems = initialParams.popupMenuItems;

  /// Used for the copyWith method
  MessageActionsPresentationModel._({
    required this.event,
    required this.popupMenuItems,
  });

  @override
  final MessageActionsOpenEvent event;

  @override
  final List<PopUpMenuItem> popupMenuItems;

  MessageActionsPresentationModel copyWith({
    MessageActionsOpenEvent? event,
    List<PopUpMenuItem>? popupMenuItems,
  }) {
    return MessageActionsPresentationModel._(
      event: event ?? this.event,
      popupMenuItems: popupMenuItems ?? this.popupMenuItems,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class MessageActionsViewModel {
  List<PopUpMenuItem> get popupMenuItems;

  MessageActionsOpenEvent get event;
}
