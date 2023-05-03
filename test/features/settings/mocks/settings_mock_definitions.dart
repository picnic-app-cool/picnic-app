import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/settings/blocked_list/blocked_list_initial_params.dart';
import 'package:picnic_app/features/settings/blocked_list/blocked_list_navigator.dart';
import 'package:picnic_app/features/settings/blocked_list/blocked_list_presentation_model.dart';
import 'package:picnic_app/features/settings/blocked_list/blocked_list_presenter.dart';
import 'package:picnic_app/features/settings/community_guidelines/community_guidelines_initial_params.dart';
import 'package:picnic_app/features/settings/community_guidelines/community_guidelines_navigator.dart';
import 'package:picnic_app/features/settings/community_guidelines/community_guidelines_presentation_model.dart';
import 'package:picnic_app/features/settings/community_guidelines/community_guidelines_presenter.dart';
import 'package:picnic_app/features/settings/delete_account/delete_account_initial_params.dart';
import 'package:picnic_app/features/settings/delete_account/delete_account_navigator.dart';
import 'package:picnic_app/features/settings/delete_account/delete_account_presentation_model.dart';
import 'package:picnic_app/features/settings/delete_account/delete_account_presenter.dart';
import "package:picnic_app/features/settings/delete_account_reasons/delete_account_reasons_initial_params.dart";
import "package:picnic_app/features/settings/delete_account_reasons/delete_account_reasons_navigator.dart";
import "package:picnic_app/features/settings/delete_account_reasons/delete_account_reasons_presentation_model.dart";
import "package:picnic_app/features/settings/delete_account_reasons/delete_account_reasons_presenter.dart";
import "package:picnic_app/features/settings/domain/model/get_block_list_failure.dart";
import "package:picnic_app/features/settings/domain/model/get_delete_account_reasons_failure.dart";
import 'package:picnic_app/features/settings/domain/model/get_notification_settings_failure.dart';
import "package:picnic_app/features/settings/domain/model/get_privacy_settings_failure.dart";
import "package:picnic_app/features/settings/domain/model/request_delete_account_failure.dart";
import "package:picnic_app/features/settings/domain/model/update_notification_settings_failure.dart";
import "package:picnic_app/features/settings/domain/model/update_privacy_settings_failure.dart";
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
import 'package:picnic_app/features/settings/get_verified/get_verified_presentation_model.dart';
import 'package:picnic_app/features/settings/get_verified/get_verified_presenter.dart';
import 'package:picnic_app/features/settings/invite_friends/invite_friends_initial_params.dart';
import 'package:picnic_app/features/settings/invite_friends/invite_friends_navigator.dart';
import 'package:picnic_app/features/settings/invite_friends/invite_friends_presentation_model.dart';
import 'package:picnic_app/features/settings/invite_friends/invite_friends_presenter.dart';
import 'package:picnic_app/features/settings/language/language_initial_params.dart';
import 'package:picnic_app/features/settings/language/language_navigator.dart';
import 'package:picnic_app/features/settings/language/language_presentation_model.dart';
import 'package:picnic_app/features/settings/language/language_presenter.dart';
import 'package:picnic_app/features/settings/notification_settings/notification_settings_initial_params.dart';
import 'package:picnic_app/features/settings/notification_settings/notification_settings_navigator.dart';
import 'package:picnic_app/features/settings/notification_settings/notification_settings_presentation_model.dart';
import 'package:picnic_app/features/settings/notification_settings/notification_settings_presenter.dart';
import 'package:picnic_app/features/settings/privacy_settings/privacy_settings_initial_params.dart';
import 'package:picnic_app/features/settings/privacy_settings/privacy_settings_navigator.dart';
import 'package:picnic_app/features/settings/privacy_settings/privacy_settings_presentation_model.dart';
import 'package:picnic_app/features/settings/privacy_settings/privacy_settings_presenter.dart';
import 'package:picnic_app/features/settings/settings_home/settings_home_initial_params.dart';
import 'package:picnic_app/features/settings/settings_home/settings_home_navigator.dart';
import 'package:picnic_app/features/settings/settings_home/settings_home_presentation_model.dart';
import 'package:picnic_app/features/settings/settings_home/settings_home_presenter.dart';

//DO-NOT-REMOVE IMPORTS_MOCK_DEFINITIONS

// MVP

class MockSettingsHomePresenter extends MockCubit<SettingsHomeViewModel> implements SettingsHomePresenter {}

class MockSettingsHomePresentationModel extends Mock implements SettingsHomePresentationModel {}

class MockSettingsHomeInitialParams extends Mock implements SettingsHomeInitialParams {}

class MockSettingsHomeNavigator extends Mock implements SettingsHomeNavigator {}

class MockLanguagePresenter extends MockCubit<LanguageViewModel> implements LanguagePresenter {}

class MockLanguagePresentationModel extends Mock implements LanguagePresentationModel {}

class MockLanguageInitialParams extends Mock implements LanguageInitialParams {}

class MockLanguageNavigator extends Mock implements LanguageNavigator {}

class MockBlockedListPresenter extends MockCubit<BlockedListViewModel> implements BlockedListPresenter {}

