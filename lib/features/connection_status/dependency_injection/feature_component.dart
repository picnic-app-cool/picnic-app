import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/connection_status/connection_status_handler_navigator.dart';
import 'package:picnic_app/features/connection_status/connection_status_handler_presenter.dart';

import 'package:picnic_app/features/connection_status/data/flutter_connection_status_repository.dart';
import 'package:picnic_app/features/connection_status/domain/repositories/connection_status_repository.dart';
import 'package:picnic_app/features/connection_status/domain/use_cases/get_connection_status_use_case.dart';
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
        ..registerFactory<ConnectionStatusRepository>(
          () => const FlutterConnectionStatusRepository(),
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
        ..registerFactory<GetConnectionStatusUseCase>(
          () => GetConnectionStatusUseCase(getIt()),
        )

//DO-NOT-REMOVE USE_CASES_GET_IT_CONFIG
      ;
}

//ignore: long-method
void _configureMvp() {
  // ignore: unnecessary_statements
  getIt
        ..registerFactory<ConnectionStatusHandlerNavigator>(
          () => ConnectionStatusHandlerNavigator(getIt()),
        )
        ..registerFactoryParam<ConnectionStatusHandlerPresenter, dynamic, dynamic>(
          (params, _) => ConnectionStatusHandlerPresenter(
            getIt(),
            getIt(),
          ),
        )

//DO-NOT-REMOVE MVP_GET_IT_CONFIG
      ;
}
