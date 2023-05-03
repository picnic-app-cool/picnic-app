import 'package:picnic_desktop_app/dependency_injection/app_component.dart';
import 'package:picnic_desktop_app/features/main/main_initial_params.dart';
import 'package:picnic_desktop_app/features/main/main_navigator.dart';
import 'package:picnic_desktop_app/features/main/main_page.dart';
import 'package:picnic_desktop_app/features/main/main_presentation_model.dart';
import 'package:picnic_desktop_app/features/main/main_presenter.dart';

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
        ..registerFactory<MainNavigator>(
          () => MainNavigator(getIt()),
        )
        ..registerFactoryParam<MainViewModel, MainInitialParams, dynamic>(
          (params, _) => MainPresentationModel.initial(params, getIt()),
        )
        ..registerFactoryParam<MainPresenter, MainInitialParams, dynamic>(
          (params, _) => MainPresenter(getIt(param1: params), getIt()),
        )
        ..registerFactoryParam<MainPage, MainInitialParams, dynamic>(
          (params, _) => MainPage(presenter: getIt(param1: params)),
        )

//DO-NOT-REMOVE MVP_GET_IT_CONFIG
      ;
}
