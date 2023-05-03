// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/onboarding/age_form/age_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/age_form/age_form_presenter.dart';
import 'package:picnic_app/features/onboarding/widgets/onboarding_page_container.dart';
import 'package:picnic_app/features/onboarding/widgets/onboarding_text_input.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/dialog/picnic_dialog.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
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
  Widget build(BuildContext context) => OnboardingPageContainer(
        dialog: PicnicDialog(
          image: PicnicAvatar(
            backgroundColor:
                PicnicTheme.of(context).colors.blackAndWhite.shade900.withOpacity(Constants.onboardingImageBgOpacity),
            imageSource: PicnicImageSource.emoji(
              '🎂',
              style: const TextStyle(
                fontSize: Constants.onboardingEmojiLargeSize,
              ),
            ),
          ),
          title: appLocalizations.yourAgeTitle,
          description: appLocalizations.yourAgeDescription,
          content: stateObserver(
            builder: (context, state) => SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  OnBoardingTextInput(
                    initialValue: state.ageText,
                    hintText: appLocalizations.ageHint,
                    errorText: state.ageErrorText,
                    onChanged: presenter.onChangedAge,
                    keyboardType: TextInputType.number,
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
