import 'package:picnic_app/features/push_notifications/send_push_notification/send_push_notification_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class SendPushNotificationPresentationModel implements SendPushNotificationViewModel {
  /// Creates the initial state
  SendPushNotificationPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    SendPushNotificationInitialParams initialParams,
  );

  /// Used for the copyWith method
  SendPushNotificationPresentationModel._();

  SendPushNotificationPresentationModel copyWith() {
    return SendPushNotificationPresentationModel._();
  }
}

/// Interface to expose fields used by the view (page).
abstract class SendPushNotificationViewModel {}
