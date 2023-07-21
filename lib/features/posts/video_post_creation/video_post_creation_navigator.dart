import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/create_circle/create_circle/create_circle_navigator.dart';
import 'package:picnic_app/features/posts/video_post_creation/video_post_creation_initial_params.dart';
import 'package:picnic_app/features/posts/video_post_creation/video_post_creation_page.dart';
import 'package:picnic_app/features/posts/video_post_recording/video_post_recording_navigator.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/get_video_route.dart';
import 'package:picnic_app/navigation/no_access_to_gallery_route.dart';

class VideoPostCreationNavigator
    with CreateCircleRoute, VideoPostRecordingRoute, GetVideoRoute, ErrorBottomSheetRoute, NoAccessToGalleryRoute {
  VideoPostCreationNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin VideoPostCreationRoute {
  Future<void> openVideoPostCreation(VideoPostCreationInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<VideoPostCreationPage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
