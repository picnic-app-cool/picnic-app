import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/features/chat/domain/model/message_action_result/pop_up_menu_item.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class MessageDefaultPopup extends StatelessWidget {
  const MessageDefaultPopup({
    required this.menuItems,
    required this.onTapMenuItem,
    super.key,
  });

  final List<PopUpMenuItem> menuItems;
  final ValueChanged<PopUpMenuItem> onTapMenuItem;

  static const _popupContainerRadius = 20.0;
  static const _iconSize = 16.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final _textStyle = theme.styles.body20;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_popupContainerRadius),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 10,
          bottom: 10,
        ),
        child: IntrinsicWidth(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: menuItems.map((menuItem) {
              final color = menuItem.getColor(colors);
              return InkWell(
                onTap: () => onTapMenuItem(menuItem),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Image.asset(
                        menuItem.icon,
                        width: _iconSize,
                        height: _iconSize,
                        color: color,
                      ),
                      const Gap(10),
                      Text(
                        menuItem.label,
                        style: _textStyle.copyWith(color: color),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
