import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/use_cases/join_circle_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/join_circles_use_case.dart';
import 'package:picnic_app/features/circles/add_circle_pod/add_circle_pod_initial_params.dart';
import 'package:picnic_app/features/circles/add_circle_pod/add_circle_pod_navigator.dart';
import 'package:picnic_app/features/circles/add_circle_pod/add_circle_pod_presentation_model.dart';
import 'package:picnic_app/features/circles/add_circle_pod/add_circle_pod_presenter.dart';
import "package:picnic_app/features/circles/add_word_blacklist/add_black_list_word_initial_params.dart";
import "package:picnic_app/features/circles/add_word_blacklist/add_black_list_word_navigator.dart";
import "package:picnic_app/features/circles/add_word_blacklist/add_black_list_word_presentation_model.dart";
import "package:picnic_app/features/circles/add_word_blacklist/add_black_list_word_presenter.dart";
import 'package:picnic_app/features/circles/ban_user/ban_user_initial_params.dart';
import 'package:picnic_app/features/circles/ban_user/ban_user_navigator.dart';
import 'package:picnic_app/features/circles/ban_user/ban_user_presentation_model.dart';
import 'package:picnic_app/features/circles/ban_user/ban_user_presenter.dart';
import 'package:picnic_app/features/circles/ban_user_list/ban_user_list_initial_params.dart';
import 'package:picnic_app/features/circles/ban_user_list/ban_user_list_navigator.dart';
import 'package:picnic_app/features/circles/ban_user_list/ban_user_list_presentation_model.dart';
import 'package:picnic_app/features/circles/ban_user_list/ban_user_list_presenter.dart';
import 'package:picnic_app/features/circles/banned_users/banned_users_initial_params.dart';
import 'package:picnic_app/features/circles/banned_users/banned_users_navigator.dart';
import 'package:picnic_app/features/circles/banned_users/banned_users_presentation_model.dart';
import 'package:picnic_app/features/circles/banned_users/banned_users_presenter.dart';
import "package:picnic_app/features/circles/blacklisted_words/blacklisted_words_initial_params.dart";
import "package:picnic_app/features/circles/blacklisted_words/blacklisted_words_navigator.dart";
import "package:picnic_app/features/circles/blacklisted_words/blacklisted_words_presentation_model.dart";
import "package:picnic_app/features/circles/blacklisted_words/blacklisted_words_presenter.dart";
import 'package:picnic_app/features/circles/circle_config/circle_config_initial_params.dart';
import 'package:picnic_app/features/circles/circle_config/circle_config_navigator.dart';
import 'package:picnic_app/features/circles/circle_config/circle_config_presentation_model.dart';
import 'package:picnic_app/features/circles/circle_config/circle_config_presenter.dart';
import 'package:picnic_app/features/circles/circle_details/circle_details_initial_params.dart';
import 'package:picnic_app/features/circles/circle_details/circle_details_navigator.dart';
import 'package:picnic_app/features/circles/circle_details/circle_details_presentation_model.dart';
import 'package:picnic_app/features/circles/circle_details/circle_details_presenter.dart';
import 'package:picnic_app/features/circles/circle_groups_selection/circle_groups_selection_initial_params.dart';
import 'package:picnic_app/features/circles/circle_groups_selection/circle_groups_selection_navigator.dart';
import 'package:picnic_app/features/circles/circle_groups_selection/circle_groups_selection_presentation_model.dart';
import 'package:picnic_app/features/circles/circle_groups_selection/circle_groups_selection_presenter.dart';
import 'package:picnic_app/features/circles/circle_member_settings/circle_member_settings_initial_params.dart';
import 'package:picnic_app/features/circles/circle_member_settings/circle_member_settings_navigator.dart';
import 'package:picnic_app/features/circles/circle_member_settings/circle_member_settings_presentation_model.dart';
import 'package:picnic_app/features/circles/circle_member_settings/circle_member_settings_presenter.dart';
import 'package:picnic_app/features/circles/circle_role/circle_role_initial_params.dart';
import 'package:picnic_app/features/circles/circle_role/circle_role_navigator.dart';
import 'package:picnic_app/features/circles/circle_role/circle_role_presentation_model.dart';
import 'package:picnic_app/features/circles/circle_role/circle_role_presenter.dart';
import 'package:picnic_app/features/circles/circle_settings/circle_settings_initial_params.dart';
import 'package:picnic_app/features/circles/circle_settings/circle_settings_navigator.dart';
import 'package:picnic_app/features/circles/circle_settings/circle_settings_presentation_model.dart';
import 'package:picnic_app/features/circles/circle_settings/circle_settings_presenter.dart';
import 'package:picnic_app/features/circles/discover_pods/discover_pods_initial_params.dart';
import 'package:picnic_app/features/circles/discover_pods/discover_pods_navigator.dart';
import 'package:picnic_app/features/circles/discover_pods/discover_pods_presentation_model.dart';
import 'package:picnic_app/features/circles/discover_pods/discover_pods_presenter.dart';
import 'package:picnic_app/features/circles/domain/model/add_blacklisted_words_failure.dart';
import 'package:picnic_app/features/circles/domain/model/assign_user_role_failure.dart';
import 'package:picnic_app/features/circles/domain/model/ban_user_failure.dart';
import 'package:picnic_app/features/circles/domain/model/create_circle_role_failure.dart';
import 'package:picnic_app/features/circles/domain/model/delete_role_failure.dart';
import 'package:picnic_app/features/circles/domain/model/get_banned_users_failure.dart';
import 'package:picnic_app/features/circles/domain/model/get_blacklisted_words_failure.dart';
import 'package:picnic_app/features/circles/domain/model/get_circle_details_failure.dart';
import 'package:picnic_app/features/circles/domain/model/get_circle_members_failure.dart';
import 'package:picnic_app/features/circles/domain/model/get_circle_roles_failure.dart';
import 'package:picnic_app/features/circles/domain/model/get_circle_sorted_posts_failure.dart';
import 'package:picnic_app/features/circles/domain/model/get_default_circle_config_failure.dart';
import 'package:picnic_app/features/circles/domain/model/get_last_used_sorting_option_failure.dart';
import 'package:picnic_app/features/circles/domain/model/get_pods_failure.dart';
import 'package:picnic_app/features/circles/domain/model/get_reports_failure.dart';
import 'package:picnic_app/features/circles/domain/model/get_roles_for_user_failure.dart';
import 'package:picnic_app/features/circles/domain/model/get_royalty_failure.dart';
import 'package:picnic_app/features/circles/domain/model/invite_user_to_circle_failure.dart';
import 'package:picnic_app/features/circles/domain/model/remove_blacklisted_words_failure.dart';
import 'package:picnic_app/features/circles/domain/model/search_non_member_users_failure.dart';
import 'package:picnic_app/features/circles/domain/model/un_assign_user_role_failure.dart';
import 'package:picnic_app/features/circles/domain/model/unban_user_failure.dart';
import 'package:picnic_app/features/circles/domain/model/update_circle_member_role_failure.dart';
import 'package:picnic_app/features/circles/domain/model/update_circle_role_failure.dart';
import 'package:picnic_app/features/circles/domain/model/update_rules_failure.dart';
import 'package:picnic_app/features/circles/domain/repositories/circle_moderator_actions_repository.dart';
import 'package:picnic_app/features/circles/domain/repositories/circle_posts_repository.dart';
import 'package:picnic_app/features/circles/domain/repositories/circle_reports_repository.dart';
import 'package:picnic_app/features/circles/domain/use_cases/add_blacklisted_words_use_case.dart';
import 'package:picnic_app/features/circles/domain/use_cases/assign_user_role_use_case.dart';
import 'package:picnic_app/features/circles/domain/use_cases/ban_user_use_case.dart';
import 'package:picnic_app/features/circles/domain/use_cases/create_circle_role_use_case.dart';
import 'package:picnic_app/features/circles/domain/use_cases/delete_role_use_case.dart';
import 'package:picnic_app/features/circles/domain/use_cases/get_banned_users_use_case.dart';
import 'package:picnic_app/features/circles/domain/use_cases/get_blacklisted_words_use_case.dart';
import 'package:picnic_app/features/circles/domain/use_cases/get_circle_details_use_case.dart';
import 'package:picnic_app/features/circles/domain/use_cases/get_circle_members_by_role_use_case.dart';
import 'package:picnic_app/features/circles/domain/use_cases/get_circle_members_use_case.dart';
import 'package:picnic_app/features/circles/domain/use_cases/get_circle_roles_use_case.dart';
import 'package:picnic_app/features/circles/domain/use_cases/get_circle_sorted_posts_use_case.dart';
import 'package:picnic_app/features/circles/domain/use_cases/get_default_circle_config_use_case.dart';
import 'package:picnic_app/features/circles/domain/use_cases/get_last_used_sorting_option_use_case.dart';
import 'package:picnic_app/features/circles/domain/use_cases/get_pods_use_case.dart';
import 'package:picnic_app/features/circles/domain/use_cases/get_related_chat_messages_feed_use_case.dart';
import 'package:picnic_app/features/circles/domain/use_cases/get_related_messages_use_case.dart';
import 'package:picnic_app/features/circles/domain/use_cases/get_reports_use_case.dart';
import 'package:picnic_app/features/circles/domain/use_cases/get_royalty_use_case.dart';
import 'package:picnic_app/features/circles/domain/use_cases/get_user_roles_in_circle_use_case.dart';
import 'package:picnic_app/features/circles/domain/use_cases/invite_user_to_circle_use_case.dart';
import 'package:picnic_app/features/circles/domain/use_cases/remove_blacklisted_words_use_case.dart';
import 'package:picnic_app/features/circles/domain/use_cases/search_non_member_users_use_case.dart';
import 'package:picnic_app/features/circles/domain/use_cases/un_assign_user_role_use_case.dart';
import 'package:picnic_app/features/circles/domain/use_cases/unban_user_use_case.dart';
import 'package:picnic_app/features/circles/domain/use_cases/update_circle_role_use_case.dart';
import 'package:picnic_app/features/circles/domain/use_cases/update_rules_use_case.dart';
import "package:picnic_app/features/circles/edit_circle/edit_circle_initial_params.dart";
import "package:picnic_app/features/circles/edit_circle/edit_circle_navigator.dart";
import "package:picnic_app/features/circles/edit_circle/edit_circle_presentation_model.dart";
import "package:picnic_app/features/circles/edit_circle/edit_circle_presenter.dart";
import 'package:picnic_app/features/circles/edit_rules/edit_rules_initial_params.dart';
import 'package:picnic_app/features/circles/edit_rules/edit_rules_navigator.dart';
import 'package:picnic_app/features/circles/edit_rules/edit_rules_presentation_model.dart';
import 'package:picnic_app/features/circles/edit_rules/edit_rules_presenter.dart';
import 'package:picnic_app/features/circles/invite_user_list/invite_user_list_initial_params.dart';
import 'package:picnic_app/features/circles/invite_user_list/invite_user_list_navigator.dart';
import 'package:picnic_app/features/circles/invite_user_list/invite_user_list_presentation_model.dart';
import 'package:picnic_app/features/circles/invite_user_list/invite_user_list_presenter.dart';
import 'package:picnic_app/features/circles/members/members_navigator.dart';
import 'package:picnic_app/features/circles/pods/pod_web_view_initial_params.dart';
import 'package:picnic_app/features/circles/pods/pod_web_view_navigator.dart';
import 'package:picnic_app/features/circles/pods/pod_web_view_presentation_model.dart';
import 'package:picnic_app/features/circles/pods/pod_web_view_presenter.dart';
import 'package:picnic_app/features/circles/remove_reason/remove_reason_initial_params.dart';
import 'package:picnic_app/features/circles/remove_reason/remove_reason_navigator.dart';
import 'package:picnic_app/features/circles/remove_reason/remove_reason_presentation_model.dart';
import 'package:picnic_app/features/circles/remove_reason/remove_reason_presenter.dart';
import 'package:picnic_app/features/circles/reported_content/reported_content_initial_params.dart';
import 'package:picnic_app/features/circles/reported_content/reported_content_navigator.dart';
import 'package:picnic_app/features/circles/reported_content/reported_content_presentation_model.dart';
import 'package:picnic_app/features/circles/reported_content/reported_content_presenter.dart';
import 'package:picnic_app/features/circles/reported_message/reported_message_initial_params.dart';
import 'package:picnic_app/features/circles/reported_message/reported_message_navigator.dart';
import 'package:picnic_app/features/circles/reported_message/reported_message_presentation_model.dart';
import 'package:picnic_app/features/circles/reported_message/reported_message_presenter.dart';
import 'package:picnic_app/features/circles/reports_list/reports_list_initial_params.dart';
import 'package:picnic_app/features/circles/reports_list/reports_list_navigator.dart';
import 'package:picnic_app/features/circles/reports_list/reports_list_presentation_model.dart';
import 'package:picnic_app/features/circles/reports_list/reports_list_presenter.dart';
import 'package:picnic_app/features/circles/resolve_report_with_no_action/resolve_report_with_no_action_initial_params.dart';
import 'package:picnic_app/features/circles/resolve_report_with_no_action/resolve_report_with_no_action_navigator.dart';
import 'package:picnic_app/features/circles/resolve_report_with_no_action/resolve_report_with_no_action_presentation_model.dart';
import 'package:picnic_app/features/circles/resolve_report_with_no_action/resolve_report_with_no_action_presenter.dart';
import 'package:picnic_app/features/circles/roles_list/roles_list_initial_params.dart';
import 'package:picnic_app/features/circles/roles_list/roles_list_navigator.dart';
import 'package:picnic_app/features/circles/roles_list/roles_list_presentation_model.dart';
import 'package:picnic_app/features/circles/user_roles/user_roles_initial_params.dart';
import 'package:picnic_app/features/circles/user_roles/user_roles_navigator.dart';
import 'package:picnic_app/features/circles/user_roles/user_roles_presentation_model.dart';
import 'package:picnic_app/features/circles/user_roles/user_roles_presenter.dart';
import 'package:picnic_app/features/create_circle/rule_selection/rule_selection_initial_params.dart';
import 'package:picnic_app/features/create_circle/rule_selection/rule_selection_navigator.dart';
import 'package:picnic_app/features/create_circle/rule_selection/rule_selection_presentation_model.dart';
import 'package:picnic_app/features/create_circle/rule_selection/rule_selection_presenter.dart';
import 'package:picnic_app/features/slices/slice_details/slice_details_navigator.dart';
import 'package:picnic_app/features/slices/slice_settings/slice_settings_navigator.dart';

