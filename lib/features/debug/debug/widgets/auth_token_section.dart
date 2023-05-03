import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/ui/widgets/picnic_switch.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class AuthTokenSection extends StatelessWidget {
  const AuthTokenSection({
    super.key,
    required this.onTapSimulateInvalidToken,
    required this.shouldUseShortLivedTokens,
    required this.onChangedShortLivedTokens,
  });

  final void Function(bool) onChangedShortLivedTokens;
  final VoidCallback onTapSimulateInvalidToken;
  final bool shouldUseShortLivedTokens;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final textStyles = theme.styles;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.colors.blackAndWhite.shade500,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                "Auth token",
                style: textStyles.title20,
              ),
            ),
            Text(
              "allows for managing and testing aut token refresh",
              style: textStyles.caption10,
            ),
            const Gap(16),
            PicnicButton(
              title: 'Simulate invalid token',
              onTap: onTapSimulateInvalidToken,
            ),
            Text(
              'this will replace the auth token saved internally to an invalid one, so as soon as you trigger any '
              'backend call (by opening new screen or triggering action) the app should log you out. '
              'WARNING: This will not trigger "refresh token" functionality',
              style: textStyles.caption10,
            ),
            const Gap(16),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    "enable short-lived tokens",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                PicnicSwitch(
                  onChanged: onChangedShortLivedTokens,
                  value: shouldUseShortLivedTokens,
                ),
              ],
            ),
            Text(
              'when enabled, on next sign in / sign up attempt, the app will ask backend for issuing a short-lived'
              ' auth token (${Constants.shortLivedTokenTTLSeconds} seconds). In order to test token refresh,'
              ' you have to log out and then log in into the app with this swith checked.'
              " REMEMBER! to turn this option off when you're done testing auth token refresh",
              style: textStyles.caption10,
            ),
          ],
        ),
      ),
    );
  }
}
