import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/posts/after_post/after_post_dialog_presentation_model.dart';
import 'package:picnic_app/features/posts/after_post/after_post_dialog_presenter.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/contacts/contacts_list.dart';
import 'package:picnic_app/ui/widgets/contacts/contacts_permission_widget.dart';
import 'package:picnic_app/ui/widgets/picnic_share_bar.dart';
import 'package:picnic_app/ui/widgets/picnic_soft_search_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_text_button.dart';

class AfterPostDialogPage extends StatefulWidget with HasPresenter<AfterPostDialogPresenter> {
  const AfterPostDialogPage({
    super.key,
    required this.presenter,
  });

  @override
  final AfterPostDialogPresenter presenter;

  @override
  State<AfterPostDialogPage> createState() => _AfterPostDialogPageState();
}

class _AfterPostDialogPageState extends State<AfterPostDialogPage>
    with PresenterStateMixin<AfterPostDialogViewModel, AfterPostDialogPresenter, AfterPostDialogPage> {
  final TextEditingController _controller = TextEditingController();

  static const _dialogElevation = 10.0;
  static const _contentBorderRadius = 16.0;
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
    _controller.addListener(() => presenter.onSearch(_controller.text));
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
    final bwBody20 = theme.styles.body30.copyWith(color: colors.blackAndWhite.shade600);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Dialog(
          elevation: _dialogElevation,
          insetPadding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_contentBorderRadius),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  appLocalizations.successfullyPosted,
                  style: styles.subtitle40,
                ),
                Text(
                  appLocalizations.shareThisWithYourFriends,
                  style: bwBody20,
                ),
                const Gap(12),
                PicnicShareBar(onTap: presenter.onTapSharePostLink),
                const Gap(12),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    appLocalizations.sendToFriends,
                    style: styles.subtitle40,
                  ),
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
                PicnicTextButton(
                  onTap: presenter.onTapClose,
                  labelStyle: bwBody20,
                  label: appLocalizations.closeAction,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
