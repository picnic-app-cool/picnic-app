import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/features/onboarding/method_form/method_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/onboarding_presentation_model.dart';
import 'package:picnic_app/features/user_agreement/widgets/terms_and_policies_disclaimer.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class MethodFormDialogContent extends StatelessWidget {
  const MethodFormDialogContent({
    super.key,
    required this.onTapContinue,
    required this.state,
    required this.onTapGoogleSignIn,
    required this.onTapAppleSignIn,
    required this.onTapDiscordSignIn,
    required this.onTapTerms,
    required this.onTapPolicies,
  });

  final VoidCallback onTapContinue;
  final VoidCallback onTapGoogleSignIn;
  final VoidCallback onTapDiscordSignIn;

  final VoidCallback onTapAppleSignIn;
  final VoidCallback onTapTerms;
  final VoidCallback onTapPolicies;
  final MethodFormViewModel state;

  static const _google = 'Google';
  static const _apple = 'Apple';
  static const _discord = 'Discord';
  static const _phone = 'phone number';

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;

    final white = colors.blackAndWhite.shade100;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Gap(6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (state.signInWithAppleEnabled)
                _SignInButton(
                  formType: state.formType,
                  image: Assets.images.appleWhite.path,
                  titleColor: white,
                  color: colors.blackAndWhite.shade900,
                  onTap: state.isLoading ? null : onTapAppleSignIn,
                  method: _apple,
                ),
              const Gap(6),
              if (state.signInWithGoogleEnabled)
                _SignInButton(
                  formType: state.formType,
                  image: Assets.images.signInGoogleLogo.path,
                  onTap: state.isLoading ? null : onTapGoogleSignIn,
                  method: _google,
                ),
              const Gap(6),
              if (state.signInWithDiscordEnabled)
                _SignInButton(
                  formType: state.formType,
                  image: Assets.images.discordWhite.path,
                  color: const Color.fromRGBO(
                    88,
                    101,
                    242,
                    1,
                  ),
                  titleColor: white,
                  onTap: state.isLoading ? null : onTapDiscordSignIn,
                  method: _discord,
                ),
              const Gap(6),
              _SignInButton(
                formType: state.formType,
                image: Assets.images.phone.path,
                onTap: onTapContinue,
                method: _phone,
              ),
              const Gap(6),
              TermsAndPoliciesDisclaimer(
                onTapTerms: onTapTerms,
                onTapPolicies: onTapPolicies,
                textColor: colors.blackAndWhite[700]!,
                userAgreementText: appLocalizations.byContinuingYouAgreeTo,
                showWarningIcon: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SignInButton extends StatelessWidget {
  const _SignInButton({
    Key? key,
    required this.formType,
    required this.image,
    required this.onTap,
    required this.method,
    this.color = Colors.transparent,
    this.titleColor = Colors.black,
  }) : super(key: key);

  final OnboardingFlowType formType;
  final String image;
  final VoidCallback? onTap;
  final String method;
  final Color color;
  final Color titleColor;

  String get _signInButtonTitle {
    switch (formType) {
      case OnboardingFlowType.signUp:
        return appLocalizations.signUpWithButtonTitle(method);
      case OnboardingFlowType.signIn:
      case OnboardingFlowType.discord:
        return appLocalizations.signInWithButtonTitle(method);
      case OnboardingFlowType.none:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final black = theme.colors.blackAndWhite;
    return PicnicButton(
      borderRadius: const PicnicButtonRadius.round(),
      icon: image,
      title: _signInButtonTitle,
      color: color,
      borderColor: black.shade300,
      style: PicnicButtonStyle.outlined,
      titleStyle: theme.styles.body20.copyWith(
        color: titleColor,
      ),
      borderWidth: 1,
      onTap: onTap,
    );
  }
}
