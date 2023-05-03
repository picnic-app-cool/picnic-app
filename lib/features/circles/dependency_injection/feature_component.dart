import 'package:picnic_app/dependency_injection/app_component.dart';
import "package:picnic_app/features/circles/add_word_blacklist/add_black_list_word_initial_params.dart";
import "package:picnic_app/features/circles/add_word_blacklist/add_black_list_word_navigator.dart";
import "package:picnic_app/features/circles/add_word_blacklist/add_black_list_word_page.dart";
import "package:picnic_app/features/circles/add_word_blacklist/add_black_list_word_presentation_model.dart";
import "package:picnic_app/features/circles/add_word_blacklist/add_black_list_word_presenter.dart";
import 'package:picnic_app/features/circles/ban_user/ban_user_initial_params.dart';
import 'package:picnic_app/features/circles/ban_user/ban_user_navigator.dart';
import 'package:picnic_app/features/circles/ban_user/ban_user_page.dart';
import 'package:picnic_app/features/circles/ban_user/ban_user_presentation_model.dart';
import 'package:picnic_app/features/circles/ban_user/ban_user_presenter.dart';
import 'package:picnic_app/features/circles/ban_user_list/ban_user_list_initial_params.dart';
import 'package:picnic_app/features/circles/ban_user_list/ban_user_list_navigator.dart';
import 'package:picnic_app/features/circles/ban_user_list/ban_user_list_page.dart';
import 'package:picnic_app/features/circles/ban_user_list/ban_user_list_presentation_model.dart';
import 'package:picnic_app/features/circles/ban_user_list/ban_user_list_presenter.dart';
import 'package:picnic_app/features/circles/banned_users/banned_users_initial_params.dart';
import 'package:picnic_app/features/circles/banned_users/banned_users_navigator.dart';
import 'package:picnic_app/features/circles/banned_users/banned_users_page.dart';
import 'package:picnic_app/features/circles/banned_users/banned_users_presentation_model.dart';
import 'package:picnic_app/features/circles/banned_users/banned_users_presenter.dart';
import "package:picnic_app/features/circles/blacklisted_words/blacklisted_words_initial_params.dart";
import "package:picnic_app/features/circles/blacklisted_words/blacklisted_words_navigator.dart";
import "package:picnic_app/features/circles/blacklisted_words/blacklisted_words_page.dart";
import "package:picnic_app/features/circles/blacklisted_words/blacklisted_words_presentation_model.dart";
import "package:picnic_app/features/circles/blacklisted_words/blacklisted_words_presenter.dart";
import 'package:picnic_app/features/circles/circle_config/circle_config_initial_params.dart';
import 'package:picnic_app/features/circles/circle_config/circle_config_navigator.dart';
import 'package:picnic_app/features/circles/circle_config/circle_config_page.dart';
import 'package:picnic_app/features/circles/circle_config/circle_config_presentation_model.dart';
import 'package:picnic_app/features/circles/circle_config/circle_config_presenter.dart';
import 'package:picnic_app/features/circles/circle_details/circle_details_initial_params.dart';
import 'package:picnic_app/features/circles/circle_details/circle_details_navigator.dart';
import 'package:picnic_app/features/circles/circle_details/circle_details_page.dart';
import 'package:picnic_app/features/circles/circle_details/circle_details_presentation_model.dart';
import 'package:picnic_app/features/circles/circle_details/circle_details_presenter.dart';
import 'package:picnic_app/features/circles/circle_groups_selection/circle_groups_selection_initial_params.dart';
import 'package:picnic_app/features/circles/circle_groups_selection/circle_groups_selection_navigator.dart';
import 'package:picnic_app/features/circles/circle_groups_selection/circle_groups_selection_page.dart';
import 'package:picnic_app/features/circles/circle_groups_selection/circle_groups_selection_presentation_model.dart';
import 'package:picnic_app/features/circles/circle_groups_selection/circle_groups_selection_presenter.dart';
import 'package:picnic_app/features/circles/circle_member_settings/circle_member_settings_initial_params.dart';
import 'package:picnic_app/features/circles/circle_member_settings/circle_member_settings_navigator.dart';
import 'package:picnic_app/features/circles/circle_member_settings/circle_member_settings_page.dart';
import 'package:picnic_app/features/circles/circle_member_settings/circle_member_settings_presentation_model.dart';
import 'package:picnic_app/features/circles/circle_member_settings/circle_member_settings_presenter.dart';
import 'package:picnic_app/features/circles/circle_role/circle_role_initial_params.dart';
import 'package:picnic_app/features/circles/circle_role/circle_role_navigator.dart';
import 'package:picnic_app/features/circles/circle_role/circle_role_page.dart';
import 'package:picnic_app/features/circles/circle_role/circle_role_presentation_model.dart';
import 'package:picnic_app/features/circles/circle_role/circle_role_presenter.dart';
import 'package:picnic_app/features/circles/circle_settings/circle_settings_initial_params.dart';
import 'package:picnic_app/features/circles/circle_settings/circle_settings_navigator.dart';
import 'package:picnic_app/features/circles/circle_settings/circle_settings_page.dart';
import 'package:picnic_app/features/circles/circle_settings/circle_settings_presentation_model.dart';
import 'package:picnic_app/features/circles/circle_settings/circle_settings_presenter.dart';
import 'package:picnic_app/features/circles/data/graph_ql_circle_reports_repository.dart';
import 'package:picnic_app/features/circles/data/graphql_circle_moderator_actions_repository.dart';
import 'package:picnic_app/features/circles/data/graphql_circle_posts_repository.dart';
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
import 'package:picnic_app/features/circles/domain/use_cases/get_related_chat_messages_feed_use_case.dart';
import 'package:picnic_app/features/circles/domain/use_cases/get_related_messages_use_case.dart';
import 'package:picnic_app/features/circles/domain/use_cases/get_reports_use_case.dart';
import 'package:picnic_app/features/circles/domain/use_cases/get_royalty_use_case.dart';
import 'package:picnic_app/features/circles/domain/use_cases/get_user_roles_in_circle_use_case.dart';
import 'package:picnic_app/features/circles/domain/use_cases/invite_user_to_circle_use_case.dart';
import 'package:picnic_app/features/circles/domain/use_cases/remove_blacklisted_words_use_case.dart';
import 'package:picnic_app/features/circles/domain/use_cases/resolve_report_use_case.dart';
import 'package:picnic_app/features/circles/domain/use_cases/search_non_member_users_use_case.dart';
import 'package:picnic_app/features/circles/domain/use_cases/un_assign_user_role_use_case.dart';
import 'package:picnic_app/features/circles/domain/use_cases/unban_user_use_case.dart';
import 'package:picnic_app/features/circles/domain/use_cases/update_circle_role_use_case.dart';
import 'package:picnic_app/features/circles/domain/use_cases/update_rules_use_case.dart';
import "package:picnic_app/features/circles/edit_circle/edit_circle_initial_params.dart";
import "package:picnic_app/features/circles/edit_circle/edit_circle_navigator.dart";
import "package:picnic_app/features/circles/edit_circle/edit_circle_page.dart";
import "package:picnic_app/features/circles/edit_circle/edit_circle_presentation_model.dart";
import "package:picnic_app/features/circles/edit_circle/edit_circle_presenter.dart";
import 'package:picnic_app/features/circles/edit_rules/edit_rules_initial_params.dart';
import 'package:picnic_app/features/circles/edit_rules/edit_rules_navigator.dart';
import 'package:picnic_app/features/circles/edit_rules/edit_rules_page.dart';
import 'package:picnic_app/features/circles/edit_rules/edit_rules_presentation_model.dart';
import 'package:picnic_app/features/circles/edit_rules/edit_rules_presenter.dart';
import 'package:picnic_app/features/circles/invite_user_list/invite_user_list_initial_params.dart';
import 'package:picnic_app/features/circles/invite_user_list/invite_user_list_navigator.dart';
import 'package:picnic_app/features/circles/invite_user_list/invite_user_list_page.dart';
import 'package:picnic_app/features/circles/invite_user_list/invite_user_list_presentation_model.dart';
import 'package:picnic_app/features/circles/invite_user_list/invite_user_list_presenter.dart';
import 'package:picnic_app/features/circles/members/members_initial_params.dart';
import 'package:picnic_app/features/circles/members/members_navigator.dart';
import 'package:picnic_app/features/circles/members/members_page.dart';
import 'package:picnic_app/features/circles/members/members_presentation_model.dart';
import 'package:picnic_app/features/circles/members/members_presenter.dart';
import 'package:picnic_app/features/circles/remove_reason/remove_reason_initial_params.dart';
import 'package:picnic_app/features/circles/remove_reason/remove_reason_navigator.dart';
import 'package:picnic_app/features/circles/remove_reason/remove_reason_page.dart';
import 'package:picnic_app/features/circles/remove_reason/remove_reason_presentation_model.dart';
import 'package:picnic_app/features/circles/remove_reason/remove_reason_presenter.dart';
import 'package:picnic_app/features/circles/reported_content/reported_content_initial_params.dart';
import 'package:picnic_app/features/circles/reported_content/reported_content_navigator.dart';
import 'package:picnic_app/features/circles/reported_content/reported_content_page.dart';
import 'package:picnic_app/features/circles/reported_content/reported_content_presentation_model.dart';
import 'package:picnic_app/features/circles/reported_content/reported_content_presenter.dart';
import 'package:picnic_app/features/circles/reported_message/reported_message_initial_params.dart';
import 'package:picnic_app/features/circles/reported_message/reported_message_navigator.dart';
import 'package:picnic_app/features/circles/reported_message/reported_message_page.dart';
import 'package:picnic_app/features/circles/reported_message/reported_message_presentation_model.dart';
import 'package:picnic_app/features/circles/reported_message/reported_message_presenter.dart';
import 'package:picnic_app/features/circles/reports_list/reports_list_initial_params.dart';
import 'package:picnic_app/features/circles/reports_list/reports_list_navigator.dart';
import 'package:picnic_app/features/circles/reports_list/reports_list_page.dart';
import 'package:picnic_app/features/circles/reports_list/reports_list_presentation_model.dart';
import 'package:picnic_app/features/circles/reports_list/reports_list_presenter.dart';
import 'package:picnic_app/features/circles/resolve_report_with_no_action/resolve_report_with_no_action_initial_params.dart';
import 'package:picnic_app/features/circles/resolve_report_with_no_action/resolve_report_with_no_action_navigator.dart';
import 'package:picnic_app/features/circles/resolve_report_with_no_action/resolve_report_with_no_action_page.dart';
import 'package:picnic_app/features/circles/resolve_report_with_no_action/resolve_report_with_no_action_presentation_model.dart';
import 'package:picnic_app/features/circles/resolve_report_with_no_action/resolve_report_with_no_action_presenter.dart';
import 'package:picnic_app/features/circles/roles_list/roles_list_initial_params.dart';
import 'package:picnic_app/features/circles/roles_list/roles_list_navigator.dart';
import 'package:picnic_app/features/circles/roles_list/roles_list_page.dart';
import 'package:picnic_app/features/circles/roles_list/roles_list_presentation_model.dart';
import 'package:picnic_app/features/circles/roles_list/roles_list_presenter.dart';
import 'package:picnic_app/features/circles/user_roles/user_roles_initial_params.dart';
import 'package:picnic_app/features/circles/user_roles/user_roles_navigator.dart';
import 'package:picnic_app/features/circles/user_roles/user_roles_page.dart';
import 'package:picnic_app/features/circles/user_roles/user_roles_presentation_model.dart';
import 'package:picnic_app/features/circles/user_roles/user_roles_presenter.dart';
import 'package:picnic_app/features/reports/report_details/resolved_report_details_initial_params.dart';
import 'package:picnic_app/features/reports/report_details/resolved_report_details_navigator.dart';
import 'package:picnic_app/features/reports/report_details/resolved_report_details_page.dart';
import 'package:picnic_app/features/reports/report_details/resolved_report_details_presentation_model.dart';
import 'package:picnic_app/features/reports/report_details/resolved_report_details_presenter.dart';
//DO-NOT-REMOVE APP_COMPONENT_IMPORTS

