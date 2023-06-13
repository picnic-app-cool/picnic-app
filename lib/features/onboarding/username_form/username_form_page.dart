// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/onboarding/username_form/username_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/username_form/username_form_presenter.dart';
import 'package:picnic_app/features/onboarding/widgets/onboarding_text_input.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class UsernameFormPage extends StatefulWidget with HasPresenter<UsernameFormPresenter> {
  const UsernameFormPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final UsernameFormPresenter presenter;

  @override
  State<UsernameFormPage> createState() => _UsernameFormPageState();
}

class _UsernameFormPageState extends State<UsernameFormPage>
    with PresenterStateMixin<UsernameFormViewModel, UsernameFormPresenter, UsernameFormPage> {
  @override
  Widget build(BuildContext context) {
    final themeData = PicnicTheme.of(context);
    return stateObserver(
      builder: (context, state) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            appLocalizations.yourUsernameTitle,
                            style: themeData.styles.title60,
                          ),
                          const Gap(8),
                          Text(
                            appLocalizations.enterUsernameDescription,
                            style: themeData.styles.body20.copyWith(color: themeData.colors.blackAndWhite.shade600),
                          ),
                        ],
                      ),
                      // ignore: no-magic-number
                      Assets.images.usernameIcon.image(scale: 0.9),
                    ],
                  ),
                  const Gap(8),
                  OnBoardingTextInput(
                    initialValue: state.username,
                    hintText: appLocalizations.usernameHint,
                    onChanged: presenter.onChangedUsername,
                    errorText: state.usernameErrorText,
                    isLoading: state.isLoading,
                  ),
                ],
              ),
              PicnicButton(
                onTap: state.continueEnabled ? presenter.onTapContinue : null,
                title: appLocalizations.continueAction,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
