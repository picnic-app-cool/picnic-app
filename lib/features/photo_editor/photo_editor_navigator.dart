import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/image_picker/image_picker_navigator.dart';
import 'package:picnic_app/features/photo_editor/photo_editor_initial_params.dart';
import 'package:picnic_app/features/photo_editor/photo_editor_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/image_editor_route.dart';

class PhotoEditorNavigator with ImagePickerRoute, ImageEditorRoute {
  PhotoEditorNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin PhotoEditorRoute {
  Future<void> openPhotoEditor(PhotoEditorInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<PhotoEditorPage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
