import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class SplashDialogContent extends StatelessWidget {
  const SplashDialogContent({
    Key? key,
    required this.onTapLogin,
    required this.onTapGetStarted,
  }) : super(key: key);

  final VoidCallback onTapLogin;
  final VoidCallback onTapGetStarted;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final styles = theme.styles;
    final colors = theme.colors;

    final blue = theme.colors.blue;
    final body20Blue = styles.body20.copyWith(color: colors.darkBlue.shade600);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(appLocalizations.congratsFormTitle, style: styles.display50),
          const Gap(6.0),
          Text(appLocalizations.appSubtitle, style: body20Blue),
          const Gap(6.0),
          PicnicButton(
            title: appLocalizations.getStartedAction,
            color: blue,
            minWidth: double.infinity,
            onTap: onTapGetStarted,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                appLocalizations.alreadyHaveAnAccountMessage,
                style: body20Blue,
              ),
              TextButton(
                onPressed: onTapLogin,
                child: Text(
                  appLocalizations.logInAction,
                  style: styles.body20.copyWith(
                    color: blue,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
