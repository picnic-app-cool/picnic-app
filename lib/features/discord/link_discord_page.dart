import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/discord/link_discord_initial_params.dart';
import 'package:picnic_app/features/discord/link_discord_presentation_model.dart';
import 'package:picnic_app/features/discord/link_discord_presenter.dart';
import 'package:picnic_app/features/discord/widgets/discord_explanation.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_text_input.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class LinkDiscordPage extends StatefulWidget with HasInitialParams {
  const LinkDiscordPage({
    super.key,
    required this.initialParams,
  });

  @override
  final LinkDiscordInitialParams initialParams;

  @override
  State<LinkDiscordPage> createState() => _LinkDiscordPageState();
}

class _LinkDiscordPageState extends State<LinkDiscordPage>
    with PresenterStateMixinAuto<LinkDiscordViewModel, LinkDiscordPresenter, LinkDiscordPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _controller.addListener(() => presenter.onWebhookInputChanged(_controller.text));
    presenter.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final blackAndWhite = colors.blackAndWhite;
    const enableddOpacity = 1.0;
    const disabledOpacity = 0.5;
    return Scaffold(
      appBar: PicnicAppBar(
        titleText: appLocalizations.linkDiscord,
      ),
      body: stateListener(
        listenWhen: (previous, current) => previous.webhookUrl != current.webhookUrl && current.urlShouldAutoComplete,
        listener: (context, state) {
          _controller.text = state.webhookUrl;
        },
        child: stateObserver(
          builder: (context, state) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DiscordExplanation(),
                const Gap(24),
                Text(
                  appLocalizations.discordServerWebhook,
                  style: theme.styles.body20.copyWith(color: blackAndWhite.shade800),
                ),
                const Gap(3),
                PicnicTextInput(
                  textController: _controller,
                  hintText: appLocalizations.webhook,
                  onChanged: presenter.onWebhookInputChanged,
                  padding: 0,
                  contentPadding: const EdgeInsets.all(16),
                  suffix: _controller.text.isEmpty
                      ? GestureDetector(
                          onTap: presenter.onTapClipboardIcon,
                          child: Image.asset(
                            Assets.images.pasteIcon.path,
                            color: blackAndWhite.shade600,
                          ),
                        )
                      : GestureDetector(
                          onTap: presenter.onTapDeleteIcon,
                          child: Image.asset(
                            Assets.images.trashIcon.path,
                            color: theme.colors.red,
                          ),
                        ),
                ),
                const Spacer(),
                if (state.serverIsConnected)
                  Text(
                    appLocalizations.serverAlreadyConnected,
                    style: theme.styles.caption10.copyWith(color: blackAndWhite.shade600),
                  ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: SizedBox(
                      width: double.infinity,
                      child: PicnicButton(
                        opacity: state.isButtonEnabled ? enableddOpacity : disabledOpacity,
                        title: state.serverIsConnected ? appLocalizations.revoke : appLocalizations.connect,
                        color: state.serverIsConnected ? colors.pink : colors.green,
                        onTap: presenter.onTapBottomButton,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
