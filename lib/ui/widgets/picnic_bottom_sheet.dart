import 'package:flutter/material.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

Future<T?> showPicnicBottomSheet<T>(
  Widget child, {
  bool useRootNavigator = false,
  bool isDismissible = true,
  bool enableDrag = true,
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
    builder: (context) => child,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
  );
}
