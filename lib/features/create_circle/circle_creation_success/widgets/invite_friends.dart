import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/features/circles/widgets/decorated_sheet.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/contacts/contacts_list.dart';
import 'package:picnic_app/ui/widgets/contacts/contacts_permission_widget.dart';
import 'package:picnic_app/ui/widgets/picnic_share_bar.dart';
import 'package:picnic_app/ui/widgets/picnic_soft_search_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class InviteFriends extends StatelessWidget {
  const InviteFriends({
    super.key,
    required this.showContactAccessButton,
    required this.onTapLinkBar,
    required this.onTapAwesome,
    required this.onTapAllowImportContacts,
    required this.controller,
    required this.contactsList,
  });

  final bool showContactAccessButton;
  final VoidCallback onTapLinkBar;
  final VoidCallback onTapAwesome;
  final VoidCallback onTapAllowImportContacts;
  final TextEditingController controller;
  final ContactsList contactsList;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final styles = theme.styles;
    final blackAndWhite = colors.blackAndWhite;

    const contentTopPadding = 120.0;
    const contentPaddingSearchInput = EdgeInsets.symmetric(
      horizontal: 16.0,
      vertical: 6.0,
    );

    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: contentTopPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            DecoratedSheet(
              flex: !showContactAccessButton ? 1 : 0,
              onTap: onTapAwesome,
              buttonTitle: appLocalizations.awesomeAction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    appLocalizations.congratsSuccessTitle,
                    style: styles.subtitle40,
                    textAlign: TextAlign.center,
                  ),
                  const Gap(8),
                  Text(
                    appLocalizations.congratsSuccessDescription,
                    style: styles.caption20.copyWith(color: blackAndWhite.shade600),
                    textAlign: TextAlign.center,
                  ),
                  const Gap(16),
                  PicnicShareBar(onTap: onTapLinkBar),
                  const Gap(16),
                  Text(
                    appLocalizations.settingsInviteFriends,
                    style: styles.subtitle40,
                  ),
                  const Gap(8),
                  PicnicSoftSearchBar(
                    controller: controller,
                    hintText: appLocalizations.searchFriendsContactsHint,
                    contentPadding: contentPaddingSearchInput,
                  ),
                  if (!showContactAccessButton)
                    const SizedBox()
                  else
                    ContactsPermissionWidget(
                      onTapAllowImportContacts: onTapAllowImportContacts,
                      withDescription: showContactAccessButton,
                    ),
                  const Gap(20),
                  if (!showContactAccessButton)
                    Expanded(
                      child: contactsList,
                    )
                  else
                    const SizedBox.shrink(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
