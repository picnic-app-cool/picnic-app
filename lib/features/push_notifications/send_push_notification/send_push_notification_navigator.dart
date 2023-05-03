import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/push_notifications/send_push_notification/send_push_notification_initial_params.dart';
import 'package:picnic_app/features/push_notifications/send_push_notification/send_push_notification_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_with_result_route.dart';
import 'package:picnic_app/ui/widgets/picnic_bottom_sheet.dart';

class SendPushNotificationNavigator with CloseWithResultRoute<bool> {
  SendPushNotificationNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin SendPushNotificationRoute {
  /// `true` means the push notification has been sent, `false` or `null` means the user has either tapped close button
  /// or dismissed the bottom sheet
  Future<bool?> openSendPushNotification(SendPushNotificationInitialParams initialParams) => showPicnicBottomSheet(
        getIt<SendPushNotificationPage>(param1: initialParams),
      );

  AppNavigator get appNavigator;
}
