import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/profile/notifications/notifications_list_initial_params.dart';
import 'package:picnic_app/features/profile/notifications/notifications_list_page.dart';
import 'package:picnic_app/features/profile/notifications/widgets/post_removed_bottom_sheet.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/ui/widgets/picnic_bottom_sheet.dart';

class NotificationsListNavigator with ErrorBottomSheetRoute, PostRemovedBottomSheetRoute {
  NotificationsListNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin NotificationsListRoute {
  Future<void> openNotifications(NotificationsListInitialParams initialParams) => appNavigator.push(
        materialRoute(
          getIt<NotificationsListPage>(
            param1: initialParams,
          ),
        ),
        useRoot: true,
      );

  AppNavigator get appNavigator;
}

mixin PostRemovedBottomSheetRoute {
  Future<bool?> openPostRemovedBottomSheet() => showPicnicBottomSheet<bool?>(
        useRootNavigator: true,
        const PostRemovedBottomSheet(),
      );

  AppNavigator get appNavigator;
}
