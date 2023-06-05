import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/pods/domain/use_cases/get_pods_tags_use_case.dart';
import 'package:picnic_app/features/pods/domain/use_cases/get_saved_pods_use_case.dart';
import 'package:picnic_app/features/pods/domain/use_cases/save_pod_use_case.dart';
import 'package:picnic_app/features/pods/pod_bottom_sheet_initial_params.dart';
import 'package:picnic_app/features/pods/pod_bottom_sheet_navigator.dart';
import 'package:picnic_app/features/pods/pod_bottom_sheet_page.dart';
import 'package:picnic_app/features/pods/pod_bottom_sheet_presentation_model.dart';
import 'package:picnic_app/features/pods/pod_bottom_sheet_presenter.dart';
import 'package:picnic_app/features/pods/pods_categories_initial_params.dart';
import 'package:picnic_app/features/pods/pods_categories_navigator.dart';
import 'package:picnic_app/features/pods/pods_categories_presentation_model.dart';
import 'package:picnic_app/features/pods/pods_categories_presenter.dart';

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
//DO-NOT-REMOVE REPOSITORIES_GET_IT_CONFIG
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
        ..registerFactory<GetPodsTagsUseCase>(
          () => GetPodsTagsUseCase(
            getIt(),
          ),
        )
        ..registerFactory<SavePodUseCase>(
          () => SavePodUseCase(
            getIt(),
          ),
        )
        ..registerFactory<GetSavedPodsUseCase>(
          () => GetSavedPodsUseCase(
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
        ..registerFactory<PodsCategoriesNavigator>(
          () => PodsCategoriesNavigator(getIt()),
        )
        ..registerFactoryParam<PodsCategoriesViewModel, PodsCategoriesInitialParams, dynamic>(
          (params, _) => PodsCategoriesPresentationModel.initial(params),
        )
        ..registerFactoryParam<PodsCategoriesPresenter, PodsCategoriesInitialParams, dynamic>(
          (params, _) => PodsCategoriesPresenter(
            getIt(param1: params),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<PodBottomSheetViewModel, PodBottomSheetInitialParams, dynamic>(
          (params, _) => PodBottomSheetPresentationModel.initial(params),
        )
        ..registerFactoryParam<PodBottomSheetPage, PodBottomSheetInitialParams, dynamic>(
          (initialParams, _) => PodBottomSheetPage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<PodBottomSheetNavigator>(
          () => PodBottomSheetNavigator(
            getIt(),
          ),
        )
        ..registerFactoryParam<PodBottomSheetPresentationModel, PodBottomSheetInitialParams, dynamic>(
          (params, _) => PodBottomSheetPresentationModel.initial(
            params,
          ),
        )
        ..registerFactoryParam<PodBottomSheetPresenter, PodBottomSheetInitialParams, dynamic>(
          (initialParams, _) => PodBottomSheetPresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )

//DO-NOT-REMOVE MVP_GET_IT_CONFIG
      ;
}
