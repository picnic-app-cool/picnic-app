import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/settings/notification_settings/notification_settings_initial_params.dart';
import 'package:picnic_app/features/settings/notification_settings/notification_settings_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';

class NotificationSettingsNavigator with CloseRoute, ErrorBottomSheetRoute {
  NotificationSettingsNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin NotificationSettingsRoute {
  void openNotificationSettings(
    NotificationSettingsInitialParams initialParams,
  ) {
    appNavigator.push(
      materialRoute(getIt<NotificationSettingsPage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
