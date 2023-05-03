// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/onboarding/congrats_form/congrats_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/congrats_form/congrats_form_presenter.dart';
import 'package:picnic_app/features/onboarding/widgets/onboarding_page_container.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/dialog/picnic_dialog.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class CongratsFormPage extends StatefulWidget with HasPresenter<CongratsFormPresenter> {
  const CongratsFormPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final CongratsFormPresenter presenter;

  @override
  State<CongratsFormPage> createState() => _CongratsFormPageState();
}

class _CongratsFormPageState extends State<CongratsFormPage>
    with PresenterStateMixin<CongratsFormViewModel, CongratsFormPresenter, CongratsFormPage> {
  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    return OnboardingPageContainer(
      dialog: PicnicDialog(
        image: PicnicAvatar(
          backgroundColor: theme.colors.blackAndWhite.shade900.withOpacity(Constants.onboardingImageBgOpacity),
          imageSource: PicnicImageSource.emoji(
            '🎉',
            style: const TextStyle(
              fontSize: Constants.onboardingEmojiSize,
            ),
          ),
        ),
        title: appLocalizations.congratsFormTitle,
        description: appLocalizations.congratsFormDescription,
        content: stateObserver(
          builder: (context, state) => SizedBox(
            width: double.infinity,
            child: PicnicButton(
              onTap: presenter.onTapContinue,
              title: appLocalizations.continueAction,
            ),
          ),
        ),
      ),
    );
  }
}
