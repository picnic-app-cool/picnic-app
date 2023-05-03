import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/video_editor/video_editor_initial_params.dart';
import 'package:picnic_app/features/video_editor/video_editor_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/video_editor_route.dart' as editor;

/// TODO: This whole feature will be removed and [editor.VideoEditorRoute] will be directly integrated into the
/// respective feature
class VideoEditorNavigator with editor.VideoEditorRoute {
  VideoEditorNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin VideoEditorRoute {
  Future<void> openVideoEditor(VideoEditorInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<VideoEditorPage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
