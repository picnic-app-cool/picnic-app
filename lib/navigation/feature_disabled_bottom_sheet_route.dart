import 'package:picnic_app/core/utils/utils.dart';
import 'package:picnic_app/features/posts/select_circle/widgets/feature_disabled_bottom_sheet.dart';
import 'package:picnic_app/ui/widgets/picnic_bottom_sheet.dart';

mixin FeatureDisabledBottomSheetRoute {
  Future<void> showDisabledBottomSheet({
    required String title,
    required String description,
    required VoidCallback onTapClose,
  }) =>
      showPicnicBottomSheet(
        FeatureDisabledBottomSheet(
          title: title,
          description: description,
          onTapClose: onTapClose,
        ),
      );
}