//DO-NOT-REMOVE IMPORTS_MOCK_DEFINITIONS

// MVP

class MockCircleCreationRuleSelectionPresenter extends MockCubit<RuleSelectionViewModel>
    implements RuleSelectionPresenter {}

class MockCircleCreationRuleSelectionPresentationModel extends Mock implements RuleSelectionPresentationModel {}

class MockCircleCreationRuleSelectionInitialParams extends Mock implements RuleSelectionInitialParams {}

class MockCircleCreationRuleSelectionNavigator extends Mock implements RuleSelectionNavigator {}

class MockCircleSettingsPresenter extends MockCubit<CircleSettingsViewModel> implements CircleSettingsPresenter {}

class MockCircleSettingsPresentationModel extends Mock implements CircleSettingsPresentationModel {}

class MockCircleSettingsInitialParams extends Mock implements CircleSettingsInitialParams {}

class MockCircleSettingsNavigator extends Mock implements CircleSettingsNavigator {}

class MockRemoveReasonPresenter extends MockCubit<RemoveReasonViewModel> implements RemoveReasonPresenter {}

class MockRemoveReasonPresentationModel extends Mock implements RemoveReasonPresentationModel {}

class MockRemoveReasonInitialParams extends Mock implements RemoveReasonInitialParams {}

