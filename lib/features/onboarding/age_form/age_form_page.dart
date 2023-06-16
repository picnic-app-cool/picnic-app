// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/onboarding/age_form/age_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/age_form/age_form_presenter.dart';
import 'package:picnic_app/features/onboarding/widgets/onboarding_text_input.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class AgeFormPage extends StatefulWidget with HasPresenter<AgeFormPresenter> {
  const AgeFormPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final AgeFormPresenter presenter;

  @override
  State<AgeFormPage> createState() => _AgeFormPageState();
}

class _AgeFormPageState extends State<AgeFormPage>
    with PresenterStateMixin<AgeFormViewModel, AgeFormPresenter, AgeFormPage> {
  @override
  Widget build(BuildContext context) => stateObserver(
        builder: (context, state) {
          final themeData = PicnicTheme.of(context);
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                appLocalizations.yourAgeTitle,
                                style: themeData.styles.title60,
                              ),
                              const Gap(8.0),
                              Text(
                                appLocalizations.yourAgeDescription,
                                style: themeData.styles.body30.copyWith(color: themeData.colors.blackAndWhite.shade600),
                              ),
                            ],
                          ),
                          // ignore: no-magic-number
                          Assets.images.cake.image(scale: 0.7),
                        ],
                      ),
                      const Gap(24),
                      OnBoardingTextInput(
                        initialValue: state.ageText,
                        hintText: appLocalizations.ageHint,
                        errorText: state.ageErrorText,
                        onChanged: presenter.onChangedAge,
                        keyboardType: TextInputType.number,
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
          );
        },
      );
}
