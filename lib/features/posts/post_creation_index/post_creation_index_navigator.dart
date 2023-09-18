import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/circle_details/circle_details_navigator.dart';
import 'package:picnic_app/features/main/main_navigator.dart';
import 'package:picnic_app/features/posts/link_post_creation/link_post_creation_navigator.dart';
import 'package:picnic_app/features/posts/photo_post_creation/photo_post_creation_navigator.dart';
import 'package:picnic_app/features/posts/poll_post_creation/poll_post_creation_navigator.dart';
import 'package:picnic_app/features/posts/post_creation_index/post_creation_index_initial_params.dart';
import 'package:picnic_app/features/posts/post_creation_index/post_creation_index_page.dart';
import 'package:picnic_app/features/posts/select_circle/select_circle_navigator.dart';
import 'package:picnic_app/features/posts/text_post_creation/text_post_creation_navigator.dart';
import 'package:picnic_app/features/posts/upload_media/upload_media_navigator.dart';
import 'package:picnic_app/features/posts/video_post_creation/video_post_creation_navigator.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';

class PostCreationIndexNavigator
    with
        MainRoute,
        TextPostCreationRoute,
        LinkPostCreationRoute,
        PollPostCreationRoute,
        VideoPostCreationRoute,
        PhotoPostCreationRoute,
        UploadMediaRoute,
        SelectCircleRoute,
        ErrorBottomSheetRoute,
        CircleDetailsRoute {
  PostCreationIndexNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin PostCreationIndexRoute {
  Future<void> openPostCreation(
    PostCreationIndexInitialParams initialParams, {
    bool useRoot = true,
  }) async {
    return appNavigator.push(
      slideBottomRoute(getIt<PostCreationIndexPage>(param1: initialParams)),
      useRoot: useRoot,
    );
  }

  AppNavigator get appNavigator;
}