class MockRemoveReasonNavigator extends Mock implements RemoveReasonNavigator {}

class MockReportedPostPresenter extends MockCubit<ReportedContentViewModel> implements ReportedContentPresenter {}

class MockReportedPostPresentationModel extends Mock implements ReportedContentPresentationModel {}

class MockReportedPostInitialParams extends Mock implements ReportedContentInitialParams {}

class MockReportedContentNavigator extends Mock implements ReportedContentNavigator {}

class MockSliceDetailsNavigator extends Mock implements SliceDetailsNavigator {}

class MockSliceSettingsNavigator extends Mock implements SliceSettingsNavigator {}

class MockReportedMessagePresenter extends MockCubit<ReportedMessageViewModel> implements ReportedMessagePresenter {}

class MockReportedMessagePresentationModel extends Mock implements ReportedMessagePresentationModel {}

class MockReportedMessageInitialParams extends Mock implements ReportedMessageInitialParams {}

class MockReportedMessageNavigator extends Mock implements ReportedMessageNavigator {}

class MockBanUserListPresenter extends MockCubit<BanUserListViewModel> implements BanUserListPresenter {}

class MockBanUserListPresentationModel extends Mock implements BanUserListPresentationModel {}

class MockBanUserListInitialParams extends Mock implements BanUserListInitialParams {}

