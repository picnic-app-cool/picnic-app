import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/force_update/data/app_remote_config_repository.dart';
import 'package:picnic_app/features/force_update/data/app_store_repository.dart';
import 'package:picnic_app/features/force_update/domain/repositories/remote_config_repository.dart';
import 'package:picnic_app/features/force_update/domain/repositories/store_repository.dart';
import 'package:picnic_app/features/force_update/domain/use_case/fetch_min_app_version_use_case.dart';
import 'package:picnic_app/features/force_update/domain/use_case/open_store_use_case.dart';
import 'package:picnic_app/features/force_update/domain/use_case/should_show_force_update_use_case.dart';
import 'package:picnic_app/features/force_update/force_update_initial_params.dart';
import 'package:picnic_app/features/force_update/force_update_navigator.dart';
import 'package:picnic_app/features/force_update/force_update_page.dart';
import 'package:picnic_app/features/force_update/force_update_presentation_model.dart';
import 'package:picnic_app/features/force_update/force_update_presenter.dart';

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
        ..registerFactory<StoreRepository>(
          () => AppStoreRepository(getIt()),
        )

//DO-NOT-REMOVE REPOSITORIES_GET_IT_CONFIG
      ;

  getIt
        ..registerFactory<RemoteConfigRepository>(
          () => AppRemoteConfigRepository(),
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
        ..registerFactory<FetchMinAppVersionUseCase>(
          () => FetchMinAppVersionUseCase(getIt()),
        )

//DO-NOT-REMOVE USE_CASES_GET_IT_CONFIG
      ;

  // ignore: unnecessary_statements
  getIt
        ..registerFactory<OpenStoreUseCase>(
          () => OpenStoreUseCase(getIt()),
        )

//DO-NOT-REMOVE USE_CASES_GET_IT_CONFIG
      ;

  getIt
        ..registerFactory<ShouldShowForceUpdateUseCase>(
          () => ShouldShowForceUpdateUseCase(getIt(), getIt()),
        )

//DO-NOT-REMOVE USE_CASES_GET_IT_CONFIG
      ;
}

//ignore: long-method
void _configureMvp() {
  // ignore: unnecessary_statements
  getIt
        ..registerFactory<ForceUpdateNavigator>(
          () => ForceUpdateNavigator(getIt()),
        )
        ..registerFactoryParam<ForceUpdateViewModel, ForceUpdateInitialParams, dynamic>(
          (params, _) => ForceUpdatePresentationModel.initial(
            params,
            getIt(),
          ),
        )
        ..registerFactoryParam<ForceUpdatePresenter, ForceUpdateInitialParams, dynamic>(
          (params, _) => ForceUpdatePresenter(
            getIt(param1: params),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<ForceUpdatePage, ForceUpdateInitialParams, dynamic>(
          (params, _) => ForceUpdatePage(presenter: getIt(param1: params)),
        )

//DO-NOT-REMOVE MVP_GET_IT_CONFIG
      ;
}
