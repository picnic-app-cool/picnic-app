// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/onboarding/language_select_form/language_select_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/language_select_form/language_select_form_presenter.dart';
import 'package:picnic_app/features/onboarding/language_select_form/widgets/language_select_form_dialog_content.dart';
import 'package:picnic_app/features/onboarding/widgets/onboarding_page_container.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/picnic_app.dart';
import 'package:picnic_app/ui/widgets/dialog/picnic_dialog.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class LanguageSelectFormPage extends StatefulWidget with HasPresenter<LanguageSelectFormPresenter> {
  const LanguageSelectFormPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final LanguageSelectFormPresenter presenter;

  @override
  State<LanguageSelectFormPage> createState() => _LanguageSelectFormPageState();
}

class _LanguageSelectFormPageState extends State<LanguageSelectFormPage>
    with PresenterStateMixin<LanguageSelectFormViewModel, LanguageSelectFormPresenter, LanguageSelectFormPage> {
  ///Necessary to call the getLanguages() in presenter
  @override
  void initState() {
    super.initState();
    presenter.onInit();
  }

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);

    return stateListener(
      listenWhen: (previous, current) => previous.selectedLanguage != current.selectedLanguage,
      listener: (context, state) {
        PicnicApp.of(context)?.setLocale(Locale(state.selectedLanguage.code));
      },
      child: Stack(
        children: [
          OnboardingPageContainer(
            dialog: PicnicDialog(
              image: PicnicAvatar(
                borderColor: Colors.transparent,
                backgroundColor: theme.colors.blackAndWhite.shade900.withOpacity(
                  Constants.onboardingImageBgOpacity,
                ),
                imageSource: PicnicImageSource.emoji(
                  Constants.speechEmoji,
                  style: const TextStyle(
                    fontSize: Constants.onboardingEmojiSize,
                  ),
                ),
              ),
              title: appLocalizations.languageSelectFormTitle,
              description: appLocalizations.languageSelectFormDescription,
              content: stateObserver(
                builder: (context, state) {
                  return LanguageSelectFormDialogContent(
                    theme: theme,
                    state: state,
                    onTapSelectLanguage: presenter.onTapSelectLanguage,
                    onTapContinue: state.isContinueEnabled ? presenter.onTapContinue : null,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
