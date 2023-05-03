import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class TermsAndPoliciesDisclaimer extends StatelessWidget {
  const TermsAndPoliciesDisclaimer({
    required this.onTapTerms,
    required this.onTapPolicies,
    required this.showWarningIcon,
    required this.textColor,
    required this.userAgreementText,
  });

  final String userAgreementText;
  final Color textColor;
  final bool showWarningIcon;
  final VoidCallback onTapTerms;
  final VoidCallback onTapPolicies;
  static const warningIconSize = 14.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final styles = theme.styles;
    final colors = theme.colors;
    final body10 = styles.body10;
    final normalStyle = body10.copyWith(
      color: textColor,
    );
    final greenStyle = body10.copyWith(
      color: colors.green[600],
    );
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showWarningIcon)
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Image.asset(
              Assets.images.warningRound.path,
              color: colors.blackAndWhite,
              height: warningIconSize,
              width: warningIconSize,
            ),
          ),
        if (showWarningIcon) const Gap(5),
        Flexible(
          child: RichText(
            text: TextSpan(
              style: normalStyle,
              children: [
                TextSpan(
                  text: userAgreementText,
                ),
                TextSpan(
                  text: appLocalizations.appTerms,
                  style: greenStyle,
                  recognizer: TapGestureRecognizer()..onTap = onTapTerms,
                ),
                TextSpan(
                  text: appLocalizations.and,
                ),
                TextSpan(
                  text: appLocalizations.policies,
                  style: greenStyle,
                  recognizer: TapGestureRecognizer()..onTap = onTapPolicies,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
