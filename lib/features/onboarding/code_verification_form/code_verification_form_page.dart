// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/onboarding/code_verification_form/code_verification_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/code_verification_form/code_verification_form_presenter.dart';
import 'package:picnic_app/features/onboarding/widgets/onboarding_text_input.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

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
  Widget build(BuildContext context) => stateObserver(
        builder: (context, state) {
          final themeData = PicnicTheme.of(context);
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                appLocalizations.codeVerificationTitle,
                                style: themeData.styles.title60,
                              ),
                              const Gap(8),
                              Text(
                                appLocalizations.codeVerificationDescription,
                                style: themeData.styles.body20.copyWith(color: themeData.colors.blackAndWhite.shade600),
                              ),
                            ],
                          ),
                          // ignore: no-magic-number
                          Expanded(child: Assets.images.key.image(scale: 0.7)),
                        ],
                      ),
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
                    ],
                  ),
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
          );
        },
      );
}
