import 'package:picnic_app/core/domain/model/pod_app.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/add_circle_pod/add_circle_pod_navigator.dart';
import 'package:picnic_app/features/pods/pod_bottom_sheet_initial_params.dart';
import 'package:picnic_app/features/pods/pod_bottom_sheet_page.dart';
import 'package:picnic_app/features/profile/public_profile/public_profile_navigator.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_with_result_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/ui/widgets/picnic_bottom_sheet.dart';

class PodBottomSheetNavigator
    with PublicProfileRoute, ErrorBottomSheetRoute, AddCirclePodRoute, CloseWithResultRoute<PodApp> {
  PodBottomSheetNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin PodBottomSheetRoute {
  Future<PodApp?> openPodBottomSheet(PodBottomSheetInitialParams initialParams) async {
    return showPicnicBottomSheet(
      getIt<PodBottomSheetPage>(param1: initialParams),
      useRootNavigator: true,
    );
  }

  AppNavigator get appNavigator;
}