class MockBanUserListNavigator extends Mock implements BanUserListNavigator {}

class MockInviteUserListPresenter extends MockCubit<InviteUserListViewModel> implements InviteUserListPresenter {}

class MockInviteUserListPresentationModel extends Mock implements InviteUserListPresentationModel {}

class MockInviteUserListInitialParams extends Mock implements InviteUserListInitialParams {}

class MockInviteUserListNavigator extends Mock implements InviteUserListNavigator {}

class MockCircleMemberSettingsPresenter extends MockCubit<CircleMemberSettingsViewModel>
    implements CircleMemberSettingsPresenter {}

class MockCircleMemberSettingsPresentationModel extends Mock implements CircleMemberSettingsPresentationModel {}

class MockCircleMemberSettingsInitialParams extends Mock implements CircleMemberSettingsInitialParams {}

class MockCircleMemberSettingsNavigator extends Mock implements CircleMemberSettingsNavigator {}

class MockBanUserPresenter extends MockCubit<BanUserViewModel> implements BanUserPresenter {}

class MockBanUserPresentationModel extends Mock implements BanUserPresentationModel {}

class MockBanUserInitialParams extends Mock implements BanUserInitialParams {}

class MockBanUserNavigator extends Mock implements BanUserNavigator {}

class MockCircleGroupsSelectionPresenter extends MockCubit<CircleGroupsSelectionViewModel>
    implements CircleGroupsSelectionPresenter {}