class MockBlockedListPresentationModel extends Mock implements BlockedListPresentationModel {}

class MockBlockedListInitialParams extends Mock implements BlockedListInitialParams {}

class MockBlockedListNavigator extends Mock implements BlockedListNavigator {}

class MockCommunityGuidelinesPresenter extends MockCubit<CommunityGuidelinesViewModel>
    implements CommunityGuidelinesPresenter {}

class MockCommunityGuidelinesPresentationModel extends Mock implements CommunityGuidelinesPresentationModel {}

class MockCommunityGuidelinesInitialParams extends Mock implements CommunityGuidelinesInitialParams {}

class MockCommunityGuidelinesNavigator extends Mock implements CommunityGuidelinesNavigator {}

class MockGetVerifiedPresenter extends MockCubit<GetVerifiedViewModel> implements GetVerifiedPresenter {}

class MockGetVerifiedPresentationModel extends Mock implements GetVerifiedPresentationModel {}

class MockGetVerifiedInitialParams extends Mock implements GetVerifiedInitialParams {}

class MockGetVerifiedNavigator extends Mock implements GetVerifiedNavigator {}

class MockNotificationSettingsPresenter extends MockCubit<NotificationSettingsViewModel>
    implements NotificationSettingsPresenter {}

class MockNotificationSettingsPresentationModel extends Mock implements NotificationSettingsPresentationModel {}

class MockNotificationSettingsInitialParams extends Mock implements NotificationSettingsInitialParams {}

class MockNotificationSettingsNavigator extends Mock implements NotificationSettingsNavigator {}

class MockPrivacySettingsPresenter extends MockCubit<PrivacySettingsViewModel> implements PrivacySettingsPresenter {}

class MockPrivacySettingsPresentationModel extends Mock implements PrivacySettingsPresentationModel {}

class MockPrivacySettingsInitialParams extends Mock implements PrivacySettingsInitialParams {}

class MockPrivacySettingsNavigator extends Mock implements PrivacySettingsNavigator {}

class MockDeleteAccountPresenter extends MockCubit<DeleteAccountViewModel> implements DeleteAccountPresenter {}

class MockDeleteAccountPresentationModel extends Mock implements DeleteAccountPresentationModel {}

class MockDeleteAccountInitialParams extends Mock implements DeleteAccountInitialParams {}

class MockDeleteAccountNavigator extends Mock implements DeleteAccountNavigator {}

class MockDeleteAccountReasonsPresenter extends MockCubit<DeleteAccountReasonsViewModel>
    implements DeleteAccountReasonsPresenter {}

class MockDeleteAccountReasonsPresentationModel extends Mock implements DeleteAccountReasonsPresentationModel {}

class MockDeleteAccountReasonsInitialParams extends Mock implements DeleteAccountReasonsInitialParams {}

class MockDeleteAccountReasonsNavigator extends Mock implements DeleteAccountReasonsNavigator {}

class MockInviteFriendsPresenter extends MockCubit<InviteFriendsViewModel> implements InviteFriendsPresenter {}

class MockInviteFriendsPresentationModel extends Mock implements InviteFriendsPresentationModel {}

class MockInviteFriendsInitialParams extends Mock implements InviteFriendsInitialParams {}

class MockInviteFriendsNavigator extends Mock implements InviteFriendsNavigator {}

//DO-NOT-REMOVE MVP_MOCK_DEFINITION

// USE CASES
class MockGetNotificationSettingsFailure extends Mock implements GetNotificationSettingsFailure {}

class MockGetNotificationSettingsUseCase extends Mock implements GetNotificationSettingsUseCase {}

class MockGetBlockListFailure extends Mock implements GetBlockListFailure {}

class MockGetBlockListUseCase extends Mock implements GetBlockListUseCase {}

class MockRequestDeleteAccountFailure extends Mock implements RequestDeleteAccountFailure {}

class MockRequestDeleteAccountUseCase extends Mock implements RequestDeleteAccountUseCase {}

class MockUpdatePrivacySettingsFailure extends Mock implements UpdatePrivacySettingsFailure {}

class MockUpdatePrivacySettingsUseCase extends Mock implements UpdatePrivacySettingsUseCase {}

class MockGetPrivacySettingsFailure extends Mock implements GetPrivacySettingsFailure {}

class MockGetPrivacySettingsUseCase extends Mock implements GetPrivacySettingsUseCase {}

class MockUpdateNotificationSettingsFailure extends Mock implements UpdateNotificationSettingsFailure {}

class MockUpdateNotificationSettingsUseCase extends Mock implements UpdateNotificationSettingsUseCase {}

class MockGetDeleteAccountReasonsFailure extends Mock implements GetDeleteAccountReasonsFailure {}

class MockGetDeleteAccountReasonsUseCase extends Mock implements GetDeleteAccountReasonsUseCase {}

//DO-NOT-REMOVE USE_CASE_MOCK_DEFINITION

// REPOSITORIES
class MockDocumentsRepository extends Mock implements DocumentsRepository {}
//DO-NOT-REMOVE REPOSITORIES_MOCK_DEFINITION

// STORES
//DO-NOT-REMOVE STORES_MOCK_DEFINITION
