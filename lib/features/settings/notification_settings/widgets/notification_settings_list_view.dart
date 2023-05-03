import 'package:flutter/material.dart';
import 'package:picnic_app/features/settings/domain/model/notification_item.dart';
import 'package:picnic_app/features/settings/domain/model/notification_settings.dart';
import 'package:picnic_app/ui/widgets/picnic_list_item.dart';
import 'package:picnic_app/ui/widgets/picnic_switch.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class NotificationSettingsListView extends StatelessWidget {
  const NotificationSettingsListView({
    super.key,
    required this.items,
    required this.notificationSettings,
    required this.onTapToggle,
  });

  final ValueChanged<NotificationItem> onTapToggle;
  final List<NotificationItem> items;
  final NotificationSettings notificationSettings;
  static const _itemHeight = 44.0;
  static const _itemPadding = EdgeInsets.only(bottom: 24.0);

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final itemTextStyle = theme.styles.title20;

    return Column(
      children: items
          .map(
            (it) => Padding(
              padding: _itemPadding,
              child: PicnicListItem(
                title: it.label,
                titleStyle: itemTextStyle,
                height: _itemHeight,
                trailing: PicnicSwitch(
                  value: notificationSettings.settingForItem(it),
                  onChanged: (selected) => onTapToggle(it),
                  size: PicnicSwitchSize.regular,
                  color: colors.green,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