/// registers all the dependencies in dependency graph in get_it package
void configureDependencies() {
  _configureGeneralDependencies();
  _configureRepositories();
  _configureStores();
  _configureUseCases();
  _configureMvp();
}

//ignore: long-method
void _configureGeneralDependencies() {
  // ignore: unnecessary_statements
  getIt
      //DO-NOT-REMOVE GENERAL_DEPS_GET_IT_CONFIG
      ;
}

//ignore: long-method
void _configureRepositories() {
  // ignore: unnecessary_statements
  getIt
        ..registerFactory<CirclePostsRepository>(
          () => GraphqlCirclePostsRepository(
            getIt(),
            getIt(),
          ),
        )
        ..registerFactory<CircleModeratorActionsRepository>(
          () => GraphqlCircleModeratorActionsRepository(gqlClient: getIt()),
        )
        ..registerFactory<CircleReportsRepository>(
          () => GraphqlCircleReportsRepository(
            getIt(),
            getIt(),
          ),
        )

//DO-NOT-REMOVE REPOSITORIES_GET_IT_CONFIG
      ;
}

//ignore: long-method
void _configureStores() {
  // ignore: unnecessary_statements
  getIt
      //DO-NOT-REMOVE STORES_GET_IT_CONFIG
      ;
}

//ignore: long-method
void _configureUseCases() {
  // ignore: unnecessary_statements
  getIt
        ..registerFactory<GetRoyaltyUseCase>(
          () => const GetRoyaltyUseCase(),
        )
        ..registerFactory<UpdateRulesUseCase>(
          () => UpdateRulesUseCase(getIt()),
        )
        ..registerFactory<GetCircleDetailsUseCase>(
          () => GetCircleDetailsUseCase(
            getIt(),
          ),
        )
        ..registerFactory<GetCircleMembersByRoleUseCase>(
          () => GetCircleMembersByRoleUseCase(
            getIt(),
          ),
        )
        ..registerFactory<GetRelatedMessagesUseCase>(
          () => GetRelatedMessagesUseCase(
            getIt(),
          ),
        )
        ..registerFactory<GetRelatedChatMessagesFeedUseCase>(
          () => GetRelatedChatMessagesFeedUseCase(
            getIt(),
            getIt(),
          ),
        )
        ..registerFactory<UnbanUserUseCase>(
          () => UnbanUserUseCase(getIt()),
        )
        ..registerFactory<BanUserUseCase>(
          () => BanUserUseCase(getIt()),
        )
        ..registerFactory<GetBannedUsersUseCase>(
          () => GetBannedUsersUseCase(getIt()),
        )
        ..registerFactory<GetCircleMembersUseCase>(
          () => GetCircleMembersUseCase(getIt(), getIt()),
        )
        ..registerFactory<GetReportsUseCase>(
          () => GetReportsUseCase(getIt()),
        )
        ..registerFactory<ResolveReportUseCase>(
          () => ResolveReportUseCase(getIt()),
        )
        ..registerFactory<InviteUserToCircleUseCase>(
          () => InviteUserToCircleUseCase(getIt()),
        )
        ..registerFactory<SearchNonMemberUsersUseCase>(
          () => SearchNonMemberUsersUseCase(getIt()),
        )
        ..registerFactory<GetBlacklistedWordsUseCase>(
          () => GetBlacklistedWordsUseCase(getIt()),
        )
        ..registerFactory<AddBlacklistedWordsUseCase>(
          () => AddBlacklistedWordsUseCase(getIt()),
        )
        ..registerFactory<RemoveBlacklistedWordsUseCase>(
          () => RemoveBlacklistedWordsUseCase(getIt()),
        )
        ..registerFactory<GetCircleSortedPostsUseCase>(
          () => GetCircleSortedPostsUseCase(getIt()),
        )
        ..registerFactory<CreateCircleRoleUseCase>(
          () => CreateCircleRoleUseCase(
            getIt(),
          ),
        )
        ..registerFactory<GetCircleRolesUseCase>(
          () => GetCircleRolesUseCase(
            getIt(),
          ),
        )
        ..registerFactory<UpdateCircleRoleUseCase>(
          () => UpdateCircleRoleUseCase(
            getIt(),
          ),
        )
        ..registerFactory<DeleteRoleUseCase>(
          () => DeleteRoleUseCase(
            getIt(),
          ),
        )
        ..registerFactory<AssignUserRoleUseCase>(
          () => AssignUserRoleUseCase(getIt()),
        )
        ..registerFactory<UnAssignUserRoleUseCase>(
          () => UnAssignUserRoleUseCase(getIt()),
        )
        ..registerFactory<GetUserRolesInCircleUseCase>(
          () => GetUserRolesInCircleUseCase(getIt()),
        )
        ..registerFactory<GetLastUsedSortingOptionUseCase>(
          () => GetLastUsedSortingOptionUseCase(getIt()),
        )
        ..registerFactory<GetDefaultCircleConfigUseCase>(
          () => GetDefaultCircleConfigUseCase(getIt()),
        )

//DO-NOT-REMOVE USE_CASES_GET_IT_CONFIG
      ;
}

