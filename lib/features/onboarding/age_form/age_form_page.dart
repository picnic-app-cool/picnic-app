import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/constants/constants.dart';
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
  static const _contentPadding = EdgeInsets.only(
    left: 24.0,
    right: 24.0,
    top: Constants.toolbarHeight + 24.0,
    bottom: 16.0,
  );

  @override
  Widget build(BuildContext context) => stateObserver(
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
                                  style:
                                      themeData.styles.body30.copyWith(color: themeData.colors.blackAndWhite.shade600),
                                ),
                              ],
                            ),
                            // ignore: no-magic-number
                            Assets.images.cake.image(),
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
                    const Spacer(),
                    PicnicButton(
                      onTap: state.continueEnabled ? presenter.onTapContinue : null,
                      title: appLocalizations.continueAction,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
}
