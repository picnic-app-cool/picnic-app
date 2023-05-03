import 'package:picnic_app/core/utils/utils.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/chat_dms/chat_dms_initial_params.dart';
import 'package:picnic_app/features/chat/chat_dms/chat_dms_page.dart';
import 'package:picnic_app/features/chat/circle_chat/circle_chat_navigator.dart';
import 'package:picnic_app/features/chat/group_chat/group_chat_navigator.dart';
import 'package:picnic_app/features/chat/new_message/new_message_navigator.dart';
import 'package:picnic_app/features/chat/single_chat/single_chat_navigator.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';
import 'package:picnic_app/navigation/close_with_result_route.dart';
import 'package:picnic_app/navigation/confirmation_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/ui/widgets/confirmation_bottom_sheet.dart';
import 'package:picnic_app/ui/widgets/picnic_bottom_sheet.dart';

class ChatDmsNavigator
    with
        CloseWithResultRoute<bool>,
        ErrorBottomSheetRoute,
        ChatDmsRoute,
        NewMessageRoute,
        ConfirmationBottomSheetRoute,
        GroupChatRoute,
        SingleChatRoute,
        CircleChatRoute,
        CloseRoute,
        ConfirmLeaveChatRoute {
  ChatDmsNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin ChatDmsRoute {
  Future<void> openChatDms(ChatDmsInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<ChatDmsPage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}

mixin ConfirmLeaveChatRoute {
  Future<bool?> showConfirmLeaveChatRoute({
    required VoidCallback onTapLeave,
  }) =>
      showPicnicBottomSheet<bool?>(
        useRootNavigator: true,
        ConfirmationBottomSheet(
          title: appLocalizations.leaveChat,
          message: appLocalizations.leaveChatMessage,
          primaryAction: ConfirmationAction(
            title: appLocalizations.leaveAction,
            action: () {
              onTapLeave.call();
              appNavigator.closeWithResult(true);
            },
          ),
          secondaryAction: ConfirmationAction.negative(
            action: () => appNavigator.close(),
          ),
        ),
      );

  AppNavigator get appNavigator;
}