class MockCircleGroupsSelectionPresentationModel extends Mock implements CircleGroupsSelectionPresentationModel {}

class MockCircleGroupsSelectionInitialParams extends Mock implements CircleGroupsSelectionInitialParams {}

class MockCircleGroupsSelectionNavigator extends Mock implements CircleGroupsSelectionNavigator {}

class MockCircleDetailsPresenter extends MockCubit<CircleDetailsViewModel> implements CircleDetailsPresenter {}

class MockCircleDetailsPresentationModel extends Mock implements CircleDetailsPresentationModel {}

class MockCircleDetailsInitialParams extends Mock implements CircleDetailsInitialParams {}

class MockCircleDetailsNavigator extends Mock implements CircleDetailsNavigator {}

class MockEditRulesPresenter extends MockCubit<EditRulesViewModel> implements EditRulesPresenter {}

class MockEditRulesPresentationModel extends Mock implements EditRulesPresentationModel {}

class MockEditRulesInitialParams extends Mock implements EditRulesInitialParams {}

class MockEditRulesNavigator extends Mock implements EditRulesNavigator {}

class MockBlacklistedWordsPresenter extends MockCubit<BlacklistedWordsViewModel> implements BlacklistedWordsPresenter {}

class MockBlacklistedWordsPresentationModel extends Mock implements BlacklistedWordsPresentationModel {}

