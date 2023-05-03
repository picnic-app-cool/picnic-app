import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/posts/video_post_recording/video_post_recording_initial_params.dart';
import 'package:picnic_app/features/posts/video_post_recording/video_post_recording_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_with_result_route.dart';

class VideoPostRecordingNavigator with CloseWithResultRoute<String?> {
  VideoPostRecordingNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin VideoPostRecordingRoute {
  Future<String?> openVideoPostRecording(VideoPostRecordingInitialParams initialParams) async {
    return appNavigator.push(
      fadeInRoute(getIt<VideoPostRecordingPage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
