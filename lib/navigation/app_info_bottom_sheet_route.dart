import 'package:picnic_app/core/domain/model/app_info.dart';
import 'package:picnic_app/core/utils/utils.dart';
import 'package:picnic_app/features/settings/widgets/app_info_bottom_sheet.dart';
import 'package:picnic_app/ui/widgets/picnic_bottom_sheet.dart';

mixin AppInfoBottomSheetRoute {
  void showAppInfoBottomSheet({
    required AppInfo appInfo,
    required VoidCallback onTapClose,
  }) =>
      showPicnicBottomSheet(
        AppInfoBottomSheet(
          appInfo: appInfo,
          onTapClose: onTapClose,
        ),
      );
}
