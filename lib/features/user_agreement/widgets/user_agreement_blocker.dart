import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/features/user_agreement/widgets/terms_and_policies_disclaimer.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class UserAgreementBlocker extends StatelessWidget {
  const UserAgreementBlocker({
    required this.onTapTerms,
    required this.onTapPolicies,
    required this.onTapAccept,
  });

  final VoidCallback onTapTerms;
  final VoidCallback onTapPolicies;
  final VoidCallback onTapAccept;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final styles = theme.styles;
    final grey = theme.colors.blackAndWhite[600]!;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            appLocalizations.userAgreement,
            style: styles.subtitle40,
          ),
          const Gap(12),
          TermsAndPoliciesDisclaimer(
            onTapTerms: onTapTerms,
            onTapPolicies: onTapPolicies,
            userAgreementText: appLocalizations.agreeToPicnic,
            textColor: grey,
            showWarningIcon: false,
          ),
          const Gap(30),
          Text(
            appLocalizations.stopUsingAppIfYouDoNotAgree,
            style: styles.body10.copyWith(
              color: grey,
            ),
          ),
          const Gap(16),
          PicnicButton(
            onTap: onTapAccept,
            title: appLocalizations.acceptTermsButton,
            minWidth: double.infinity,
          ),
          const Gap(12),
        ],
      ),
    );
  }
}
