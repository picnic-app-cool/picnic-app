import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/features/onboarding/onboarding_presentation_model.dart';
import 'package:picnic_app/features/onboarding/phone_form/phone_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/widgets/onboarding_text_input.dart';
import 'package:picnic_app/features/user_agreement/widgets/terms_and_policies_disclaimer.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_text_button.dart';

class PhoneFormDialogContent extends StatelessWidget {
  const PhoneFormDialogContent({
    super.key,
    required this.onChangedPhone,
    required this.onChangedUsername,
    required this.onTapContinue,
    required this.state,
    required this.onTapGoogleSignIn,
    required this.onTapAppleSignIn,
    required this.onTapDiscordSignIn,
    required this.onChangedCountryCode,
    required this.phoneFocusNode,
    required this.usernameFocusNode,
    required this.onEnableUsernameLogin,
    required this.onTapTerms,
    required this.onTapPolicies,
  });

  final ValueChanged<String> onChangedPhone;
  final ValueChanged<String> onChangedUsername;
  final ValueChanged<CountryCode> onChangedCountryCode;
  final VoidCallback onTapContinue;
  final VoidCallback onTapGoogleSignIn;
  final VoidCallback onTapDiscordSignIn;

  final VoidCallback onTapAppleSignIn;
  final VoidCallback onTapTerms;
  final VoidCallback onTapPolicies;
  final PhoneFormViewModel state;
  final FocusNode phoneFocusNode;
  final FocusNode usernameFocusNode;
  final ValueChanged<bool> onEnableUsernameLogin;

  static const _google = 'Google';
  static const _apple = 'Apple';
  static const _discord = 'Discord';

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final styles = theme.styles;
    final colors = theme.colors;
    final textButtonTheme = styles.title10.copyWith(
      color: colors.green.shade600,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (state.isUsernameAuthOpened)
          OnBoardingTextInput(
            key: const Key('usernameInput'),
            focusNode: usernameFocusNode,
            initialValue: state.username,
            onChanged: onChangedUsername,
            keyboardType: TextInputType.text,
          ),
        if (state.isFirebasePhoneAuthEnabled) ...[
          if (!state.isUsernameAuthOpened)
            OnBoardingTextInput(
              key: const Key('phoneInput'),
              focusNode: phoneFocusNode,
              initialValue: state.phoneNumber,
              initialCountry: state.dialCode,
              inputType: PicnicOnBoardingTextInputType.countryCodePickerTextInput,
              onChanged: onChangedPhone,
              onChangedCountryCode: onChangedCountryCode,
            ),
        ],
        const Gap(6),
        TermsAndPoliciesDisclaimer(
          onTapTerms: onTapTerms,
          onTapPolicies: onTapPolicies,
          textColor: colors.blackAndWhite[700]!,
          userAgreementText: appLocalizations.byContinuingYouAgreeTo,
          showWarningIcon: true,
        ),
        const Gap(8),
        Stack(
          alignment: Alignment.center,
          children: [
            PicnicButton(
              onTap: state.continueEnabled ? onTapContinue : null,
              title: appLocalizations.continueAction,
              minWidth: double.infinity,
            ),
            PicnicLoadingIndicator(isLoading: state.isLoading),
          ],
        ),
        if (state.showSignInWithUsername) ...[
          if (state.isUsernameAuthOpened)
            PicnicTextButton(
              onTap: () => _changeLoginMethod(isUsername: false),
              label: appLocalizations.onboardingPhoneLogin,
              labelStyle: textButtonTheme,
            ),
          if (!state.isUsernameAuthOpened)
            PicnicTextButton(
              onTap: () => _changeLoginMethod(isUsername: true),
              label: appLocalizations.onboardingUsernameLogin,
              labelStyle: textButtonTheme,
            ),
        ],
        const Gap(16),
        if (state.signInWithAppleEnabled || state.signInWithGoogleEnabled) ...[
          Center(
            child: Text(
              appLocalizations.orLabel,
              style: styles.body10.copyWith(
                color: colors.blackAndWhite,
              ),
            ),
          ),
          const Gap(16),
        ],
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (state.signInWithAppleEnabled)
              _SignInButton(
                formType: state.formType,
                image: Assets.images.signInAppleLogo.path,
                onTap: state.isLoading ? null : onTapAppleSignIn,
                method: _apple,
              ),
            const Gap(12),
            if (state.signInWithGoogleEnabled)
              _SignInButton(
                formType: state.formType,
                image: Assets.images.signInGoogleLogo.path,
                onTap: state.isLoading ? null : onTapGoogleSignIn,
                method: _google,
              ),
            const Gap(12),
            if (state.signInWithDiscordEnabled)
              _SignInButton(
                formType: state.formType,
                image: Assets.images.discord.path,
                onTap: state.isLoading ? null : onTapDiscordSignIn,
                method: _discord,
              ),
          ],
        ),
      ],
    );
  }

  void _changeLoginMethod({required bool isUsername}) {
    if (isUsername) {
      phoneFocusNode.unfocus();
    } else {
      usernameFocusNode.unfocus();
    }
    onEnableUsernameLogin(isUsername);
    if (isUsername) {
      usernameFocusNode.requestFocus();
    } else {
      phoneFocusNode.requestFocus();
    }
  }
}

class _SignInButton extends StatelessWidget {
  const _SignInButton({
    Key? key,
    required this.formType,
    required this.image,
    required this.onTap,
    required this.method,
  }) : super(key: key);

  final OnboardingFlowType formType;
  final String image;
  final VoidCallback? onTap;
  final String method;

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
      borderRadius: const PicnicButtonRadius.semiRound(),
      icon: image,
      title: _signInButtonTitle,
      color: Colors.transparent,
      borderColor: black.shade300,
      style: PicnicButtonStyle.outlined,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      titleStyle: theme.styles.body20.copyWith(
        color: black.shade700,
      ),
      borderWidth: 1,
      onTap: onTap,
    );
  }
}
