import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/push_notifications/data/device_token_updates_listener_container.dart';
import 'package:picnic_app/features/push_notifications/data/fcm_graphql_push_notification_repository.dart';
import 'package:picnic_app/features/push_notifications/data/firebase_messaging_wrapper.dart';
import 'package:picnic_app/features/push_notifications/domain/repositories/push_notification_repository.dart';
import 'package:picnic_app/features/push_notifications/domain/use_cases/get_push_notifications_use_case.dart';
import 'package:picnic_app/features/push_notifications/domain/use_cases/listen_device_token_updates_use_case.dart';
import "package:picnic_app/features/push_notifications/domain/use_cases/update_device_token_use_case.dart";
import 'package:picnic_app/features/push_notifications/send_push_notification/send_push_notification_initial_params.dart';
import 'package:picnic_app/features/push_notifications/send_push_notification/send_push_notification_navigator.dart';
import 'package:picnic_app/features/push_notifications/send_push_notification/send_push_notification_page.dart';
import 'package:picnic_app/features/push_notifications/send_push_notification/send_push_notification_presentation_model.dart';
import 'package:picnic_app/features/push_notifications/send_push_notification/send_push_notification_presenter.dart';
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
        ..registerFactory(() => FirebaseMessagingWrapper(getIt()))
        ..registerFactory(() => DeviceTokenUpdatesListenerContainer(getIt()))
        ..registerLazySingleton<PushNotificationRepository>(
          () => FcmGraphqlPushNotificationRepository(
            getIt(),
            getIt(),
            getIt(),
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
        ..registerFactory<UpdateDeviceTokenUseCase>(
          () => UpdateDeviceTokenUseCase(
            getIt(),
            getIt(),
          ),
        )
        ..registerFactory<ListenDeviceTokenUpdatesUseCase>(
          () => ListenDeviceTokenUpdatesUseCase(
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactory<GetPushNotificationsUseCase>(
          () => GetPushNotificationsUseCase(
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
        ..registerFactory<SendPushNotificationNavigator>(
          () => SendPushNotificationNavigator(getIt()),
        )
        ..registerFactoryParam<SendPushNotificationPresentationModel, SendPushNotificationInitialParams, dynamic>(
          (params, _) => SendPushNotificationPresentationModel.initial(params),
        )
        ..registerFactoryParam<SendPushNotificationPresenter, SendPushNotificationInitialParams, dynamic>(
          (initialParams, _) => SendPushNotificationPresenter(
            getIt(param1: initialParams),
            getIt(),
          ),
        )
        ..registerFactoryParam<SendPushNotificationPage, SendPushNotificationInitialParams, dynamic>(
          (initialParams, _) => SendPushNotificationPage(
            presenter: getIt(param1: initialParams),
          ),
        )
      //DO-NOT-REMOVE MVP_GET_IT_CONFIG

      ;
}
