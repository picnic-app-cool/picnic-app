import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/social_accounts/connect_accounts_bottom_sheet_initial_params.dart';
import 'package:picnic_app/features/social_accounts/connect_accounts_bottom_sheet_navigator.dart';
import 'package:picnic_app/features/social_accounts/connect_accounts_bottom_sheet_presenter.dart';
import 'package:picnic_app/features/social_accounts/connect_accounts_initial_params.dart';
import 'package:picnic_app/features/social_accounts/connect_accounts_navigator.dart';
import 'package:picnic_app/features/social_accounts/connect_accounts_presentation_model.dart';
import 'package:picnic_app/features/social_accounts/connect_accounts_presenter.dart';
import 'package:picnic_app/features/social_accounts/connect_accounts_sheet_presentation_model.dart';
import 'package:picnic_app/features/social_accounts/domain/model/get_connected_social_accounts_failure.dart';
import 'package:picnic_app/features/social_accounts/domain/model/link_discord_account_failure.dart';
import 'package:picnic_app/features/social_accounts/domain/model/link_roblox_account_failure.dart';
import 'package:picnic_app/features/social_accounts/domain/model/unlink_discord_account_failure.dart';
import 'package:picnic_app/features/social_accounts/domain/model/unlink_roblox_account_failure.dart';
import 'package:picnic_app/features/social_accounts/domain/use_cases/get_connected_social_accounts_use_case.dart';
import 'package:picnic_app/features/social_accounts/domain/use_cases/link_discord_account_use_case.dart';
import 'package:picnic_app/features/social_accounts/domain/use_cases/link_roblox_account_use_case.dart';
import 'package:picnic_app/features/social_accounts/domain/use_cases/unlink_discord_account_use_case.dart';
import 'package:picnic_app/features/social_accounts/domain/use_cases/unlink_roblox_account_use_case.dart';

//DO-NOT-REMOVE IMPORTS_MOCK_DEFINITIONS

// MVP

class MockConnectAccountsPresenter extends MockCubit<ConnectAccountsViewModel> implements ConnectAccountsPresenter {}

class MockConnectAccountsPresentationModel extends Mock implements ConnectAccountsPresentationModel {}

class MockConnectAccountsInitialParams extends Mock implements ConnectAccountsInitialParams {}

class MockConnectAccountsNavigator extends Mock implements ConnectAccountsNavigator {}

class MockConnectAccountsBottomSheetPresenter extends MockCubit<ConnectAccountsBottomSheetViewModel>
    implements ConnectAccountsBottomSheetPresenter {}

class MockConnectAccountsBottomSheetPresentationModel extends Mock implements ConnectAccountsSheetPresentationModel {}

class MockConnectAccountsBottomSheetInitialParams extends Mock implements ConnectAccountsBottomSheetInitialParams {}

class MockConnectAccountsBottomSheetNavigator extends Mock implements ConnectAccountsBottomSheetNavigator {}

//DO-NOT-REMOVE MVP_MOCK_DEFINITION

// USE CASES
class MockGetConnectedSocialAccountsFailure extends Mock implements GetConnectedSocialAccountsFailure {}

class MockGetConnectedSocialAccountsUseCase extends Mock implements GetConnectedSocialAccountsUseCase {}

class MockLinkDiscordAccountFailure extends Mock implements LinkDiscordAccountFailure {}

class MockLinkDiscordAccountUseCase extends Mock implements LinkDiscordAccountUseCase {}

class MockLinkRobloxAccountFailure extends Mock implements LinkRobloxAccountFailure {}

class MockLinkRobloxAccountUseCase extends Mock implements LinkRobloxAccountUseCase {}

class MockUnlinkRobloxAccountFailure extends Mock implements UnlinkRobloxAccountFailure {}

class MockUnlinkRobloxAccountUseCase extends Mock implements UnlinkRobloxAccountUseCase {}

class MockUnlinkDiscordAccountFailure extends Mock implements UnlinkDiscordAccountFailure {}

class MockUnlinkDiscordAccountUseCase extends Mock implements UnlinkDiscordAccountUseCase {}

//DO-NOT-REMOVE USE_CASE_MOCK_DEFINITION

// REPOSITORIES
//DO-NOT-REMOVE REPOSITORIES_MOCK_DEFINITION

// STORES
//DO-NOT-REMOVE STORES_MOCK_DEFINITION
