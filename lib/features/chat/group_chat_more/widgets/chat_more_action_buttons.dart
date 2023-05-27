import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class ChatMoreActionButtons extends StatelessWidget {
  const ChatMoreActionButtons({
    Key? key,
    required this.isAddMembersVisible,
    required this.onTapReport,
    required this.onTapLeave,
    required this.onTapAddMembers,
  }) : super(key: key);

  final bool isAddMembersVisible;
  final VoidCallback onTapReport;
  final VoidCallback onTapLeave;
  final VoidCallback onTapAddMembers;

  static const _buttonBorderWidth = 2.0;

  @override
  Widget build(BuildContext context) {
    final colors = PicnicTheme.of(context).colors;
    final redColor = colors.pink.shade500;
    final blueColor = colors.blue.shade500;

    final addMoreButton = PicnicButton(
      minWidth: double.infinity,
      title: appLocalizations.addMembers,
      borderColor: blueColor,
      titleColor: blueColor,
      color: Colors.white,
      style: PicnicButtonStyle.outlined,
      borderWidth: _buttonBorderWidth,
      onTap: onTapAddMembers,
    );

    final reportButton = PicnicButton(
      title: appLocalizations.reportAction,
      borderColor: redColor,
      titleColor: redColor,
      color: Colors.white,
      style: PicnicButtonStyle.outlined,
      borderWidth: _buttonBorderWidth,
      onTap: onTapReport,
    );

    final leaveButton = PicnicButton(
      title: appLocalizations.leaveAction,
      color: redColor,
      borderColor: redColor,
      titleColor: Colors.white,
      style: PicnicButtonStyle.outlined,
      borderWidth: _buttonBorderWidth,
      onTap: onTapLeave,
    );

    return Column(
      children: [
        if (isAddMembersVisible) ...[
          addMoreButton,
          const Gap(12),
        ],
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: reportButton,
            ),
            const Gap(10),
            Expanded(
              child: leaveButton,
            ),
          ],
        ),
      ],
    );
  }
}
