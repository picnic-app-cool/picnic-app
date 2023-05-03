import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/avatar_selection/avatar_selection_navigator.dart';
import 'package:picnic_app/features/create_slice/presentation/create_slice_initial_params.dart';
import 'package:picnic_app/features/create_slice/presentation/create_slice_page.dart';
import 'package:picnic_app/features/image_picker/image_picker_navigator.dart';
import 'package:picnic_app/features/slices/slice_details/slice_details_navigator.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';
import 'package:picnic_app/navigation/close_with_result_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/image_editor_route.dart';

//ignore_for_file: unused-code, unused-files
class CreateSliceNavigator
    with
        AvatarSelectionRoute,
        ErrorBottomSheetRoute,
        ImagePickerRoute,
        ImageEditorRoute,
        CloseRoute,
        SliceDetailsRoute,
        CloseWithResultRoute<bool> {
  CreateSliceNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin CreateSliceRoute {
  Future<bool?> openCreateSlice(CreateSliceInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<CreateSlicePage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
