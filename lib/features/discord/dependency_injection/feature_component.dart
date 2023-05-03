import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/discord/data/graphql_discord_repository.dart';
import 'package:picnic_app/features/discord/domain/repositories/discord_repository.dart';
import 'package:picnic_app/features/discord/domain/use_cases/connect_discord_server_use_case.dart';
import 'package:picnic_app/features/discord/domain/use_cases/get_discord_config_use_case.dart';
import 'package:picnic_app/features/discord/domain/use_cases/revoke_discord_webhook_use_case.dart';
import 'package:picnic_app/features/discord/link_discord_initial_params.dart';
import 'package:picnic_app/features/discord/link_discord_navigator.dart';
import 'package:picnic_app/features/discord/link_discord_presentation_model.dart';
import 'package:picnic_app/features/discord/link_discord_presenter.dart';
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
        ..registerFactory<DiscordRepository>(
          () => GraphqlDiscordRepository(
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
        ..registerFactory<ConnectDiscordServerUseCase>(
          () => ConnectDiscordServerUseCase(
            getIt(),
          ),
        )
        ..registerFactory<GetDiscordConfigUseCase>(
          () => GetDiscordConfigUseCase(
            getIt(),
          ),
        )
        ..registerFactory<RevokeDiscordWebhookUseCase>(
          () => RevokeDiscordWebhookUseCase(
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
        ..registerFactory<LinkDiscordNavigator>(
          () => LinkDiscordNavigator(getIt()),
        )
        ..registerFactoryParam<LinkDiscordViewModel, LinkDiscordInitialParams, dynamic>(
          (params, _) => LinkDiscordPresentationModel.initial(params),
        )
        ..registerFactoryParam<LinkDiscordPresenter, LinkDiscordInitialParams, dynamic>(
          (params, _) => LinkDiscordPresenter(
            getIt(param1: params),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )

//DO-NOT-REMOVE MVP_GET_IT_CONFIG
      ;
}
