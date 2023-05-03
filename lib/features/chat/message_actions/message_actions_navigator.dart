import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/delete_multipe_messages/delete_multiple_messages_navigator.dart';
import 'package:picnic_app/features/chat/domain/model/message_action_result/chat_message_reaction_type.dart';
import 'package:picnic_app/features/chat/domain/model/message_action_result/message_action_result.dart';
import 'package:picnic_app/features/chat/domain/model/message_action_result/pop_up_menu_item.dart';
import 'package:picnic_app/features/chat/message_actions/message_actions_initial_params.dart';
import 'package:picnic_app/features/chat/message_actions/message_actions_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';
import 'package:picnic_app/navigation/close_with_result_route.dart';
import 'package:picnic_app/navigation/confirmation_bottom_sheet_route.dart';

class MessageActionsNavigator
    with CloseRoute, CloseWithResultRoute<PopUpMenuItem>, ConfirmationBottomSheetRoute, DeleteMultipleMessagesRoute {
  MessageActionsNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;

  void closeWithReaction(ChatMessageReactionType result) => appNavigator.closeWithResult(result);
}

mixin MessageActionsRoute {
  Future<MessageActionResult?> openMessageActions(MessageActionsInitialParams initialParams) async {
    return appNavigator.push(
      picnicModalRoute(
        getIt<MessageActionsPage>(
          param1: initialParams,
        ),
        durationMillis: Durations.short,
      ),
    );
  }

  AppNavigator get appNavigator;
}
