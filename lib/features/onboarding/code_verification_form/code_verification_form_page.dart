// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/core/domain/model/sign_in_method.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/onboarding/code_verification_form/code_verification_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/code_verification_form/code_verification_form_presenter.dart';
import 'package:picnic_app/features/onboarding/widgets/onboarding_page_container.dart';
import 'package:picnic_app/features/onboarding/widgets/onboarding_text_input.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/dialog/picnic_dialog.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class CodeVerificationFormPage extends StatefulWidget with HasPresenter<CodeVerificationFormPresenter> {
  const CodeVerificationFormPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final CodeVerificationFormPresenter presenter;

  @override
  State<CodeVerificationFormPage> createState() => _CodeVerificationFormPageState();
}

class _CodeVerificationFormPageState extends State<CodeVerificationFormPage>
    with PresenterStateMixin<CodeVerificationFormViewModel, CodeVerificationFormPresenter, CodeVerificationFormPage> {
  late FocusNode codeFocusNode;

  @override
  void initState() {
    super.initState();
    codeFocusNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) => codeFocusNode.requestFocus());
  }

  @override
  void dispose() {
    codeFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => OnboardingPageContainer(
        dialog: PicnicDialog(
          image: PicnicAvatar(
            backgroundColor:
                PicnicTheme.of(context).colors.blackAndWhite.shade900.withOpacity(Constants.onboardingImageBgOpacity),
            imageSource: PicnicImageSource.emoji(
              '🔑',
              style: const TextStyle(
                fontSize: Constants.onboardingEmojiSize,
              ),
            ),
          ),
          title: appLocalizations.codeVerificationTitle,
          description: state.isUsernameLogin
              ? state.signInMethod == SignInMethod.phone
                  ? appLocalizations.usernameCodeVerificationDescriptionPhone(state.maskedIdentifier)
                  : appLocalizations.usernameCodeVerificationDescriptionEmail(state.maskedIdentifier)
              : appLocalizations.codeVerificationDescription,
          content: stateObserver(
            builder: (context, state) => SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  OnBoardingTextInput(
                    focusNode: codeFocusNode,
                    initialValue: state.code,
                    hintText: appLocalizations.codeVerificationHint,
                    onChanged: presenter.onChangedCode,
                    errorText: state.errorMessage,
                    isLoading: state.isLoading,
                    inputType: PicnicOnBoardingTextInputType.oneTimePassInput,
                    onPressedResendCode: presenter.onTapResendCode,
                    codeExpiryTime: state.codeExpiryTime,
                    currentTimeProvider: state.currentTimeProvider,
                  ),
                  const Gap(12),
                  PicnicButton(
                    onTap: state.continueEnabled ? presenter.onTapContinue : null,
                    title: appLocalizations.continueAction,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
