import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/phone_contacts/phone_contact.dart';
import 'package:picnic_app/core/domain/model/user_contact.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/contacts/contact_avatar.dart';
import 'package:picnic_app/ui/widgets/paging_list/picnic_paging_list_view.dart';
import 'package:picnic_app/ui/widgets/picnic_list_item.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class ContactsList extends StatelessWidget {
  const ContactsList({
    super.key,
    required this.userContacts,
    required this.onTapInvite,
    required this.getContactForUser,
    required this.loadMore,
    this.buttonTitleText,
  });

  final PaginatedList<UserContact> userContacts;
  final ValueChanged<UserContact> onTapInvite;
  final PhoneContact? Function(UserContact) getContactForUser;
  final Future<void> Function() loadMore;
  final String Function(bool invited)? buttonTitleText;

  static const _invitedBorderWidth = 2.0;
  static const _borderWidth = 3.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final white = colors.blackAndWhite.shade100;
    final blue = colors.blue;

    return PicnicPagingListView<UserContact>(
      paginatedList: userContacts,
      loadMore: loadMore,
      loadingBuilder: (_) => const PicnicLoadingIndicator(),
      separatorBuilder: (context, index) => const SizedBox(height: 15),
      itemBuilder: (context, user) {
        final phoneContact = getContactForUser(user);
        return PicnicListItem(
          height: null,
          leftGap: 0,
          titleGap: 0,
          trailingGap: 0,
          title: user.name,
          subTitle: user.contactPhoneNumber.number,
          subTitleStyle: theme.styles.caption10.copyWith(color: colors.blackAndWhite.shade600),
          titleStyle: theme.styles.subtitle20,
          leading: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ContactAvatar(phoneContact: phoneContact),
          ),
          trailing: PicnicButton(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 10,
            ),
            title: buttonTitleText?.call(user.invited) ??
                (user.invited ? appLocalizations.sentAction : appLocalizations.sendAction),
            onTap: () => onTapInvite(user),
            style: PicnicButtonStyle.outlined,
            borderWidth: user.invited ? _invitedBorderWidth : _borderWidth,
            borderColor: blue,
            titleColor: user.invited ? blue : white,
            color: user.invited ? white : blue,
          ),
        );
      },
    );
  }
}
