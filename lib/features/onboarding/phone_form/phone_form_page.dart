// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/onboarding/onboarding_presentation_model.dart';
import 'package:picnic_app/features/onboarding/phone_form/phone_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/phone_form/phone_form_presenter.dart';
import 'package:picnic_app/features/onboarding/phone_form/widgets/phone_form_dialog_content.dart';
import 'package:picnic_app/features/onboarding/widgets/onboarding_page_container.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/dialog/picnic_dialog.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PhoneFormPage extends StatefulWidget with HasPresenter<PhoneFormPresenter> {
  const PhoneFormPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final PhoneFormPresenter presenter;

  @override
  State<PhoneFormPage> createState() => _PhoneFormPageState();
}

class _PhoneFormPageState extends State<PhoneFormPage>
    with PresenterStateMixin<PhoneFormViewModel, PhoneFormPresenter, PhoneFormPage> {
  late FocusNode phoneFocusNode;
  late FocusNode usernameFocusNode;

  @override
  void initState() {
    super.initState();
    phoneFocusNode = FocusNode();
    usernameFocusNode = FocusNode();
    presenter.onInit();

    if (state.isFirebasePhoneAuthEnabled) {
      WidgetsBinding.instance.addPostFrameCallback((_) => phoneFocusNode.requestFocus());
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) => usernameFocusNode.requestFocus());
    }
  }

  @override
  void dispose() {
    phoneFocusNode.dispose();
    usernameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          stateObserver(
            builder: (context, state) {
              return OnboardingPageContainer(
                dialog: PicnicDialog(
                  image: PicnicAvatar(
                    backgroundColor: PicnicTheme.of(context)
                        .colors
                        .blackAndWhite
                        .shade900
                        .withOpacity(Constants.onboardingImageBgOpacity),
                    imageSource: PicnicImageSource.emoji(
                      '📱',
                      style: const TextStyle(
                        fontSize: Constants.onboardingEmojiSize,
                      ),
                    ),
                  ),
                  title: _dialogTitle(state),
                  description: _dialogDescription(state),
                  content: stateObserver(
                    builder: (context, state) => PhoneFormDialogContent(
                      onChangedPhone: presenter.onChangedPhone,
                      onChangedUsername: presenter.onChangeUsername,
                      phoneFocusNode: phoneFocusNode,
                      usernameFocusNode: usernameFocusNode,
                      onTapContinue: presenter.onTapContinue,
                      state: state,
                      onTapDiscordSignIn: presenter.onTapDiscordLogIn,
                      onTapGoogleSignIn: presenter.onTapGoogleLogIn,
                      onTapAppleSignIn: presenter.onTapAppleLogIn,
                      onChangedCountryCode: (CountryCode value) => presenter.onChangedDialCode(value.dialCode),
                      onEnableUsernameLogin: (isEnabled) => presenter.onEnableUsernameLogin(isEnabled: isEnabled),
                      onTapTerms: presenter.onTapTerms,
                      onTapPolicies: presenter.onTapPolicies,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      );

  String _dialogTitle(PhoneFormViewModel state) {
    switch (state.formType) {
      case OnboardingFlowType.signUp:
        return appLocalizations.registerPhoneFormTitle;
      case OnboardingFlowType.signIn:
      case OnboardingFlowType.discord:
        return appLocalizations.loginPhoneFormTitle;
      case OnboardingFlowType.none:
        return '';
    }
  }

  String _dialogDescription(PhoneFormViewModel state) {
    switch (state.formType) {
      case OnboardingFlowType.signUp:
        return state.isFirebasePhoneAuthEnabled
            ? appLocalizations.registerPhoneFormDescription
            : appLocalizations.registerOnlyOAuthFormDescription;
      case OnboardingFlowType.signIn:
      case OnboardingFlowType.discord:
        return state.isFirebasePhoneAuthEnabled
            ? appLocalizations.loginPhoneFormDescription
            : appLocalizations.loginOnlyOAuthFormDescription;
      case OnboardingFlowType.none:
        return '';
    }
  }
}
