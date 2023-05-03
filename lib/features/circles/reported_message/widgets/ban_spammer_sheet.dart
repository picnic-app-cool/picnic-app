import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_text_button.dart';

class BanSpammerSheet extends StatelessWidget {
  const BanSpammerSheet({
    Key? key,
    required this.onTapClose,
    required this.onTapBan,
    required this.onTapRemoveMessage,
    required this.onTapResolveNoAction,
  }) : super(key: key);

  final VoidCallback onTapBan;
  final VoidCallback onTapRemoveMessage;
  final VoidCallback onTapResolveNoAction;

  final VoidCallback onTapClose;
  static const _borderWidth = 2.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);

    final colors = theme.colors;
    final redColor = colors.red;
    final purpleColor = colors.purple;

    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(16),
          topLeft: Radius.circular(16),
        ),
        color: theme.colors.blackAndWhite.shade100,
      ),
      width: double.infinity,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Gap(20.0),
              Text(
                appLocalizations.reportedMessage,
                style: theme.styles.title30,
              ),
              const Gap(20.0),
              PicnicButton(
                title: appLocalizations.removeMessageAction,
                color: redColor,
                onTap: onTapRemoveMessage,
              ),
              const Gap(16.0),
              PicnicButton(
                title: appLocalizations.banUserLabel,
                style: PicnicButtonStyle.outlined,
                borderColor: redColor,
                titleColor: redColor,
                borderWidth: _borderWidth,
                onTap: onTapBan,
              ),
              const Gap(16.0),
              PicnicButton(
                title: appLocalizations.resolveWithNoActionLabel,
                style: PicnicButtonStyle.outlined,
                borderColor: purpleColor,
                titleColor: purpleColor,
                borderWidth: _borderWidth,
                onTap: onTapResolveNoAction,
              ),
              Center(
                child: PicnicTextButton(
                  label: appLocalizations.closeAction,
                  onTap: onTapClose,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
