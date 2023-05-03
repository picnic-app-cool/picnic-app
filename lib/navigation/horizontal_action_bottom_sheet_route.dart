import 'package:flutter/widgets.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/ui/widgets/buttom_sheet/picnic_horizontal_action_bottom_sheet.dart';
import 'package:picnic_app/ui/widgets/picnic_bottom_sheet.dart';

mixin HorizontalActionBottomSheetRoute {
  //ignore: long-parameter-list
  void showHorizontalActionBottomSheet({
    required List<ActionBottom> actions,
    required VoidCallback onTapClose,
    String? title,
    User? user,
  }) {
    showPicnicBottomSheet(
      PicnicHorizontalActionBottomSheet(
        onTapClose: onTapClose,
        actions: actions,
        title: title,
        user: user,
      ),
    );
  }
}

class ActionBottom {
  ActionBottom({
    required this.label,
    required this.action,
    this.icon,
    this.isPrimary = false,
  });

  final String label;
  final String? icon;
  final VoidCallback action;
  final bool isPrimary;
}