class MockBlacklistedWordsInitialParams extends Mock implements BlacklistedWordsInitialParams {}

class MockBlacklistedWordsNavigator extends Mock implements BlacklistedWordsNavigator {}

class MockAddBlackListWordPresenter extends MockCubit<AddBlackListWordViewModel> implements AddBlackListWordPresenter {}

class MockAddBlackListWordPresentationModel extends Mock implements AddBlackListWordPresentationModel {}

class MockAddBlackListWordInitialParams extends Mock implements AddBlackListWordInitialParams {}

class MockAddBlackListWordNavigator extends Mock implements AddBlackListWordNavigator {}

class MockGetRelatedMessagesUseCase extends Mock implements GetRelatedMessagesUseCase {}

class MockGetRelatedChatMessagesFeedUseCase extends Mock implements GetRelatedChatMessagesFeedUseCase {}

class MockEditCirclePresenter extends MockCubit<EditCircleViewModel> implements EditCirclePresenter {}

class MockEditCirclePresentationModel extends Mock implements EditCirclePresentationModel {}

class MockEditCircleInitialParams extends Mock implements EditCircleInitialParams {}

class MockEditCircleNavigator extends Mock implements EditCircleNavigator {}

class MockReportsListPresenter extends MockCubit<ReportsListViewModel> implements ReportsListPresenter {}

class MockReportsListPresentationModel extends Mock implements ReportsListPresentationModel {}

class MockReportsListInitialParams extends Mock implements ReportsListInitialParams {}

class MockReportsListNavigator extends Mock implements ReportsListNavigator {}

class MockBannedUsersPresenter extends MockCubit<BannedUsersViewModel> implements BannedUsersPresenter {}

class MockBannedUsersPresentationModel extends Mock implements BannedUsersPresentationModel {}

class MockBannedUsersInitialParams extends Mock implements BannedUsersInitialParams {}

class MockBannedUsersNavigator extends Mock implements BannedUsersNavigator {}

class MockMembersNavigator extends Mock implements MembersNavigator {}

class MockResolveReportWithNoActionPresenter extends MockCubit<ResolveReportWithNoActionViewModel>
    implements ResolveReportWithNoActionPresenter {}

class MockResolveReportWithNoActionPresentationModel extends Mock
    implements ResolveReportWithNoActionPresentationModel {}

class MockResolveReportWithNoActionInitialParams extends Mock implements ResolveReportWithNoActionInitialParams {}

class MockResolveReportWithNoActionNavigator extends Mock implements ResolveReportWithNoActionNavigator {}

class MockRolesListPresenter extends MockCubit<EditCircleViewModel> implements EditCirclePresenter {}

class MockRolesListPresentationModel extends Mock implements RolesListPresentationModel {}

class MockRolesListInitialParams extends Mock implements RolesListInitialParams {}

class MockRolesListNavigator extends Mock implements RolesListNavigator {}

class MockCircleRolePresenter extends MockCubit<CircleRoleViewModel> implements CircleRolePresenter {}

