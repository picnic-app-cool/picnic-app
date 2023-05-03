import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/features/chat/domain/model/message_action_result/pop_up_menu_item.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

//ignore_for_file: unused-code, unused-files
/// Picnic popup menu isn't a widget is a helper class to show customizable popup menu.
/// [context] required to show menu/
/// [onTapItem] listener on item tap, returns the key as the argument of function.
class PicnicPopupMenu {
  PicnicPopupMenu({
    required this.context,
    required this.onTapItem,
  }) {
    final theme = PicnicTheme.of(context);
    _darkBlue = theme.colors.darkBlue;
    _textStyle = theme.styles.body20.copyWith(
      color: _darkBlue,
    );
  }

  final BuildContext context;
  final Function(PopUpMenuItem) onTapItem;

  late final TextStyle _textStyle;
  late final MaterialColor _darkBlue;

  static const _iconSize = 16.0;
  static const _elevation = 8.0;
  static const _radius = 16.0;

  /// Show the popup menu with the given [offset]
  /// The [offset] is responsible for determine position of the screen where menu should show up
  /// To get the [offset] the widget on which tap should show menu must be wrapped by [GestureDetector]
  /// Example:
  ///  GestureDetector(
  ///        onLongPressDown: (longPressDownDetails) {
  ///          popupMenu.show(longPressDownDetails.globalPosition);
  ///        },
  //ignore: long-method
  Future<void> show(Offset offset) async {
    final left = offset.dx;
    final top = offset.dy;

    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        left,
        top,
        0,
        0,
      ),
      items: PopUpMenuItem.values
          .map(
            (PopUpMenuItem menuItemType) => PopupMenuItem(
              value: menuItemType,
              textStyle: _textStyle,
              onTap: () => onTapAction(menuItemType),
              child: Row(
                children: [
                  Image.asset(
                    menuItemType.icon,
                    width: _iconSize,
                    height: _iconSize,
                    color: _darkBlue,
                  ),
                  const Gap(10),
                  Text(menuItemType.label),
                ],
              ),
            ),
          )
          .toList(),
      elevation: _elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_radius),
      ),
    );
  }

  void onTapAction(PopUpMenuItem menuItemType) {
    Future<void>(
      () => onTapItem.call(menuItemType),
    );
  }
}
