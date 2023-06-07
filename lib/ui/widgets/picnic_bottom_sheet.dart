import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

//ignore: long-parameter-list
Future<T?> showPicnicBottomSheet<T>(
  Widget child, {
  bool useRootNavigator = false,
  bool isDismissible = true,
  bool enableDrag = true,
  bool showHandler = false,
}) async {
  final currentContext = AppNavigator.currentContext;
  return showModalBottomSheet(
    useRootNavigator: useRootNavigator,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(16),
        topLeft: Radius.circular(16),
      ),
    ),
    backgroundColor: PicnicTheme.of(currentContext).colors.blackAndWhite.shade100,
    isScrollControlled: true,
    context: currentContext,
    builder: (context) {
      if (showHandler) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Gap(12),
            Image.asset(
              Assets.images.bottomSheetHandler.path,
            ),
            child,
          ],
        );
      }
      return child;
    },
    isDismissible: isDismissible,
    enableDrag: enableDrag,
  );
}
