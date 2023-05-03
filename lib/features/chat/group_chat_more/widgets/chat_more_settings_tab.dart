import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/picnic_switch.dart';
import 'package:picnic_app/ui/widgets/picnic_text_input.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class ChatMoreSettingsTab extends StatelessWidget {
  const ChatMoreSettingsTab({
    Key? key,
    required this.onTapSwitchNotifications,
    required this.onChangedSearchText,
    required this.groupName,
    required this.isMuted,
  }) : super(key: key);

  final ValueChanged<bool> onTapSwitchNotifications;
  final ValueChanged<String> onChangedSearchText;
  final String groupName;
  final bool isMuted;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final blackAndWhite = colors.blackAndWhite;
    final textStyleBody20 = theme.styles.body20;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PicnicTextInput(
            onChanged: onChangedSearchText,
            inputFillColor: blackAndWhite.shade200,
            inputTextStyle: textStyleBody20,
            hintText: appLocalizations.groupNameLabel,
            padding: 0.0,
            initialValue: groupName,
          ),
          const Gap(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                appLocalizations.muteGroupTitle,
                style: theme.styles.title20,
                textAlign: TextAlign.center,
              ),
              PicnicSwitch(
                color: colors.green,
                size: PicnicSwitchSize.regular,
                onChanged: onTapSwitchNotifications,
                value: isMuted,
              ),
            ],
          ),
          Text(
            appLocalizations.tapToIgnoreNotificationsDescription,
            style: theme.styles.caption10.copyWith(
              color: colors.blackAndWhite.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
