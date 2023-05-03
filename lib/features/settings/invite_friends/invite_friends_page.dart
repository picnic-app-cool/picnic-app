import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/settings/invite_friends/invite_friends_presentation_model.dart';
import 'package:picnic_app/features/settings/invite_friends/invite_friends_presenter.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/contacts/contacts_list.dart';
import 'package:picnic_app/ui/widgets/contacts/contacts_permission_widget.dart';
import 'package:picnic_app/ui/widgets/picnic_share_bar.dart';
import 'package:picnic_app/ui/widgets/picnic_soft_search_bar.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class InviteFriendsPage extends StatefulWidget with HasPresenter<InviteFriendsPresenter> {
  const InviteFriendsPage({
    super.key,
    required this.presenter,
  });

  @override
  final InviteFriendsPresenter presenter;

  @override
  State<InviteFriendsPage> createState() => _InviteFriendsPageState();
}

class _InviteFriendsPageState extends State<InviteFriendsPage>
    with PresenterStateMixin<InviteFriendsViewModel, InviteFriendsPresenter, InviteFriendsPage> {
  final TextEditingController _controller = TextEditingController();

  static const _contentPadding = EdgeInsets.only(
    top: 6.0,
    right: 12.0,
    bottom: 6.0,
    left: 16.0,
  );

  @override
  void initState() {
    presenter.onInit();
    _controller.addListener(() => presenter.onSearch(_controller.text));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final styles = theme.styles;

    return Scaffold(
      appBar: PicnicAppBar(
        backgroundColor: theme.colors.blackAndWhite.shade100,
        titleText: appLocalizations.settingsInviteFriends,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              appLocalizations.inviteFriendsFollow,
              style: styles.body20.copyWith(color: colors.blackAndWhite.shade600),
            ),
            const Gap(8),
            PicnicSoftSearchBar(
              hintText: appLocalizations.searchFriendsContactsHint,
              onChanged: presenter.onSearch,
              contentPadding: _contentPadding,
            ),
            stateObserver(
              builder: (context, state) {
                if (!state.showContactAccessButton) {
                  return const SizedBox.shrink();
                }
                return ContactsPermissionWidget(
                  onTapAllowImportContacts: presenter.onTapAllowImportContacts,
                  withDescription: state.showContactAccessButton,
                );
              },
            ),
            const Gap(8),
            PicnicShareBar(onTap: presenter.onTapShareLink),
            const Gap(20),
            stateObserver(
              builder: (context, state) {
                if (!state.showContactAccessButton) {
                  return Expanded(
                    child: ContactsList(
                      userContacts: state.userContacts,
                      loadMore: presenter.loadMoreContacts,
                      onTapInvite: presenter.onTapInvite,
                      getContactForUser: presenter.getContactForUser,
                      buttonTitleText: (invited) => presenter.buttonTitleText(invited: invited),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
