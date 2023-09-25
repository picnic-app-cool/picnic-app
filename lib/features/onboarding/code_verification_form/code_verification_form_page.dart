import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/core/domain/model/sign_in_method.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/onboarding/code_verification_form/code_verification_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/code_verification_form/code_verification_form_presenter.dart';
import 'package:picnic_app/features/onboarding/widgets/onboarding_text_input.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/theme/picnic_colors.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';
import 'package:pinput/pinput.dart';

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
  late TextEditingController codeController;

  static const _contentPadding = EdgeInsets.only(
    left: 24.0,
    right: 24.0,
    top: Constants.toolbarHeight + 24.0,
    bottom: 16.0,
  );

  static const _borderWidth = 2.0;

  final _pinBorderRadius = BorderRadius.circular(12);

  @override
  void initState() {
    super.initState();
    codeFocusNode = FocusNode();
    codeController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) => codeFocusNode.requestFocus());
  }

  @override
  void dispose() {
    codeFocusNode.dispose();
    codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final pinTextStyle = theme.styles.body20.copyWith(color: theme.colors.darkBlue.shade800);
    final pinTheme = PinTheme(
      width: 50,
      height: 50,
      textStyle: pinTextStyle,
    );

    final filledBorderColor = theme.colors.darkBlue.shade900;
    final pinkColor = theme.colors.pink;
    final errorBorderColor = pinkColor.shade400;
    final errorFillColor = pinkColor.shade100;

    return stateObserver(
      builder: (context, state) {
        final themeData = PicnicTheme.of(context);
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: _contentPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  appLocalizations.codeVerificationTitle,
                                  style: themeData.styles.title60,
                                ),
                                const Gap(8),
                                Text(
                                  state.isUsernameLogin
                                      ? state.signInMethod == SignInMethod.phone
                                          ? appLocalizations
                                              .usernameCodeVerificationDescriptionPhone(state.maskedIdentifier)
                                          : appLocalizations
                                              .usernameCodeVerificationDescriptionEmail(state.maskedIdentifier)
                                      : appLocalizations.codeVerificationDescription,
                                  style:
                                      themeData.styles.body30.copyWith(color: themeData.colors.blackAndWhite.shade600),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          // ignore: no-magic-number
                          Assets.images.key.image(
                            // ignore: no-magic-number
                            width: 40,
                            // ignore: no-magic-number
                            height: 40,
                            // ignore: no-magic-number

                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                      const Gap(24),
                      Pinput(
                        length: state.codeLength,
                        defaultPinTheme: pinTheme.copyWith(
                          decoration: BoxDecoration(
                            color: PicnicColors.ultraPaleGrey,
                            borderRadius: _pinBorderRadius,
                          ),
                        ),
                        submittedPinTheme: pinTheme.copyWith(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: filledBorderColor,
                              width: _borderWidth,
                            ),
                            borderRadius: _pinBorderRadius,
                          ),
                        ),
                        errorPinTheme: pinTheme.copyWith(
                          decoration: BoxDecoration(
                            color: errorFillColor,
                            border: Border.all(
                              color: errorBorderColor,
                              width: _borderWidth,
                            ),
                            borderRadius: _pinBorderRadius,
                          ),
                        ),
                        controller: codeController,
                        onChanged: presenter.onChangedCode,
                        forceErrorState: state.isError,
                        cursor: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              //ignore: no-magic-number
                              width: 12,
                              height: 1,
                              color: theme.colors.blackAndWhite.shade600,
                            ),
                          ],
                        ),
                      ),
                      const Gap(12),
                      Row(
                        children: [
                          OneTimePassTimer(
                            onTapResendOTP: _onTapResend,
                            currentTimeProvider: state.currentTimeProvider,
                            codeExpiryTime: state.codeExpiryTime,
                            padding: EdgeInsets.zero,
                          ),
                          const Spacer(),
                          if (state.isError)
                            InkWell(
                              onTap: _errorTextPressed,
                              child: Text(
                                appLocalizations.codeVerificationError,
                                style: themeData.styles.body10.copyWith(color: themeData.colors.pink.shade500),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      PicnicButton(
                        onTap: state.continueEnabled ? presenter.onTapContinue : null,
                        title: appLocalizations.continueAction,
                        minWidth: double.infinity,
                      ),
                      PicnicLoadingIndicator(isLoading: state.isLoading),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _onTapResend() {
    codeController.clear();
    presenter.onChangedCode("");
    presenter.onTapResendCode();
  }

  void _errorTextPressed() {
    codeController.clear();
    presenter.onChangedCode("");
  }
}
