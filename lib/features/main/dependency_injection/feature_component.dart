import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/main/data/graphql_language_repository.dart';
import 'package:picnic_app/features/main/domain/repositories/language_repository.dart';
import "package:picnic_app/features/main/languages_list/languages_list_initial_params.dart";
import "package:picnic_app/features/main/languages_list/languages_list_navigator.dart";
import "package:picnic_app/features/main/languages_list/languages_list_page.dart";
import "package:picnic_app/features/main/languages_list/languages_list_presentation_model.dart";
import "package:picnic_app/features/main/languages_list/languages_list_presenter.dart";
import "package:picnic_app/features/main/main_initial_params.dart";
import "package:picnic_app/features/main/main_navigator.dart";
import "package:picnic_app/features/main/main_page.dart";
import "package:picnic_app/features/main/main_presentation_model.dart";
import "package:picnic_app/features/main/main_presenter.dart";

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
        ..registerFactory<LanguageRepository>(
          () => GraphqlLanguageRepository(getIt()),
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
        ..registerFactoryParam<MainPresentationModel, MainInitialParams, dynamic>(
          (params, _) => MainPresentationModel.initial(
            params,
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<MainPresenter, MainInitialParams, dynamic>(
          (params, _) => MainPresenter(
            getIt(param1: params),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<MainPage, MainInitialParams, dynamic>(
          (params, _) => MainPage(presenter: getIt(param1: params)),
        )
        ..registerFactory<LanguagesListNavigator>(
          () => LanguagesListNavigator(getIt()),
        )
        ..registerFactoryParam<LanguagesListPresentationModel, LanguagesListInitialParams, dynamic>(
          (params, _) => LanguagesListPresentationModel.initial(params),
        )
        ..registerFactoryParam<LanguagesListPresenter, LanguagesListInitialParams, dynamic>(
          (params, _) => LanguagesListPresenter(
            getIt(param1: params),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<LanguagesListPage, LanguagesListInitialParams, dynamic>(
          (params, _) => LanguagesListPage(presenter: getIt(param1: params)),
        )

//DO-NOT-REMOVE MVP_GET_IT_CONFIG
      ;
}
