import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class ContactsPermissionWidget extends StatelessWidget {
  const ContactsPermissionWidget({
    Key? key,
    required this.onTapAllowImportContacts,
    this.withDescription = true,
  }) : super(key: key);

  final bool withDescription;

  final VoidCallback onTapAllowImportContacts;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final styles = theme.styles;
    final bw = colors.blackAndWhite;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Gap(16),
        PicnicButton(
          color: colors.pink.shade500,
          titleStyle: styles.subtitle30.copyWith(color: bw.shade100),
          title: appLocalizations.contactAccessAction,
          onTap: onTapAllowImportContacts,
        ),
        if (withDescription) ...[
          const Gap(16),
          Text(
            appLocalizations.contactAccessDescriptionInvite,
            style: styles.body20.copyWith(color: colors.blackAndWhite.shade600),
          ),
        ],
      ],
    );
  }
}