class MockCircleRolePresentationModel extends Mock implements CircleRolePresentationModel {}

class MockCircleRoleInitialParams extends Mock implements CircleRoleInitialParams {}

class MockCircleRoleNavigator extends Mock implements CircleRoleNavigator {}

class MockUserRolesPresenter extends MockCubit<UserRolesViewModel> implements UserRolesPresenter {}

class MockUserRolesPresentationModel extends Mock implements UserRolesPresentationModel {}

class MockUserRolesInitialParams extends Mock implements UserRolesInitialParams {}

class MockUserRolesNavigator extends Mock implements UserRolesNavigator {}

class MockCircleConfigPresenter extends MockCubit<CircleConfigViewModel> implements CircleConfigPresenter {}

class MockCircleConfigPresentationModel extends Mock implements CircleConfigPresentationModel {}

class MockCircleConfigInitialParams extends Mock implements CircleConfigInitialParams {}

class MockCircleConfigNavigator extends Mock implements CircleConfigNavigator {}

class MockDiscoverPodsPresenter extends MockCubit<DiscoverPodsViewModel> implements DiscoverPodsPresenter {}

class MockDiscoverPodsPresentationModel extends Mock implements DiscoverPodsPresentationModel {}

class MockDiscoverPodsInitialParams extends Mock implements DiscoverPodsInitialParams {}

class MockDiscoverPodsNavigator extends Mock implements DiscoverPodsNavigator {}

class MockPodWebViewPresenter extends MockCubit<PodWebViewViewModel> implements PodWebViewPresenter {}

class MockPodWebViewPresentationModel extends Mock implements PodWebViewPresentationModel {}

class MockPodWebViewInitialParams extends Mock implements PodWebViewInitialParams {}

class MockPodWebViewNavigator extends Mock implements PodWebViewNavigator {}

class MockAddCirclePodPresenter extends MockCubit<AddCirclePodViewModel> implements AddCirclePodPresenter {}

class MockAddCirclePodPresentationModel extends Mock implements AddCirclePodPresentationModel {}

class MockAddCirclePodInitialParams extends Mock implements AddCirclePodInitialParams {}

class MockAddCirclePodNavigator extends Mock implements AddCirclePodNavigator {}

//DO-NOT-REMOVE MVP_MOCK_DEFINITION

// USE CASES
class MockGetRoyaltyFailure extends Mock implements GetRoyaltyFailure {}

class MockGetRoyaltyUseCase extends Mock implements GetRoyaltyUseCase {}

class MockEditRulesFailure extends Mock implements UpdateRulesFailure {}

class MockEditRulesUseCase extends Mock implements UpdateRulesUseCase {}

class MockGetCircleDetailsFailure extends Mock implements GetCircleDetailsFailure {}

class MockGetCircleDetailsUseCase extends Mock implements GetCircleDetailsUseCase {}

class MockGetCircleMembersByRoleUseCase extends Mock implements GetCircleMembersByRoleUseCase {}

class MockGetBannedUsersFailure extends Mock implements GetBannedUsersFailure {}

class MockGetBannedUsersUseCase extends Mock implements GetBannedUsersUseCase {}

class MockGetCircleMembersFailure extends Mock implements GetCircleMembersFailure {}

class MockGetCircleMembersUseCase extends Mock implements GetCircleMembersUseCase {}

class MockBanUserUseCase extends Mock implements BanUserUseCase {}

class MockUnbanUserUseCase extends Mock implements UnbanUserUseCase {}

class MockBanUserFailure extends Mock implements BanUserFailure {}

class MockUnbanUserFailure extends Mock implements UnbanUserFailure {}

class MockInviteUserToCircleFailure extends Mock implements InviteUserToCircleFailure {}

class MockInviteUserToCircleUseCase extends Mock implements InviteUserToCircleUseCase {}

class MockGetReportsFailure extends Mock implements GetReportsFailure {}

