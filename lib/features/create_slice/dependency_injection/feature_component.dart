import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/create_slice/data/graphql_slice_creation_repository.dart';
import 'package:picnic_app/features/create_slice/domain/repositories/slice_creation_repository.dart';
import 'package:picnic_app/features/create_slice/domain/usecases/create_slice_use_case.dart';
import 'package:picnic_app/features/create_slice/presentation/create_slice_initial_params.dart';
import 'package:picnic_app/features/create_slice/presentation/create_slice_navigator.dart';
import 'package:picnic_app/features/create_slice/presentation/create_slice_page.dart';
import 'package:picnic_app/features/create_slice/presentation/create_slice_presentation_model.dart';
import 'package:picnic_app/features/create_slice/presentation/create_slice_presenter.dart';
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
        ..registerFactory<SliceCreationRepository>(
          () => GraphqlSliceCreationRepository(
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
        ..registerFactory<CreateSliceUseCase>(
          () => CreateSliceUseCase(
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
        ..registerFactoryParam<CreateSlicePage, CreateSliceInitialParams, dynamic>(
          (initialParams, _) => CreateSlicePage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactoryParam<CreateSlicePresenter, CreateSliceInitialParams, dynamic>(
          (initialParams, _) => CreateSlicePresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactory<CreateSliceNavigator>(
          () => CreateSliceNavigator(getIt()),
        )
        ..registerFactoryParam<CreateSlicePresentationModel, CreateSliceInitialParams, dynamic>(
          (params, _) => CreateSlicePresentationModel.initial(
            params,
          ),
        )
//DO-NOT-REMOVE MVP_GET_IT_CONFIG
      ;
}
