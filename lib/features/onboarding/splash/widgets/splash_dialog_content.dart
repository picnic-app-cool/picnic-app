import 'package:flutter/material.dart';
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
    return Column(
      children: [
        PicnicButton(
          title: appLocalizations.getStartedAction,
          color: theme.colors.pink,
          minWidth: double.infinity,
          onTap: onTapGetStarted,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              appLocalizations.alreadyHaveAnAccountMessage,
              style: styles.body20,
            ),
            TextButton(
              onPressed: onTapLogin,
              child: Text(
                appLocalizations.logInAction,
                style: styles.body20.copyWith(
                  color: theme.colors.green,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
