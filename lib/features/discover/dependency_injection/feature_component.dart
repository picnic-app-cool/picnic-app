import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/discover/data/gql_discover_repository.dart';
import 'package:picnic_app/features/discover/discover_circles/discover_circles_initial_params.dart';
import 'package:picnic_app/features/discover/discover_circles/discover_circles_navigator.dart';
import 'package:picnic_app/features/discover/discover_circles/discover_circles_page.dart';
import 'package:picnic_app/features/discover/discover_circles/discover_circles_presentation_model.dart';
import 'package:picnic_app/features/discover/discover_circles/discover_circles_presenter.dart';
import 'package:picnic_app/features/discover/discover_explore/discover_explore_initial_params.dart';
import 'package:picnic_app/features/discover/discover_explore/discover_explore_navigator.dart';
import 'package:picnic_app/features/discover/discover_explore/discover_explore_page.dart';
import 'package:picnic_app/features/discover/discover_explore/discover_explore_presentation_model.dart';
import 'package:picnic_app/features/discover/discover_explore/discover_explore_presenter.dart';
import 'package:picnic_app/features/discover/discover_pods/discover_pods_initial_params.dart';
import 'package:picnic_app/features/discover/discover_pods/discover_pods_navigator.dart';
import 'package:picnic_app/features/discover/discover_pods/discover_pods_page.dart';
import 'package:picnic_app/features/discover/discover_pods/discover_pods_presentation_model.dart';
import 'package:picnic_app/features/discover/discover_pods/discover_pods_presenter.dart';
import 'package:picnic_app/features/discover/discover_search_results/discover_search_results_initial_params.dart';
import 'package:picnic_app/features/discover/discover_search_results/discover_search_results_navigator.dart';
import 'package:picnic_app/features/discover/discover_search_results/discover_search_results_page.dart';
import 'package:picnic_app/features/discover/discover_search_results/discover_search_results_presentation_model.dart';
import 'package:picnic_app/features/discover/discover_search_results/discover_search_results_presenter.dart';
import 'package:picnic_app/features/discover/domain/repositories/discover_repository.dart';
import "package:picnic_app/features/discover/domain/use_cases/discover_use_case.dart";
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
        ..registerFactory<DiscoverRepository>(
          () => GqlDiscoverRepository(
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
        ..registerFactory<DiscoverUseCase>(
          () => DiscoverUseCase(
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
        ..registerFactory<DiscoverSearchResultsNavigator>(
          () => DiscoverSearchResultsNavigator(
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<DiscoverSearchResultsPresentationModel, DiscoverSearchResultsInitialParams, dynamic>(
          (params, _) => DiscoverSearchResultsPresentationModel.initial(params, getIt()),
        )
        ..registerFactoryParam<DiscoverSearchResultsPresenter, DiscoverSearchResultsInitialParams, dynamic>(
          (initialParams, _) => DiscoverSearchResultsPresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<DiscoverSearchResultsPage, DiscoverSearchResultsInitialParams, dynamic>(
          (initialParams, _) => DiscoverSearchResultsPage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<DiscoverExploreNavigator>(
          () => DiscoverExploreNavigator(
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<DiscoverExplorePresentationModel, DiscoverExploreInitialParams, dynamic>(
          (params, _) => DiscoverExplorePresentationModel.initial(
            params,
            getIt(),
          ),
        )
        ..registerFactoryParam<DiscoverExplorePresenter, DiscoverExploreInitialParams, dynamic>(
          (initialParams, _) => DiscoverExplorePresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<DiscoverExplorePage, DiscoverExploreInitialParams, dynamic>(
          (initialParams, _) => DiscoverExplorePage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<DiscoverPodsNavigator>(
          () => DiscoverPodsNavigator(
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<DiscoverPodsPresentationModel, DiscoverPodsInitialParams, dynamic>(
          (params, _) => DiscoverPodsPresentationModel.initial(
            params,
          ),
        )
        ..registerFactoryParam<DiscoverPodsPresenter, DiscoverPodsInitialParams, dynamic>(
          (initialParams, _) => DiscoverPodsPresenter(
            getIt(param1: initialParams),
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
        ..registerFactoryParam<DiscoverPodsPage, DiscoverPodsInitialParams, dynamic>(
          (initialParams, _) => DiscoverPodsPage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<DiscoverCirclesNavigator>(
          () => DiscoverCirclesNavigator(
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<DiscoverCirclesPresentationModel, DiscoverCirclesInitialParams, dynamic>(
          (params, _) => DiscoverCirclesPresentationModel.initial(
            params,
          ),
        )
        ..registerFactoryParam<DiscoverCirclesPresenter, DiscoverCirclesInitialParams, dynamic>(
          (initialParams, _) => DiscoverCirclesPresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<DiscoverCirclesPage, DiscoverCirclesInitialParams, dynamic>(
          (initialParams, _) => DiscoverCirclesPage(
            presenter: getIt(param1: initialParams),
          ),
        )

      //DO-NOT-REMOVE MVP_GET_IT_CONFIG

      ;
}
