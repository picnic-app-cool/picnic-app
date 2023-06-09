import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/pod_app.dart';
import 'package:picnic_app/core/utils/utils.dart';
import 'package:picnic_app/features/pods/previewPod/widgets/enable_pod_success.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/ui/widgets/picnic_bottom_sheet.dart';

mixin EnablePodSuccessBottomSheetRoute {
  Future<void> showPodEnabledSuccessfullyBottomSheet({
    required Circle circle,
    required PodApp pod,
    required VoidCallback onTapLaunch,
  }) async {
    return showPicnicBottomSheet(
      EnablePodSuccess(
        pod: pod,
        circle: circle,
        onTapLaunch: onTapLaunch,
      ),
    );
  }

  AppNavigator get appNavigator;
}