class MockGetReportsUseCase extends Mock implements GetReportsUseCase {}

class MockJoinCircleUseCase extends Mock implements JoinCircleUseCase {}

class MockJoinCirclesUseCase extends Mock implements JoinCirclesUseCase {}

class MockUpdateCircleMemberRoleFailure extends Mock implements UpdateCircleMemberRoleFailure {}

class MockSearchNonMemberUsersFailure extends Mock implements SearchNonMemberUsersFailure {}

class MockSearchNonMemberUsersUseCase extends Mock implements SearchNonMemberUsersUseCase {}

class MockGetBlacklistedWordsFailure extends Mock implements GetBlacklistedWordsFailure {}

class MockGetBlacklistedWordsUseCase extends Mock implements GetBlacklistedWordsUseCase {}

class MockAddBlacklistedWordsFailure extends Mock implements AddBlacklistedWordsFailure {}

class MockAddBlacklistedWordsUseCase extends Mock implements AddBlacklistedWordsUseCase {}

class MockRemoveBlacklistedWordsFailure extends Mock implements RemoveBlacklistedWordsFailure {}

class MockRemoveBlacklistedWordsUseCase extends Mock implements RemoveBlacklistedWordsUseCase {}

class MockGetCircleSortedPostsFailure extends Mock implements GetCircleSortedPostsFailure {}

class MockGetCircleSortedPostsUseCase extends Mock implements GetCircleSortedPostsUseCase {}

class MockCreateCircleRoleFailure extends Mock implements CreateCircleRoleFailure {}

class MockCreateCircleRoleUseCase extends Mock implements CreateCircleRoleUseCase {}

class MockGetCircleRoleFailure extends Mock implements GetCircleRolesFailure {}

class MockGetCircleRolesUseCase extends Mock implements GetCircleRolesUseCase {}

class MockUpdateCircleRoleFailure extends Mock implements UpdateCircleRoleFailure {}

class MockUpdateCircleRoleUseCase extends Mock implements UpdateCircleRoleUseCase {}

class MockDeleteRoleFailure extends Mock implements DeleteRoleFailure {}

class MockDeleteRoleUseCase extends Mock implements DeleteRoleUseCase {}

class MockAssignUserRoleFailure extends Mock implements AssignUserRoleFailure {}

class MockAssignUserRoleUseCase extends Mock implements AssignUserRoleUseCase {}

class MockUnAssignUserRoleFailure extends Mock implements UnAssignUserRoleFailure {}

class MockUnAssignUserRoleUseCase extends Mock implements UnAssignUserRoleUseCase {}

class MockGetRolesForUserFailure extends Mock implements GetRolesForUserFailure {}

class MockGetUserRolesInCircleUseCase extends Mock implements GetUserRolesInCircleUseCase {}

class MockGetLastUsedSortingOptionFailure extends Mock implements GetLastUsedSortingOptionFailure {}

class MockGetLastUsedSortingOptionUseCase extends Mock implements GetLastUsedSortingOptionUseCase {}

class MockGetDefaultCircleConfigFailure extends Mock implements GetDefaultCircleConfigFailure {}

class MockGetDefaultCircleConfigUseCase extends Mock implements GetDefaultCircleConfigUseCase {}

class MockGetPodsFailure extends Mock implements GetPodsFailure {}

class MockGetPodsUseCase extends Mock implements GetPodsUseCase {}

//DO-NOT-REMOVE USE_CASE_MOCK_DEFINITION

// REPOSITORIES
class MockCirclePostsRepository extends Mock implements CirclePostsRepository {}

class MockCircleModeratorActionsRepository extends Mock implements CircleModeratorActionsRepository {}

class MockCircleReportsRepository extends Mock implements CircleReportsRepository {}

//DO-NOT-REMOVE REPOSITORIES_MOCK_DEFINITION

// STORES
//DO-NOT-REMOVE STORES_MOCK_DEFINITION
