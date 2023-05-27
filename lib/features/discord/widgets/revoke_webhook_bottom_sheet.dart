import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_text_button.dart';

class RevokeWebhookBottomSheet extends StatelessWidget {
  const RevokeWebhookBottomSheet({
    Key? key,
    required this.onTapRevoke,
    required this.onTapCancel,
  }) : super(key: key);

  final VoidCallback onTapRevoke;
  final VoidCallback onTapCancel;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final blackAndWhite = colors.blackAndWhite;
    final styles = theme.styles;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            appLocalizations.revokeIntegrationTitle,
            style: styles.subtitle40,
          ),
          const Gap(20),
          Text(
            appLocalizations.revokeIntegrationDescription,
            style: styles.caption10.copyWith(color: blackAndWhite.shade600),
          ),
          const Gap(20),
          Center(
            child: SizedBox(
              width: double.infinity,
              child: PicnicButton(
                title: appLocalizations.revokeIntegrationConfirm,
                titleStyle: styles.subtitle30.copyWith(color: blackAndWhite.shade100),
                color: theme.colors.pink,
                onTap: onTapRevoke,
              ),
            ),
          ),
          Center(
            child: PicnicTextButton(
              label: appLocalizations.cancelAction,
              labelStyle: styles.caption20.copyWith(color: blackAndWhite.shade600),
              onTap: onTapCancel,
            ),
          ),
        ],
      ),
    );
  }
}
