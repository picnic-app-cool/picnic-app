import 'package:picnic_app/dependency_injection/app_component.dart';
import "package:picnic_app/features/debug/debug/debug_initial_params.dart";
import "package:picnic_app/features/debug/debug/debug_navigator.dart";
import "package:picnic_app/features/debug/debug/debug_page.dart";
import "package:picnic_app/features/debug/debug/debug_presentation_model.dart";
import "package:picnic_app/features/debug/debug/debug_presenter.dart";
import 'package:picnic_app/features/debug/domain/use_cases/change_environment_use_case.dart';
import 'package:picnic_app/features/debug/domain/use_cases/change_feature_flags_use_case.dart';
import "package:picnic_app/features/debug/domain/use_cases/invalidate_token_use_case.dart";
import "package:picnic_app/features/debug/domain/use_cases/prepare_logs_file_use_case.dart";
import "package:picnic_app/features/debug/domain/use_cases/restart_app_use_case.dart";
import 'package:picnic_app/features/debug/feature_flags/feature_flags_initial_params.dart';
import 'package:picnic_app/features/debug/feature_flags/feature_flags_navigator.dart';
import 'package:picnic_app/features/debug/feature_flags/feature_flags_page.dart';
import 'package:picnic_app/features/debug/feature_flags/feature_flags_presentation_model.dart';
import 'package:picnic_app/features/debug/feature_flags/feature_flags_presenter.dart';
import "package:picnic_app/features/debug/log_console/log_console_initial_params.dart";
import "package:picnic_app/features/debug/log_console/log_console_navigator.dart";
import "package:picnic_app/features/debug/log_console/log_console_page.dart";
import "package:picnic_app/features/debug/log_console/log_console_presentation_model.dart";
import "package:picnic_app/features/debug/log_console/log_console_presenter.dart";

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
        ..registerFactory<PrepareLogsFileUseCase>(
          () => const PrepareLogsFileUseCase(),
        )
        ..registerFactory<InvalidateTokenUseCase>(
          () => InvalidateTokenUseCase(
            getIt(),
          ),
        )
        ..registerFactory<RestartAppUseCase>(
          () => const RestartAppUseCase(),
        )
        ..registerFactory<ChangeEnvironmentUseCase>(
          () => ChangeEnvironmentUseCase(
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactory<ChangeFeatureFlagsUseCase>(
          () => ChangeFeatureFlagsUseCase(
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
        ..registerFactory<DebugNavigator>(
          () => DebugNavigator(getIt()),
        )
        ..registerFactoryParam<DebugPresentationModel, DebugInitialParams, dynamic>(
          (params, _) => DebugPresentationModel.initial(params),
        )
        ..registerFactoryParam<DebugPresenter, DebugInitialParams, dynamic>(
          (params, _) => DebugPresenter(
            getIt(param1: params),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<DebugPage, DebugInitialParams, dynamic>(
          (params, _) => DebugPage(presenter: getIt(param1: params)),
        )
        ..registerFactory<LogConsoleNavigator>(
          () => LogConsoleNavigator(getIt()),
        )
        ..registerFactoryParam<LogConsolePresentationModel, LogConsoleInitialParams, dynamic>(
          (params, _) => LogConsolePresentationModel.initial(params),
        )
        ..registerFactoryParam<LogConsolePresenter, LogConsoleInitialParams, dynamic>(
          (params, _) => LogConsolePresenter(
            getIt(param1: params),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<LogConsolePage, LogConsoleInitialParams, dynamic>(
          (params, _) => LogConsolePage(presenter: getIt(param1: params)),
        )
        ..registerFactory<FeatureFlagsNavigator>(
          () => FeatureFlagsNavigator(getIt()),
        )
        ..registerFactoryParam<FeatureFlagsViewModel, FeatureFlagsInitialParams, dynamic>(
          (params, _) => FeatureFlagsPresentationModel.initial(
            params,
            getIt(),
          ),
        )
        ..registerFactoryParam<FeatureFlagsPresenter, FeatureFlagsInitialParams, dynamic>(
          (params, _) => FeatureFlagsPresenter(
            getIt(param1: params),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<FeatureFlagsPage, FeatureFlagsInitialParams, dynamic>(
          (params, _) => FeatureFlagsPage(presenter: getIt(param1: params)),
        )

//DO-NOT-REMOVE MVP_GET_IT_CONFIG
      ;
}
