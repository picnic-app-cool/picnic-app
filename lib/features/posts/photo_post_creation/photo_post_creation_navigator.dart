import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/posts/choose_media/choose_media_navigator.dart';
import 'package:picnic_app/features/posts/photo_post_creation/photo_post_creation_initial_params.dart';
import 'package:picnic_app/features/posts/photo_post_creation/photo_post_creation_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/get_image_route.dart';
import 'package:picnic_app/navigation/no_access_to_gallery_route.dart';

class PhotoPostCreationNavigator
    with PhotoPostCreationRoute, GetImageRoute, ChooseMediaRoute, ErrorBottomSheetRoute, NoAccessToGalleryRoute {
  PhotoPostCreationNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin PhotoPostCreationRoute {
  Future<void> openPhotoPostCreation(
    PhotoPostCreationInitialParams initialParams,
  ) async {
    return appNavigator.push(
      materialRoute(getIt<PhotoPostCreationPage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
