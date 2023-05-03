import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/core/utils/utils.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/add_members_list/add_members_list_navigator.dart';
import 'package:picnic_app/features/chat/domain/model/group_chat_more_page_result.dart';
import 'package:picnic_app/features/chat/group_chat_more/group_chat_more_initial_params.dart';
import 'package:picnic_app/features/chat/group_chat_more/group_chat_more_page.dart';
import 'package:picnic_app/features/chat/group_chat_more/widgets/remove_user_content.dart';
import 'package:picnic_app/features/profile/public_profile/public_profile_navigator.dart';
import 'package:picnic_app/features/reports/report_form/report_form_navigator.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';
import 'package:picnic_app/navigation/close_with_result_route.dart';
import 'package:picnic_app/navigation/confirmation_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/ui/widgets/confirmation_bottom_sheet.dart';
import 'package:picnic_app/ui/widgets/picnic_bottom_sheet.dart';

class GroupChatMoreNavigator
    with
        CloseRoute,
        CloseWithResultRoute<GroupChatMorePageResult>,
        ConfirmationBottomSheetRoute,
        RemoveMemberConfirmationRoute,
        DeleteGroupConfirmationRoute,
        ReportFormRoute,
        AddMembersListRoute,
        ErrorBottomSheetRoute,
        PublicProfileRoute {
  GroupChatMoreNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin GroupChatMoreRoute {
  Future<GroupChatMorePageResult?> openGroupChatMore(
    GroupChatMoreInitialParams initialParams,
  ) async {
    return appNavigator.push(
      materialRoute(getIt<GroupChatMorePage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}

mixin RemoveMemberConfirmationRoute {
  void showRemoveMemberConfirmation({
    required VoidCallback onTapRemove,
    required User user,
  }) =>
      showPicnicBottomSheet(
        ConfirmationBottomSheet(
          title: appLocalizations.removeUserAction,
          message: appLocalizations.removeUserMessage,
          primaryAction: ConfirmationAction(
            title: appLocalizations.removeUserAction,
            action: onTapRemove,
          ),
          secondaryAction: ConfirmationAction.negative(
            action: () => appNavigator.close(),
          ),
          contentWidget: RemoveUserContent(user: user),
        ),
      );

  AppNavigator get appNavigator;
}

mixin DeleteGroupConfirmationRoute {
  Future<bool?> showDeleteGroupConfirmationRoute({
    required Future<bool> Function() deleteGroup,
  }) =>
      showPicnicBottomSheet<bool?>(
        ConfirmationBottomSheet(
          title: appLocalizations.deleteGroupTitle,
          message: appLocalizations.deleteGroupMessage,
          primaryAction: ConfirmationAction(
            title: appLocalizations.deleteAction,
            action: () async {
              final result = await deleteGroup();
              if (result) {
                appNavigator.closeWithResult(true);
              }
            },
          ),
          secondaryAction: ConfirmationAction.negative(
            action: () => appNavigator.close(),
          ),
        ),
      );

  AppNavigator get appNavigator;
}
