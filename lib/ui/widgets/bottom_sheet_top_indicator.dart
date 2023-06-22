import 'package:flutter/cupertino.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class BottomSheetTopIndicator extends StatelessWidget {
  static const bottomSheetTopDividerHeight = 6.0;
  static const bottomSheetTopDividerWidth = 40.0;
  static const bottomSheetTopDividerRadius = 100.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: bottomSheetTopDividerHeight,
      width: bottomSheetTopDividerWidth,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(bottomSheetTopDividerRadius)),
        color: PicnicTheme.of(context).colors.darkBlue.shade300,
      ),
    );
  }
}
