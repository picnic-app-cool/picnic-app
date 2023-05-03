import 'package:flutter/widgets.dart';
import 'package:picnic_app/navigation/horizontal_action_bottom_sheet_route.dart';
import 'package:picnic_app/ui/widgets/buttom_sheet/picnic_vertical_action_bottom_sheet.dart';
import 'package:picnic_app/ui/widgets/picnic_bottom_sheet.dart';

mixin VerticalActionBottomSheetRoute {
  //ignore: long-parameter-list
  void showVerticalActionBottomSheet({
    required List<ActionBottom> actions,
    required VoidCallback onTapClose,
    String? title,
    String? description,
  }) {
    showPicnicBottomSheet(
      PicnicVerticalActionBottomSheet(
        onTapClose: onTapClose,
        actions: actions,
        title: title,
        description: description,
      ),
    );
  }
}
