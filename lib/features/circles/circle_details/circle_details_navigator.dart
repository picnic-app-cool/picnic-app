import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/utils/utils.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/circle_chat/circle_chat_navigator.dart';
import 'package:picnic_app/features/circles/circle_details/circle_details_initial_params.dart';
import 'package:picnic_app/features/circles/circle_details/circle_details_page.dart';
import 'package:picnic_app/features/circles/circle_details/models/posts_sorting_type.dart';
import 'package:picnic_app/features/circles/circle_member_settings/circle_member_settings_navigator.dart';
import 'package:picnic_app/features/circles/circle_role/circle_role_navigator.dart';
import 'package:picnic_app/features/circles/circle_settings/circle_settings_navigator.dart';
import 'package:picnic_app/features/circles/discover_pods/discover_pods_navigator.dart';
import 'package:picnic_app/features/circles/edit_rules/edit_rules_navigator.dart';
import 'package:picnic_app/features/circles/invite_user_list/invite_user_list_navigator.dart';
import 'package:picnic_app/features/circles/members/members_navigator.dart';
import 'package:picnic_app/features/circles/user_roles/user_roles_navigator.dart';
import 'package:picnic_app/features/create_slice/presentation/create_slice_navigator.dart';
import 'package:picnic_app/features/posts/comment_chat/comment_chat_navigator.dart';
import 'package:picnic_app/features/posts/post_creation_index/post_creation_index_navigator.dart';
import 'package:picnic_app/features/posts/save_post_to_collection/save_post_to_collection_navigator.dart';
import 'package:picnic_app/features/posts/single_feed/single_feed_navigator.dart';
import 'package:picnic_app/features/profile/common/profile_route.dart';
import 'package:picnic_app/features/reports/report_form/report_form_navigator.dart';
import 'package:picnic_app/features/seeds/circle_election/circle_election_navigator.dart';
import 'package:picnic_app/features/seeds/circle_governance/circle_governance_navigator.dart';
import 'package:picnic_app/features/seeds/seed_holders/seed_holders_navigator.dart';
import 'package:picnic_app/features/slices/slice_details/slice_details_navigator.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';
import 'package:picnic_app/navigation/close_with_result_route.dart';
import 'package:picnic_app/navigation/confirmation_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/feature_disabled_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/horizontal_action_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/invite_users_route.dart';
import 'package:picnic_app/navigation/share_route.dart';
import 'package:picnic_app/navigation/snack_bar_route.dart';
import 'package:picnic_app/navigation/vertical_action_bottom_sheet_route.dart';
import 'package:picnic_app/ui/widgets/picnic_bottom_sheet.dart';
import 'package:picnic_app/ui/widgets/sort_bottom_sheet.dart';

class CircleDetailsNavigator
    with
        CircleSettingsRoute,
        HorizontalActionBottomSheetRoute,
        CloseRoute,
        ShareRoute,
        ReportFormRoute,
        ErrorBottomSheetRoute,
        CircleChatRoute,
        SeedHoldersRoute,
        EditRulesRoute,
        MembersRoute,
        ProfileRoute,
        ConfirmationBottomSheetRoute,
        PostCreationIndexRoute,
        SnackBarRoute,
        InviteUserListRoute,
        SingleFeedRoute,
        CloseWithResultRoute<bool>,
        SortPostsBottomSheetRoute,
        CreateSliceRoute,
        SliceDetailsRoute,
        VerticalActionBottomSheetRoute,
        CircleElectionRoute,
        FeatureDisabledBottomSheetRoute,
        CircleGovernanceRoute,
        CommentChatRoute,
        SavePostToCollectionRoute,
        CircleMemberSettingsRoute,
        CircleRoleRoute,
        InviteUsersRoute,
        UserRolesRoute,
        DiscoverPodsRoute {
  CircleDetailsNavigator(this.appNavigator, this.userStore);

  @override
  final AppNavigator appNavigator;

  @override
  final UserStore userStore;

  void showDeletePostConfirmation({
    required String title,
    required VoidCallback onDelete,
    required VoidCallback onClose,
  }) =>
      showVerticalActionBottomSheet(
        title: title,
        description: appLocalizations.deletePostsConfirmationMessage,
        actions: [
          ActionBottom(
            label: appLocalizations.deleteMessageConfirmAction,
            isPrimary: true,
            action: onDelete,
          ),
        ],
        onTapClose: onClose,
      );
}

mixin CircleDetailsRoute {
  Future<bool?> openCircleDetails(CircleDetailsInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<CircleDetailsPage>(param1: initialParams)),
      useRoot: true,
    );
  }

  AppNavigator get appNavigator;
}

mixin SortPostsBottomSheetRoute {
  Future<void> openSortPostsBottomSheet({
    required void Function(PostsSortingType) onTapSort,
    required List<PostsSortingType> sortOptions,
    required PostsSortingType selectedSortOption,
  }) async {
    return showPicnicBottomSheet(
      SortBottomSheet<PostsSortingType>(
        onTapSort: onTapSort,
        onTapClose: appNavigator.close,
        sortOptions: sortOptions,
        selectedSortOption: selectedSortOption,
        valueToDisplay: (value) => value.valueToDisplay,
      ),
    );
  }

  AppNavigator get appNavigator;
}
