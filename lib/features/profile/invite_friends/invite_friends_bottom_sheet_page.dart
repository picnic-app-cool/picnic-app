import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/profile/invite_friends/invite_friends_bottom_sheet_presentation_model.dart';
import 'package:picnic_app/features/profile/invite_friends/invite_friends_bottom_sheet_presenter.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/contacts/contacts_list.dart';
import 'package:picnic_app/ui/widgets/contacts/contacts_permission_widget.dart';
import 'package:picnic_app/ui/widgets/picnic_share_bar.dart';
import 'package:picnic_app/ui/widgets/picnic_soft_search_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_text_button.dart';

class InviteFriendsBottomSheetPage extends StatefulWidget with HasPresenter<InviteFriendsBottomSheetPresenter> {
  const InviteFriendsBottomSheetPage({
    super.key,
    required this.presenter,
  });

  @override
  final InviteFriendsBottomSheetPresenter presenter;

  @override
  State<InviteFriendsBottomSheetPage> createState() => _InviteFriendsBottomSheetPageState();
}

class _InviteFriendsBottomSheetPageState extends State<InviteFriendsBottomSheetPage>
    with
        PresenterStateMixin<InviteFriendsBottomSheetViewModel, InviteFriendsBottomSheetPresenter,
            InviteFriendsBottomSheetPage> {
  late final TextEditingController _controller;

  static const _heightFactor = 0.7;
  static const _contentPadding = EdgeInsets.only(
    top: 6.0,
    right: 12.0,
    bottom: 6.0,
    left: 16.0,
  );

  @override
  void initState() {
    super.initState();
    presenter.onInit();
    _controller = TextEditingController()
      ..addListener(
        () => presenter.onSearch(_controller.text),
      );
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
    final bwBody20 = theme.styles.body30.copyWith(color: colors.blackAndWhite.shade600);

    return Padding(
      padding: const EdgeInsets.all(20),
      child: stateObserver(
        builder: (context, state) => FractionallySizedBox(
          heightFactor: !state.showContactAccessButton ? _heightFactor : null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                appLocalizations.inviteFriendsFollow,
                style: theme.styles.subtitle40,
              ),
              const Gap(8),
              Text(
                appLocalizations.goViral,
                style: bwBody20,
              ),
              stateObserver(
                buildWhen: (previous, current) => previous.showContactAccessButton != current.showContactAccessButton,
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
              const Gap(12),
              PicnicSoftSearchBar(
                controller: _controller,
                hintText: appLocalizations.searchFriendsContactsHint,
                contentPadding: _contentPadding,
              ),
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
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              const Gap(20),
              PicnicShareBar(onTap: presenter.onTapShareLink),
              const Gap(20),
              PicnicTextButton(
                label: appLocalizations.closeAction,
                labelStyle: bwBody20,
                onTap: presenter.onTapClose,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
