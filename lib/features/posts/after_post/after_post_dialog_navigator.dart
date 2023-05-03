import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/posts/after_post/after_post_dialog_initial_params.dart';
import 'package:picnic_app/features/posts/after_post/after_post_dialog_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/share_route.dart';

class AfterPostDialogNavigator with CloseRoute, ErrorBottomSheetRoute, ShareRoute {
  AfterPostDialogNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin AfterPostModalRoute {
  Future<void> openAfterPostModal(AfterPostDialogInitialParams initialParams) async {
    return appNavigator.push(
      fadeInRoute(
        getIt<AfterPostDialogPage>(param1: initialParams),
        opaque: false,
        fullScreenDialog: true,
      ),
    );
  }

  AppNavigator get appNavigator;
}
