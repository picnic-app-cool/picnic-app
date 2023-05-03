import 'package:get_it/get_it.dart';
import 'package:picnic_app/core/data/firebase/actions/firebase_actions_factory.dart';
import 'package:picnic_app/core/domain/repositories/runtime_permissions_repository.dart';
import 'package:picnic_app/core/domain/stores/app_info_store.dart';
import 'package:picnic_desktop_app/core/data/desktop_launch_at_startup_repository.dart';
import 'package:picnic_desktop_app/core/data/desktop_runtime_permissions_repository.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_desktop_app/core/data/firebase/actions/desktop_firebase_actions_factory.dart';
import 'package:picnic_desktop_app/core/domain/repositories/launch_at_startup_repository.dart';
import 'package:picnic_desktop_app/core/domain/use_cases/enable_launch_at_startup_use_case.dart';
import 'package:picnic_desktop_app/features/main/dependency_injection/feature_component.dart' as main;
import 'package:picnic_desktop_app/features/app_init/dependency_injection/feature_component.dart' as app_init;
import 'package:picnic_desktop_app/features/onboarding/dependency_injection/feature_component.dart' as onboarding;
import 'package:picnic_desktop_app/features/profile/dependency_injection/feature_component.dart' as profile;
import 'package:picnic_desktop_app/features/image_picker/dependency_injection/feature_component.dart' as image_picker;
import 'package:picnic_desktop_app/features/media_picker/dependency_injection/feature_component.dart' as media_picker;
//DO-NOT-REMOVE APP_COMPONENT_IMPORTS

final getIt = GetIt.instance;

/// registers all the dependencies in dependency graph in get_it package
void configureDependencies() {
  getIt.allowReassignment = true;
  app_init.configureDependencies();
  main.configureDependencies();
  onboarding.configureDependencies();
  profile.configureDependencies();
  image_picker.configureDependencies();
  media_picker.configureDependencies();
//DO-NOT-REMOVE FEATURE_COMPONENT_INIT
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
        ..registerFactory<AppNavigator>(
          () => AppNavigator(),
        )
      //DO-NOT-REMOVE GENERAL_DEPS_GET_IT_CONFIG
      ;
}

//ignore: long-method
void _configureRepositories() {
  // ignore: unnecessary_statements
  getIt
        ..registerFactory<FirebaseActionsFactory>(
          () => DesktopFirebaseActionsFactory(
            getIt(),
          ),
        )
        ..registerFactory<RuntimePermissionsRepository>(
          () => DesktopRuntimePermissionsRepository(),
        )
        ..registerFactory<LaunchAtStartupRepository>(
          () => const DesktopLaunchAtStartupRepository(),
        )
//DO-NOT-REMOVE REPOSITORIES_GET_IT_CONFIG
      ;
}

//ignore: long-method
void _configureStores() {
  // ignore: unnecessary_statements
  getIt
        ..registerLazySingleton<UserStore>(
          () => UserStore(),
        )
        ..registerLazySingleton<AppInfoStore>(
          () => AppInfoStore(),
        )
      //DO-NOT-REMOVE STORES_GET_IT_CONFIG
      ;
}

//ignore: long-method
void _configureUseCases() {
  // ignore: unnecessary_statements
  getIt
        ..registerFactory<EnableLaunchAtStartupUseCase>(
          () => EnableLaunchAtStartupUseCase(
            getIt(),
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
      //DO-NOT-REMOVE MVP_GET_IT_CONFIG
      ;
}
