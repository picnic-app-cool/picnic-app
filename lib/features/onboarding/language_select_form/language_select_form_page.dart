// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/onboarding/language_select_form/language_select_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/language_select_form/language_select_form_presenter.dart';
import 'package:picnic_app/features/onboarding/language_select_form/widgets/language_select_form_dialog_content.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/picnic_app.dart';
import 'package:picnic_app/resources/assets.gen.dart';
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
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Gap(24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appLocalizations.languageSelectFormTitle,
                        style: theme.styles.title60,
                      ),
                      const Gap(8),
                      Text(
                        appLocalizations.languageSelectFormDescription,
                        style: theme.styles.body30.copyWith(color: theme.colors.blackAndWhite.shade600),
                      ),
                    ],
                  ),
                  // ignore: no-magic-number
                  Assets.images.languageIcon.image(
                    // ignore: no-magic-number
                    width: 40,
                    // ignore: no-magic-number
                    height: 40,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
              stateObserver(
                builder: (context, state) {
                  return LanguageSelectFormDialogContent(
                    theme: theme,
                    state: state,
                    onTapSelectLanguage: presenter.onTapSelectLanguage,
                    onTapContinue: state.isContinueEnabled ? presenter.onTapContinue : null,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
