import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/avatar_selection/avatar_selection_initial_params.dart';
import 'package:picnic_app/features/avatar_selection/avatar_selection_navigator.dart';
import 'package:picnic_app/features/avatar_selection/avatar_selection_page.dart';
import 'package:picnic_app/features/avatar_selection/avatar_selection_presentation_model.dart';
import 'package:picnic_app/features/avatar_selection/avatar_selection_presenter.dart';
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
        ..registerFactory<AvatarSelectionNavigator>(
          () => AvatarSelectionNavigator(getIt()),
        )
        ..registerFactoryParam<AvatarSelectionPresentationModel, AvatarSelectionInitialParams, dynamic>(
          (params, _) => AvatarSelectionPresentationModel.initial(params),
        )
        ..registerFactoryParam<AvatarSelectionPresenter, AvatarSelectionInitialParams, dynamic>(
          (initialParams, _) => AvatarSelectionPresenter(
            getIt(param1: initialParams),
            getIt(),
          ),
        )
        ..registerFactoryParam<AvatarSelectionPage, AvatarSelectionInitialParams, dynamic>(
          (initialParams, _) => AvatarSelectionPage(
            presenter: getIt(param1: initialParams),
          ),
        )
      //DO-NOT-REMOVE MVP_GET_IT_CONFIG

      ;
}
