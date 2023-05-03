import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/chat/settings/single_chat_settings.dart';
import 'package:picnic_app/features/chat/settings/widgets/single_chat_settings_header.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_text_button.dart';

class SingleChatSettingsPage extends StatefulWidget with HasPresenter<SingleChatSettingsPresenter> {
  const SingleChatSettingsPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final SingleChatSettingsPresenter presenter;

  @override
  State<SingleChatSettingsPage> createState() => _SingleChatSettingsPageState();
}

class _SingleChatSettingsPageState extends State<SingleChatSettingsPage>
    with PresenterStateMixin<SingleChatSettingsViewModel, SingleChatSettingsPresenter, SingleChatSettingsPage> {
  @override
  void initState() {
    super.initState();
    presenter.init();
  }

  @override
  Widget build(BuildContext context) {
    return stateObserver(
      builder: (context, state) {
        final child = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SingleChatSettingsHeader(
              user: state.user,
              onTapUser: presenter.onTapUser,
            ),
            const Gap(22),
            SingleChatSettingsButtons(
              muted: state.muted,
              followed: state.followed,
              followMe: state.followMe,
              followResult: state.followResult,
              muteResult: state.muteResult,
              onButtonTap: presenter.onTapActionButton,
            ),
            Center(
              child: PicnicTextButton(
                label: appLocalizations.closeAction,
                onTap: Navigator.of(context).pop,
              ),
            ),
            const Gap(16),
          ],
        );
        return IndexedStack(
          index: state.loading ? 1 : 0,
          alignment: Alignment.center,
          children: <Widget>[
            child,
            const PicnicLoadingIndicator(),
          ],
        );
      },
    );
  }
}
