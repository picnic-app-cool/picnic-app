import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/social_accounts/connect_accounts_bottom_sheet_initial_params.dart';
import 'package:picnic_app/features/social_accounts/connect_accounts_bottom_sheet_navigator.dart';
import 'package:picnic_app/features/social_accounts/connect_accounts_bottom_sheet_page.dart';
import 'package:picnic_app/features/social_accounts/connect_accounts_bottom_sheet_presenter.dart';
import 'package:picnic_app/features/social_accounts/connect_accounts_initial_params.dart';
import 'package:picnic_app/features/social_accounts/connect_accounts_navigator.dart';
import 'package:picnic_app/features/social_accounts/connect_accounts_presentation_model.dart';
import 'package:picnic_app/features/social_accounts/connect_accounts_presenter.dart';
import 'package:picnic_app/features/social_accounts/connect_accounts_sheet_presentation_model.dart';
import 'package:picnic_app/features/social_accounts/domain/use_cases/get_connected_social_accounts_use_case.dart';
import 'package:picnic_app/features/social_accounts/domain/use_cases/link_discord_account_use_case.dart';
import 'package:picnic_app/features/social_accounts/domain/use_cases/link_roblox_account_use_case.dart';
import 'package:picnic_app/features/social_accounts/domain/use_cases/unlink_discord_account_use_case.dart';
import 'package:picnic_app/features/social_accounts/domain/use_cases/unlink_roblox_account_use_case.dart';
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
        ..registerFactory<GetConnectedSocialAccountsUseCase>(
          () => GetConnectedSocialAccountsUseCase(
            getIt(),
          ),
        )
        ..registerFactory<LinkDiscordAccountUseCase>(
          () => LinkDiscordAccountUseCase(
            getIt(),
          ),
        )
        ..registerFactory<LinkRobloxAccountUseCase>(
          () => LinkRobloxAccountUseCase(
            getIt(),
          ),
        )
        ..registerFactory<UnlinkRobloxAccountUseCase>(
          () => UnlinkRobloxAccountUseCase(
            getIt(),
          ),
        )
        ..registerFactory<UnlinkDiscordAccountUseCase>(
          () => UnlinkDiscordAccountUseCase(
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
        ..registerFactory<ConnectAccountsNavigator>(
          () => ConnectAccountsNavigator(getIt()),
        )
        ..registerFactoryParam<ConnectAccountsViewModel, ConnectAccountsInitialParams, dynamic>(
          (params, _) => ConnectAccountsPresentationModel.initial(
            params,
            getIt(),
          ),
        )
        ..registerFactoryParam<ConnectAccountsPresenter, ConnectAccountsInitialParams, dynamic>(
          (params, _) => ConnectAccountsPresenter(
            getIt(param1: params),
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
        ..registerFactoryParam<ConnectAccountsBottomSheetPage, ConnectAccountsBottomSheetInitialParams, dynamic>(
          (initialParams, _) => ConnectAccountsBottomSheetPage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<ConnectAccountsBottomSheetNavigator>(
          () => ConnectAccountsBottomSheetNavigator(getIt()),
        )
        ..registerFactoryParam<ConnectAccountsBottomSheetViewModel, ConnectAccountsBottomSheetInitialParams, dynamic>(
          (params, _) => ConnectAccountsSheetPresentationModel.initial(params),
        )
        ..registerFactoryParam<ConnectAccountsBottomSheetPresenter, ConnectAccountsBottomSheetInitialParams, dynamic>(
          (params, _) => ConnectAccountsBottomSheetPresenter(
            getIt(param1: params),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )

//DO-NOT-REMOVE MVP_GET_IT_CONFIG
      ;
}
