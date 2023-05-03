import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/push_notifications/data/device_token_updates_listener_container.dart';
import 'package:picnic_app/features/push_notifications/data/firebase_messaging_wrapper.dart';
import "package:picnic_app/features/push_notifications/domain/model/update_device_token_failure.dart";
import 'package:picnic_app/features/push_notifications/domain/repositories/push_notification_repository.dart';
import 'package:picnic_app/features/push_notifications/domain/use_cases/get_push_notifications_use_case.dart';
import "package:picnic_app/features/push_notifications/domain/use_cases/listen_device_token_updates_use_case.dart";
import "package:picnic_app/features/push_notifications/domain/use_cases/update_device_token_use_case.dart";
import 'package:picnic_app/features/push_notifications/send_push_notification/send_push_notification_initial_params.dart';
import 'package:picnic_app/features/push_notifications/send_push_notification/send_push_notification_navigator.dart';
import 'package:picnic_app/features/push_notifications/send_push_notification/send_push_notification_presentation_model.dart';
import 'package:picnic_app/features/push_notifications/send_push_notification/send_push_notification_presenter.dart';

//DO-NOT-REMOVE IMPORTS_MOCK_DEFINITIONS

// MVP

class MockSendPushNotificationPresenter extends MockCubit<SendPushNotificationViewModel>
    implements SendPushNotificationPresenter {}

class MockSendPushNotificationPresentationModel extends Mock implements SendPushNotificationPresentationModel {}

class MockSendPushNotificationInitialParams extends Mock implements SendPushNotificationInitialParams {}

class MockSendPushNotificationNavigator extends Mock implements SendPushNotificationNavigator {}
//DO-NOT-REMOVE MVP_MOCK_DEFINITION

// USE CASES
class MockUpdateDeviceTokenFailure extends Mock implements UpdateDeviceTokenFailure {}

class MockUpdateDeviceTokenUseCase extends Mock implements UpdateDeviceTokenUseCase {}

class MockListenDeviceTokenUpdatesUseCase extends Mock implements ListenDeviceTokenUpdatesUseCase {}

class MockGetPushNotificationsUseCase extends Mock implements GetPushNotificationsUseCase {}

//DO-NOT-REMOVE USE_CASE_MOCK_DEFINITION

// REPOSITORIES
class MockPushNotificationRepository extends Mock implements PushNotificationRepository {}

class MockFirebaseMessagingWrapper extends Mock implements FirebaseMessagingWrapper {}
//DO-NOT-REMOVE REPOSITORIES_MOCK_DEFINITION

// STORES
//DO-NOT-REMOVE STORES_MOCK_DEFINITION

class MockDeviceTokenUpdatesListenerContainer extends Mock implements DeviceTokenUpdatesListenerContainer {}
