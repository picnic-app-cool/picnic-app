import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/circle_details/circle_details_navigator.dart';
import 'package:picnic_app/features/main/main_navigator.dart';
import 'package:picnic_app/features/posts/choose_media/choose_media_navigator.dart';
import 'package:picnic_app/features/posts/select_circle/select_circle_navigator.dart';
import 'package:picnic_app/features/posts/upload_media/upload_media_initial_params.dart';
import 'package:picnic_app/features/posts/upload_media/upload_media_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';
import 'package:picnic_app/navigation/confirmation_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/get_video_route.dart';

class UploadMediaNavigator
    with
        SelectCircleRoute,
        ChooseMediaRoute,
        ConfirmationBottomSheetRoute,
        GetVideoRoute,
        MainRoute,
        CloseRoute,
        CircleDetailsRoute {
  UploadMediaNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin UploadMediaRoute {
  Future<void> openUploadMedia(UploadMediaInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<UploadMediaPage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