//ignore: long-method
void _configureMvp() {
  // ignore: unnecessary_statements
  getIt
        ..registerFactory<CircleSettingsNavigator>(
          () => CircleSettingsNavigator(getIt(), getIt()),
        )
        ..registerFactoryParam<CircleSettingsPresentationModel, CircleSettingsInitialParams, dynamic>(
          (params, _) => CircleSettingsPresentationModel.initial(
            params,
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<CircleSettingsPresenter, CircleSettingsInitialParams, dynamic>(
          (initialParams, _) => CircleSettingsPresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<CircleSettingsPage, CircleSettingsInitialParams, dynamic>(
          (initialParams, _) => CircleSettingsPage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<RemoveReasonNavigator>(
          () => RemoveReasonNavigator(getIt()),
        )
        ..registerFactoryParam<RemoveReasonPresentationModel, RemoveReasonInitialParams, dynamic>(
          (params, _) => RemoveReasonPresentationModel.initial(params),
        )
        ..registerFactoryParam<RemoveReasonPresenter, RemoveReasonInitialParams, dynamic>(
          (initialParams, _) => RemoveReasonPresenter(
            getIt(param1: initialParams),
            getIt(),
          ),
        )
        ..registerFactoryParam<RemoveReasonPage, RemoveReasonInitialParams, dynamic>(
          (initialParams, _) => RemoveReasonPage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<ReportedMessageNavigator>(
          () => ReportedMessageNavigator(getIt()),
        )
        ..registerFactoryParam<ReportedMessagePresentationModel, ReportedMessageInitialParams, dynamic>(
          (params, _) => ReportedMessagePresentationModel.initial(params),
        )
        ..registerFactoryParam<ReportedMessagePresenter, ReportedMessageInitialParams, dynamic>(
          (initialParams, _) => ReportedMessagePresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<ReportedMessagePage, ReportedMessageInitialParams, dynamic>(
          (initialParams, _) => ReportedMessagePage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<ReportedContentNavigator>(
          () => ReportedContentNavigator(getIt()),
        )
        ..registerFactoryParam<ReportedContentPresentationModel, ReportedContentInitialParams, dynamic>(
          (params, _) => ReportedContentPresentationModel.initial(params),
        )
        ..registerFactoryParam<ReportedContentPresenter, ReportedContentInitialParams, dynamic>(
          (initialParams, _) => ReportedContentPresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<ReportedContentPage, ReportedContentInitialParams, dynamic>(
          (initialParams, _) => ReportedContentPage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<BanUserListNavigator>(
          () => BanUserListNavigator(getIt(), getIt()),
        )
        ..registerFactoryParam<BanUserListPresentationModel, BanUserListInitialParams, dynamic>(
          (params, _) => BanUserListPresentationModel.initial(
            params,
          ),
        )
        ..registerFactoryParam<BanUserListPresenter, BanUserListInitialParams, dynamic>(
          (initialParams, _) => BanUserListPresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<BanUserListPage, BanUserListInitialParams, dynamic>(
          (initialParams, _) => BanUserListPage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<InviteUserListNavigator>(
          () => InviteUserListNavigator(getIt()),
        )
        ..registerFactoryParam<InviteUserListPresentationModel, InviteUserListInitialParams, dynamic>(
          (params, _) => InviteUserListPresentationModel.initial(params),
        )
        ..registerFactoryParam<InviteUserListPresenter, InviteUserListInitialParams, dynamic>(
          (initialParams, _) => InviteUserListPresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<InviteUserListPage, InviteUserListInitialParams, dynamic>(
          (initialParams, _) => InviteUserListPage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<CircleMemberSettingsNavigator>(
          () => CircleMemberSettingsNavigator(getIt()),
        )
        ..registerFactoryParam<CircleMemberSettingsViewModel, CircleMemberSettingsInitialParams, dynamic>(
          (params, _) => CircleMemberSettingsPresentationModel.initial(
            params,
            getIt(),
          ),
        )
        ..registerFactoryParam<CircleMemberSettingsPresenter, CircleMemberSettingsInitialParams, dynamic>(
          (initialParams, _) => CircleMemberSettingsPresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<CircleMemberSettingsPage, CircleMemberSettingsInitialParams, dynamic>(
          (initialParams, _) => CircleMemberSettingsPage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<BanUserNavigator>(
          () => BanUserNavigator(getIt()),
        )
        ..registerFactoryParam<BanUserPresentationModel, BanUserInitialParams, dynamic>(
          (params, _) => BanUserPresentationModel.initial(
            params,
            getIt(),
          ),
        )
        ..registerFactoryParam<BanUserPresenter, BanUserInitialParams, dynamic>(
          (initialParams, _) => BanUserPresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<BanUserPage, BanUserInitialParams, dynamic>(
          (initialParams, _) => BanUserPage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<CircleGroupsSelectionNavigator>(
          () => CircleGroupsSelectionNavigator(getIt()),
        )
        ..registerFactoryParam<CircleGroupsSelectionPresentationModel, CircleGroupsSelectionInitialParams, dynamic>(
          (params, _) => CircleGroupsSelectionPresentationModel.initial(params),
        )
        ..registerFactoryParam<CircleGroupsSelectionPresenter, CircleGroupsSelectionInitialParams, dynamic>(
          (params, _) => CircleGroupsSelectionPresenter(
            getIt(param1: params),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<CircleGroupsSelectionPage, CircleGroupsSelectionInitialParams, dynamic>(
          (params, _) => CircleGroupsSelectionPage(presenter: getIt(param1: params)),
        )
        ..registerFactory<CircleDetailsNavigator>(
          () => CircleDetailsNavigator(getIt(), getIt()),
        )
        ..registerFactoryParam<CircleDetailsPresentationModel, CircleDetailsInitialParams, dynamic>(
          (params, _) => CircleDetailsPresentationModel.initial(
            params,
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<CircleDetailsPresenter, CircleDetailsInitialParams, dynamic>(
          (params, _) => CircleDetailsPresenter(
            getIt(param1: params),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<CircleDetailsPage, CircleDetailsInitialParams, dynamic>(
          (params, _) => CircleDetailsPage(presenter: getIt(param1: params)),
        )
        ..registerFactoryParam<MembersPresentationModel, MembersInitialParams, dynamic>(
          (params, _) => MembersPresentationModel.initial(
            params,
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<MembersPresenter, MembersInitialParams, dynamic>(
          (params, _) => MembersPresenter(
            getIt(param1: params),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactory<MembersNavigator>(
          () => MembersNavigator(getIt(), getIt()),
        )
        ..registerFactoryParam<MembersPage, MembersInitialParams, dynamic>(
          (params, _) => MembersPage(presenter: getIt(param1: params)),
        )
        ..registerFactory<EditRulesNavigator>(
          () => EditRulesNavigator(getIt()),
        )
        ..registerFactoryParam<EditRulesViewModel, EditRulesInitialParams, dynamic>(
          (params, _) => EditRulesPresentationModel.initial(params),
        )
        ..registerFactoryParam<EditRulesPresenter, EditRulesInitialParams, dynamic>(
          (params, _) => EditRulesPresenter(
            getIt(param1: params),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<EditRulesPage, EditRulesInitialParams, dynamic>(
          (params, _) => EditRulesPage(presenter: getIt(param1: params)),
        )
        ..registerFactory<RolesListNavigator>(
          () => RolesListNavigator(getIt()),
        )
        ..registerFactoryParam<RolesListViewModel, RolesListInitialParams, dynamic>(
          (params, _) => RolesListPresentationModel.initial(params),
        )
        ..registerFactoryParam<RolesListPresenter, RolesListInitialParams, dynamic>(
          (params, _) => RolesListPresenter(
            getIt(param1: params),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<RolesListPage, RolesListInitialParams, dynamic>(
          (params, _) => RolesListPage(presenter: getIt(param1: params)),
        )
        ..registerFactory<BlacklistedWordsNavigator>(
          () => BlacklistedWordsNavigator(getIt()),
        )
        ..registerFactoryParam<BlacklistedWordsViewModel, BlacklistedWordsInitialParams, dynamic>(
          (params, _) => BlacklistedWordsPresentationModel.initial(params, getIt()),
        )
        ..registerFactoryParam<BlacklistedWordsPresenter, BlacklistedWordsInitialParams, dynamic>(
          (params, _) => BlacklistedWordsPresenter(
            getIt(param1: params),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<BlacklistedWordsPage, BlacklistedWordsInitialParams, dynamic>(
          (params, _) => BlacklistedWordsPage(presenter: getIt(param1: params)),
        )
        ..registerFactory<AddBlackListWordNavigator>(
          () => AddBlackListWordNavigator(getIt()),
        )
        ..registerFactoryParam<AddBlackListWordViewModel, AddBlackListWordInitialParams, dynamic>(
          (params, _) => AddBlackListWordPresentationModel.initial(params),
        )
        ..registerFactoryParam<AddBlackListWordPresenter, AddBlackListWordInitialParams, dynamic>(
          (params, _) => AddBlackListWordPresenter(
            getIt(param1: params),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<AddBlackListWordPage, AddBlackListWordInitialParams, dynamic>(
          (params, _) => AddBlackListWordPage(presenter: getIt(param1: params)),
        )
        ..registerFactory<ResolvedReportDetailsNavigator>(
          () => ResolvedReportDetailsNavigator(getIt()),
        )
        ..registerFactoryParam<ResolvedReportDetailsPresentationModel, ResolvedReportDetailsInitialParams, dynamic>(
          (params, _) => ResolvedReportDetailsPresentationModel.initial(params),
        )
        ..registerFactoryParam<ResolvedReportDetailsPresenter, ResolvedReportDetailsInitialParams, dynamic>(
          (initialParams, _) => ResolvedReportDetailsPresenter(
            getIt(param1: initialParams),
            getIt(),
          ),
        )
        ..registerFactoryParam<ResolvedReportDetailsPage, ResolvedReportDetailsInitialParams, dynamic>(
          (initialParams, _) => ResolvedReportDetailsPage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<EditCircleNavigator>(
          () => EditCircleNavigator(getIt()),
        )
        ..registerFactoryParam<EditCircleViewModel, EditCircleInitialParams, dynamic>(
          (params, _) => EditCirclePresentationModel.initial(
            params,
            getIt(),
          ),
        )
        ..registerFactoryParam<EditCirclePresenter, EditCircleInitialParams, dynamic>(
          (params, _) => EditCirclePresenter(
            getIt(param1: params),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<EditCirclePage, EditCircleInitialParams, dynamic>(
          (params, _) => EditCirclePage(presenter: getIt(param1: params)),
        )
        ..registerFactory<ReportsListNavigator>(
          () => ReportsListNavigator(
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<ReportsListViewModel, ReportsListInitialParams, dynamic>(
          (params, _) => ReportsListPresentationModel.initial(params, getIt()),
        )
        ..registerFactoryParam<ReportsListPresenter, ReportsListInitialParams, dynamic>(
          (params, _) => ReportsListPresenter(
            getIt(param1: params),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<ReportsListPage, ReportsListInitialParams, dynamic>(
          (params, _) => ReportsListPage(presenter: getIt(param1: params)),
        )
        ..registerFactory<BannedUsersNavigator>(
          () => BannedUsersNavigator(
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<BannedUsersViewModel, BannedUsersInitialParams, dynamic>(
          (params, _) => BannedUsersPresentationModel.initial(
            params,
            getIt(),
          ),
        )
        ..registerFactoryParam<BannedUsersPresenter, BannedUsersInitialParams, dynamic>(
          (params, _) => BannedUsersPresenter(
            getIt(param1: params),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<BannedUsersPage, BannedUsersInitialParams, dynamic>(
          (params, _) => BannedUsersPage(presenter: getIt(param1: params)),
        )
        ..registerFactory<ResolveReportWithNoActionNavigator>(
          () => ResolveReportWithNoActionNavigator(getIt()),
        )
        ..registerFactoryParam<ResolveReportWithNoActionViewModel, ResolveReportWithNoActionInitialParams, dynamic>(
          (params, _) => ResolveReportWithNoActionPresentationModel.initial(params),
        )
        ..registerFactoryParam<ResolveReportWithNoActionPresenter, ResolveReportWithNoActionInitialParams, dynamic>(
          (params, _) => ResolveReportWithNoActionPresenter(
            getIt(param1: params),
            getIt(),
          ),
        )
        ..registerFactoryParam<ResolveReportWithNoActionPage, ResolveReportWithNoActionInitialParams, dynamic>(
          (params, _) => ResolveReportWithNoActionPage(presenter: getIt(param1: params)),
        )
        ..registerFactory<CircleRoleNavigator>(
          () => CircleRoleNavigator(getIt()),
        )
        ..registerFactoryParam<CircleRoleViewModel, CircleRoleInitialParams, dynamic>(
          (params, _) => CircleRolePresentationModel.initial(params),
        )
        ..registerFactoryParam<CircleRolePresenter, CircleRoleInitialParams, dynamic>(
          (params, _) => CircleRolePresenter(
            getIt(param1: params),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<CircleRolePage, CircleRoleInitialParams, dynamic>(
          (params, _) => CircleRolePage(presenter: getIt(param1: params)),
        )
        ..registerFactory<UserRolesNavigator>(
          () => UserRolesNavigator(getIt()),
        )
        ..registerFactoryParam<UserRolesViewModel, UserRolesInitialParams, dynamic>(
          (params, _) => UserRolesPresentationModel.initial(params),
        )
        ..registerFactoryParam<UserRolesPresenter, UserRolesInitialParams, dynamic>(
          (params, _) => UserRolesPresenter(
            getIt(param1: params),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<UserRolesPage, UserRolesInitialParams, dynamic>(
          (params, _) => UserRolesPage(presenter: getIt(param1: params)),
        )
        ..registerFactory<CircleConfigNavigator>(
          () => CircleConfigNavigator(getIt()),
        )
        ..registerFactoryParam<CircleConfigViewModel, CircleConfigInitialParams, dynamic>(
          (params, _) => CircleConfigPresentationModel.initial(
            params,
            getIt(),
          ),
        )
        ..registerFactoryParam<CircleConfigPresenter, CircleConfigInitialParams, dynamic>(
          (params, _) => CircleConfigPresenter(
            getIt(param1: params),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<CircleConfigPage, CircleConfigInitialParams, dynamic>(
          (params, _) => CircleConfigPage(presenter: getIt(param1: params)),
        )

//DO-NOT-REMOVE MVP_GET_IT_CONFIG

      ;
}
