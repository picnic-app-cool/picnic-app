import 'package:picnic_app/features/posts/post_share/post_share_initial_params.dart';
import 'package:picnic_app/features/posts/post_share/post_share_page.dart';
import 'package:picnic_app/features/reports/report_form/report_form_navigator.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/share_route.dart';
import 'package:picnic_app/ui/widgets/picnic_bottom_sheet.dart';

//ignore_for_file: unused-code
class PostShareNavigator with ReportFormRoute, ShareRoute {
  PostShareNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin PostShareRoute {
  Future<void> openPostShare(PostShareInitialParams initialParams) async {
    return showPicnicBottomSheet(
      PostSharePage(initialParams: initialParams),
      useRootNavigator: true,
      isDismissible: true,
      enableDrag: true,
      showHandler: true,
    );
  }

  AppNavigator get appNavigator;
}
