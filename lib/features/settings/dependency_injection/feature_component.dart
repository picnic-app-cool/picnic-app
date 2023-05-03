import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/settings/blocked_list/blocked_list_initial_params.dart';
import 'package:picnic_app/features/settings/blocked_list/blocked_list_navigator.dart';
import 'package:picnic_app/features/settings/blocked_list/blocked_list_page.dart';
import 'package:picnic_app/features/settings/blocked_list/blocked_list_presentation_model.dart';
import 'package:picnic_app/features/settings/blocked_list/blocked_list_presenter.dart';
import 'package:picnic_app/features/settings/community_guidelines/community_guidelines_initial_params.dart';
import 'package:picnic_app/features/settings/community_guidelines/community_guidelines_navigator.dart';
import 'package:picnic_app/features/settings/community_guidelines/community_guidelines_page.dart';
import 'package:picnic_app/features/settings/community_guidelines/community_guidelines_presentation_model.dart';
import 'package:picnic_app/features/settings/community_guidelines/community_guidelines_presenter.dart';
import 'package:picnic_app/features/settings/data/graph_ql_documents_repository.dart';
import 'package:picnic_app/features/settings/delete_account/delete_account_initial_params.dart';
import 'package:picnic_app/features/settings/delete_account/delete_account_navigator.dart';
import 'package:picnic_app/features/settings/delete_account/delete_account_page.dart';
import 'package:picnic_app/features/settings/delete_account/delete_account_presentation_model.dart';
import 'package:picnic_app/features/settings/delete_account/delete_account_presenter.dart';
import "package:picnic_app/features/settings/delete_account_reasons/delete_account_reasons_initial_params.dart";
import "package:picnic_app/features/settings/delete_account_reasons/delete_account_reasons_navigator.dart";
import "package:picnic_app/features/settings/delete_account_reasons/delete_account_reasons_page.dart";
import "package:picnic_app/features/settings/delete_account_reasons/delete_account_reasons_presentation_model.dart";
import "package:picnic_app/features/settings/delete_account_reasons/delete_account_reasons_presenter.dart";
import "package:picnic_app/features/settings/domain/repositories/documents_repository.dart";
import "package:picnic_app/features/settings/domain/use_cases/get_block_list_use_case.dart";
import "package:picnic_app/features/settings/domain/use_cases/get_delete_account_reasons_use_case.dart";
import 'package:picnic_app/features/settings/domain/use_cases/get_notification_settings_use_case.dart';
import "package:picnic_app/features/settings/domain/use_cases/get_privacy_settings_use_case.dart";
import "package:picnic_app/features/settings/domain/use_cases/request_delete_account_use_case.dart";
import "package:picnic_app/features/settings/domain/use_cases/update_notification_settings_use_case.dart";
import "package:picnic_app/features/settings/domain/use_cases/update_privacy_settings_use_case.dart";
import 'package:picnic_app/features/settings/get_verified/get_verified_initial_params.dart';
import 'package:picnic_app/features/settings/get_verified/get_verified_navigator.dart';
import 'package:picnic_app/features/settings/get_verified/get_verified_page.dart';
import 'package:picnic_app/features/settings/get_verified/get_verified_presentation_model.dart';
import 'package:picnic_app/features/settings/get_verified/get_verified_presenter.dart';
import 'package:picnic_app/features/settings/invite_friends/invite_friends_initial_params.dart';
import 'package:picnic_app/features/settings/invite_friends/invite_friends_navigator.dart';
import 'package:picnic_app/features/settings/invite_friends/invite_friends_page.dart';
import 'package:picnic_app/features/settings/invite_friends/invite_friends_presentation_model.dart';
import 'package:picnic_app/features/settings/invite_friends/invite_friends_presenter.dart';
import 'package:picnic_app/features/settings/language/language_initial_params.dart';
import 'package:picnic_app/features/settings/language/language_navigator.dart';
import 'package:picnic_app/features/settings/language/language_page.dart';
import 'package:picnic_app/features/settings/language/language_presentation_model.dart';
import 'package:picnic_app/features/settings/language/language_presenter.dart';
import 'package:picnic_app/features/settings/notification_settings/notification_settings_initial_params.dart';
import 'package:picnic_app/features/settings/notification_settings/notification_settings_navigator.dart';
import 'package:picnic_app/features/settings/notification_settings/notification_settings_page.dart';
import 'package:picnic_app/features/settings/notification_settings/notification_settings_presentation_model.dart';
import 'package:picnic_app/features/settings/notification_settings/notification_settings_presenter.dart';
import 'package:picnic_app/features/settings/privacy_settings/privacy_settings_initial_params.dart';
import 'package:picnic_app/features/settings/privacy_settings/privacy_settings_navigator.dart';
import 'package:picnic_app/features/settings/privacy_settings/privacy_settings_page.dart';
import 'package:picnic_app/features/settings/privacy_settings/privacy_settings_presentation_model.dart';
import 'package:picnic_app/features/settings/privacy_settings/privacy_settings_presenter.dart';
import 'package:picnic_app/features/settings/settings_home/settings_home_initial_params.dart';
import 'package:picnic_app/features/settings/settings_home/settings_home_navigator.dart';
import 'package:picnic_app/features/settings/settings_home/settings_home_page.dart';
import 'package:picnic_app/features/settings/settings_home/settings_home_presentation_model.dart';
import 'package:picnic_app/features/settings/settings_home/settings_home_presenter.dart';

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
        ..registerFactory<DocumentsRepository>(
          () => GraphQlDocumentsRepository(
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
        ..registerFactory<GetNotificationSettingsUseCase>(
          () => GetNotificationSettingsUseCase(
            getIt(),
          ),
        )
        ..registerFactory<GetBlockListUseCase>(
          () => GetBlockListUseCase(
            getIt(),
          ),
        )
        ..registerFactory<RequestDeleteAccountUseCase>(
          () => RequestDeleteAccountUseCase(
            getIt(),
          ),
        )
        ..registerFactory<UpdatePrivacySettingsUseCase>(
          () => UpdatePrivacySettingsUseCase(
            getIt(),
          ),
        )
        ..registerFactory<GetPrivacySettingsUseCase>(
          () => GetPrivacySettingsUseCase(
            getIt(),
          ),
        )
        ..registerFactory<UpdateNotificationSettingsUseCase>(
          () => UpdateNotificationSettingsUseCase(
            getIt(),
          ),
        )
        ..registerFactory<GetDeleteAccountReasonsUseCase>(
          () => GetDeleteAccountReasonsUseCase(
            getIt(),
          ),
        )

//DO-NOT-REMOVE USE_CASES_GET_IT_CONFIG

      ;
}

//ignore: long-method
void _configureMvp() {
  // ignore: unnecessary_statements
  getIt
        ..registerFactory<SettingsHomeNavigator>(
          () => SettingsHomeNavigator(getIt()),
        )
        ..registerFactoryParam<SettingsHomePresentationModel, SettingsHomeInitialParams, dynamic>(
          (params, _) => SettingsHomePresentationModel.initial(
            params,
            getIt(),
          ),
        )
        ..registerFactoryParam<SettingsHomePresenter, SettingsHomeInitialParams, dynamic>(
          (initialParams, _) => SettingsHomePresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<SettingsHomePage, SettingsHomeInitialParams, dynamic>(
          (initialParams, _) => SettingsHomePage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<LanguageNavigator>(
          () => LanguageNavigator(
            getIt(),
          ),
        )
        ..registerFactoryParam<LanguagePresentationModel, LanguageInitialParams, dynamic>(
          (params, _) => LanguagePresentationModel.initial(params, getIt()),
        )
        ..registerFactoryParam<LanguagePresenter, LanguageInitialParams, dynamic>(
          (initialParams, _) => LanguagePresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<LanguagePage, LanguageInitialParams, dynamic>(
          (initialParams, _) => LanguagePage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<BlockedListNavigator>(
          () => BlockedListNavigator(
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<BlockedListPresentationModel, BlockedListInitialParams, dynamic>(
          (params, _) => BlockedListPresentationModel.initial(params),
        )
        ..registerFactoryParam<BlockedListPresenter, BlockedListInitialParams, dynamic>(
          (initialParams, _) => BlockedListPresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<BlockedListPage, BlockedListInitialParams, dynamic>(
          (initialParams, _) => BlockedListPage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<CommunityGuidelinesNavigator>(
          () => CommunityGuidelinesNavigator(getIt()),
        )
        ..registerFactoryParam<CommunityGuidelinesPresentationModel, CommunityGuidelinesInitialParams, dynamic>(
          (params, _) => CommunityGuidelinesPresentationModel.initial(params),
        )
        ..registerFactoryParam<CommunityGuidelinesPresenter, CommunityGuidelinesInitialParams, dynamic>(
          (initialParams, _) => CommunityGuidelinesPresenter(
            getIt(param1: initialParams),
            getIt(),
          ),
        )
        ..registerFactoryParam<CommunityGuidelinesPage, CommunityGuidelinesInitialParams, dynamic>(
          (initialParams, _) => CommunityGuidelinesPage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<GetVerifiedNavigator>(
          () => GetVerifiedNavigator(getIt()),
        )
        ..registerFactoryParam<GetVerifiedPresentationModel, GetVerifiedInitialParams, dynamic>(
          (params, _) => GetVerifiedPresentationModel.initial(params),
        )
        ..registerFactoryParam<GetVerifiedPresenter, GetVerifiedInitialParams, dynamic>(
          (initialParams, _) => GetVerifiedPresenter(
            getIt(param1: initialParams),
            getIt(),
          ),
        )
        ..registerFactoryParam<GetVerifiedPage, GetVerifiedInitialParams, dynamic>(
          (initialParams, _) => GetVerifiedPage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<NotificationSettingsNavigator>(
          () => NotificationSettingsNavigator(getIt()),
        )
        ..registerFactoryParam<NotificationSettingsPresentationModel, NotificationSettingsInitialParams, dynamic>(
          (params, _) => NotificationSettingsPresentationModel.initial(params),
        )
        ..registerFactoryParam<NotificationSettingsPresenter, NotificationSettingsInitialParams, dynamic>(
          (initialParams, _) => NotificationSettingsPresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<NotificationSettingsPage, NotificationSettingsInitialParams, dynamic>(
          (initialParams, _) => NotificationSettingsPage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<PrivacySettingsNavigator>(
          () => PrivacySettingsNavigator(getIt()),
        )
        ..registerFactoryParam<PrivacySettingsPresentationModel, PrivacySettingsInitialParams, dynamic>(
          (params, _) => PrivacySettingsPresentationModel.initial(params),
        )
        ..registerFactoryParam<PrivacySettingsPresenter, PrivacySettingsInitialParams, dynamic>(
          (initialParams, _) => PrivacySettingsPresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<PrivacySettingsPage, PrivacySettingsInitialParams, dynamic>(
          (initialParams, _) => PrivacySettingsPage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<DeleteAccountNavigator>(
          () => DeleteAccountNavigator(getIt()),
        )
        ..registerFactoryParam<DeleteAccountPresentationModel, DeleteAccountInitialParams, dynamic>(
          (params, _) => DeleteAccountPresentationModel.initial(params, getIt()),
        )
        ..registerFactoryParam<DeleteAccountPresenter, DeleteAccountInitialParams, dynamic>(
          (initialParams, _) => DeleteAccountPresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<DeleteAccountPage, DeleteAccountInitialParams, dynamic>(
          (initialParams, _) => DeleteAccountPage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<DeleteAccountReasonsNavigator>(
          () => DeleteAccountReasonsNavigator(getIt()),
        )
        ..registerFactoryParam<DeleteAccountReasonsViewModel, DeleteAccountReasonsInitialParams, dynamic>(
          (params, _) => DeleteAccountReasonsPresentationModel.initial(params),
        )
        ..registerFactoryParam<DeleteAccountReasonsPresenter, DeleteAccountReasonsInitialParams, dynamic>(
          (params, _) => DeleteAccountReasonsPresenter(
            getIt(param1: params),
            getIt(),
          ),
        )
        ..registerFactoryParam<DeleteAccountReasonsPage, DeleteAccountReasonsInitialParams, dynamic>(
          (params, _) => DeleteAccountReasonsPage(presenter: getIt(param1: params)),
        )
        ..registerFactory<InviteFriendsNavigator>(
          () => InviteFriendsNavigator(getIt()),
        )
        ..registerFactoryParam<InviteFriendsViewModel, InviteFriendsInitialParams, dynamic>(
          (params, _) => InviteFriendsPresentationModel.initial(params),
        )
        ..registerFactoryParam<InviteFriendsPresenter, InviteFriendsInitialParams, dynamic>(
          (params, _) => InviteFriendsPresenter(
            getIt(param1: params),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<InviteFriendsPage, InviteFriendsInitialParams, dynamic>(
          (params, _) => InviteFriendsPage(presenter: getIt(param1: params)),
        )

//DO-NOT-REMOVE MVP_GET_IT_CONFIG

      ;
}
