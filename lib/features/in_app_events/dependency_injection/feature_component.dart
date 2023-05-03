import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/in_app_events/domain/use_cases/add_in_app_notifications_filter_use_case.dart';
import "package:picnic_app/features/in_app_events/domain/use_cases/get_in_app_notifications_use_case.dart";
import 'package:picnic_app/features/in_app_events/domain/use_cases/remove_in_app_notifications_filter_use_case.dart';
import 'package:picnic_app/features/in_app_events/domain/use_cases/toggle_in_app_notifications_use_case.dart';
import 'package:picnic_app/features/in_app_events/notifications/notifications_navigator.dart';
import 'package:picnic_app/features/in_app_events/notifications/notifications_presenter.dart';
import 'package:picnic_app/features/in_app_events/unread_chats/unread_chats_presenter.dart';
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
        ..registerFactory<GetInAppNotificationsUseCase>(
          () => GetInAppNotificationsUseCase(getIt()),
        )
        ..registerFactory<AddInAppNotificationsFilterUseCase>(
          () => AddInAppNotificationsFilterUseCase(getIt()),
        )
        ..registerFactory<RemoveInAppNotificationsFilterUseCase>(
          () => RemoveInAppNotificationsFilterUseCase(getIt()),
        )
        ..registerFactory<ToggleInAppNotificationsUseCase>(
          () => ToggleInAppNotificationsUseCase(getIt()),
        )

//DO-NOT-REMOVE USE_CASES_GET_IT_CONFIG
      ;
}

//ignore: long-method
void _configureMvp() {
  // ignore: unnecessary_statements
  getIt
        ..registerFactory<NotificationsNavigator>(
          () => NotificationsNavigator(),
        )
        ..registerFactory<NotificationsPresenter>(
          () => NotificationsPresenter(
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
        ..registerFactory<UnreadChatsPresenter>(
          () => UnreadChatsPresenter(
            getIt(),
            getIt(),
          ),
        )
//DO-NOT-REMOVE MVP_GET_IT_CONFIG
      ;
}
