import 'package:picnic_app/dependency_injection/app_component.dart';
import "package:picnic_app/features/loading_splash/loading_splash_initial_params.dart";
import "package:picnic_app/features/loading_splash/loading_splash_navigator.dart";
import "package:picnic_app/features/loading_splash/loading_splash_page.dart";
import "package:picnic_app/features/loading_splash/loading_splash_presentation_model.dart";
import "package:picnic_app/features/loading_splash/loading_splash_presenter.dart";

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
      //DO-NOT-REMOVE USE_CASES_GET_IT_CONFIG
      ;
}

//ignore: long-method
void _configureMvp() {
  // ignore: unnecessary_statements
  getIt
        ..registerFactory<LoadingSplashNavigator>(
          () => LoadingSplashNavigator(getIt()),
        )
        ..registerFactoryParam<LoadingSplashViewModel, LoadingSplashInitialParams, dynamic>(
          (params, _) => LoadingSplashPresentationModel.initial(params),
        )
        ..registerFactoryParam<LoadingSplashPresenter, LoadingSplashInitialParams, dynamic>(
          (params, _) => LoadingSplashPresenter(
            getIt(param1: params),
            getIt(),
          ),
        )
        ..registerFactoryParam<LoadingSplashPage, LoadingSplashInitialParams, dynamic>(
          (params, _) => LoadingSplashPage(presenter: getIt(param1: params)),
        )

//DO-NOT-REMOVE MVP_GET_IT_CONFIG
      ;
}
