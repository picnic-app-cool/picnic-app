import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/onboarding/language_select_form/language_select_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/language_select_form/language_select_form_presenter.dart';
import 'package:picnic_app/features/onboarding/language_select_form/widgets/language_select_form_dialog_content.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/picnic_app.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_text_button.dart';

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
  static const _contentPadding = EdgeInsets.only(
    left: 24.0,
    right: 24.0,
    top: Constants.toolbarHeight + 24.0,
  );

  ///Necessary to call the getLanguages() in presenter
  @override
  void initState() {
    super.initState();
    presenter.onInit();
  }

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);

    final textColor = theme.colors.blackAndWhite.shade600;

    return stateListener(
      listenWhen: (previous, current) => previous.selectedLanguage != current.selectedLanguage,
      listener: (context, state) {
        PicnicApp.of(context)?.setLocale(Locale(state.selectedLanguage.code));
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: _contentPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
                          style: theme.styles.body30.copyWith(color: textColor),
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
                const Gap(36),
                stateObserver(
                  builder: (context, state) {
                    return LanguageSelectFormDialogContent(
                      theme: theme,
                      state: state,
                      onTapSelectLanguage: presenter.onTapSelectLanguage,
                    );
                  },
                ),
                const Spacer(),
                PicnicButton(
                  onTap: state.isContinueEnabled ? presenter.onTapContinue : null,
                  color: theme.colors.blue,
                  title: appLocalizations.continueAction,
                ),
                const Gap(6),
                PicnicTextButton(
                  onTap: presenter.onTapContinue,
                  label: appLocalizations.skipAction,
                  labelStyle: theme.styles.body20.copyWith(color: textColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
