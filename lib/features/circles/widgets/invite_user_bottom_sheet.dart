import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_text_button.dart';

class InviteUserBottomSheet extends StatelessWidget {
  const InviteUserBottomSheet({
    Key? key,
    required this.onTapClose,
    required this.onTapCopyLink,
    required this.onTapInvite,
  }) : super(key: key);

  final VoidCallback onTapInvite;
  final VoidCallback onTapCopyLink;
  final VoidCallback onTapClose;

  static const _borderWidth = 3.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final blueColor = theme.colors.blue;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                appLocalizations.inviteUsersAction,
                style: theme.styles.subtitle40,
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: PicnicButton(
                title: appLocalizations.inviteByUsernameAction,
                onTap: onTapInvite,
              ),
            ),
            const Gap(8),
            SizedBox(
              width: double.infinity,
              child: PicnicButton(
                title: appLocalizations.copyInviteLinkAction,
                borderColor: blueColor,
                titleColor: blueColor,
                borderWidth: _borderWidth,
                style: PicnicButtonStyle.outlined,
                onTap: onTapCopyLink,
              ),
            ),
            const Gap(8),
            Center(
              child: PicnicTextButton(
                label: appLocalizations.closeAction,
                onTap: onTapClose,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
