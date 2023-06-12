// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/onboarding/method_form/method_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/method_form/method_form_presenter.dart';
import 'package:picnic_app/features/onboarding/method_form/widgets/method_form_dialog_content.dart';
import 'package:picnic_app/features/onboarding/onboarding_presentation_model.dart';
import 'package:picnic_app/features/onboarding/widgets/spiral.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class MethodFormPage extends StatefulWidget with HasPresenter<MethodFormPresenter> {
  const MethodFormPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final MethodFormPresenter presenter;

  @override
  State<MethodFormPage> createState() => _MethodFormPageState();
}

class _MethodFormPageState extends State<MethodFormPage>
    with PresenterStateMixin<MethodFormViewModel, MethodFormPresenter, MethodFormPage> {
  @override
  Widget build(BuildContext context) => stateObserver(
        buildWhen: (previous, current) => previous.formType != current.formType,
        builder: (context, state) {
          final theme = PicnicTheme.of(context);
          final styles = theme.styles;
          final colors = theme.colors;

          final blue = theme.colors.blue;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              const Spiral(),
              MethodFormDialogContent(
                onTapContinue: presenter.onTapContinue,
                state: state,
                onTapDiscordSignIn: presenter.onTapDiscordLogIn,
                onTapGoogleSignIn: presenter.onTapGoogleLogIn,
                onTapAppleSignIn: presenter.onTapAppleLogIn,
                onTapTerms: presenter.onTapTerms,
                onTapPolicies: presenter.onTapPolicies,
              ),
              const Spacer(),
              if (state.formType == OnboardingFlowType.signUp) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      appLocalizations.alreadyHaveAnAccountMessage,
                      style: styles.body20.copyWith(color: colors.darkBlue.shade600),
                    ),
                    TextButton(
                      onPressed: presenter.onTapLogin,
                      child: Text(
                        appLocalizations.logInAction,
                        style: styles.body20.copyWith(
                          color: blue,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
              ],
            ],
          );
        },
      );
}
