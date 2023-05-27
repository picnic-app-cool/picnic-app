import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/language.dart';
import 'package:picnic_app/features/onboarding/language_select_form/language_select_form_presentation_model.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme_data.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class LanguageSelectFormDialogContent extends StatelessWidget {
  const LanguageSelectFormDialogContent({
    Key? key,
    required this.theme,
    required this.state,
    required this.onTapContinue,
    required this.onTapSelectLanguage,
  }) : super(key: key);

  final PicnicThemeData theme;
  final LanguageSelectFormViewModel state;
  final VoidCallback? onTapContinue;
  final void Function(Language) onTapSelectLanguage;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (state.errorMessage.isNotEmpty)
          Text(
            state.errorMessage,
            style: theme.styles.caption10.copyWith(color: theme.colors.red),
          ),
        if (state.isLoading) const PicnicLoadingIndicator(),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: state.languages.length,
          itemBuilder: (BuildContext context, int index) {
            final language = state.languages[index];
            return _LanguageSelectButton(
              theme: theme,
              isSelected: language == state.selectedLanguage,
              language: language,
              onTapSelectLanguage: onTapSelectLanguage,
            );
          },
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1 / .35,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
        ),
        const Gap(12),
        PicnicButton(
          onTap: onTapContinue,
          color: theme.colors.blue,
          title: appLocalizations.continueAction,
        ),
      ],
    );
  }
}

class _LanguageSelectButton extends StatelessWidget {
  const _LanguageSelectButton({
    Key? key,
    required this.theme,
    this.isSelected = false,
    required this.language,
    required this.onTapSelectLanguage,
  }) : super(key: key);

  final PicnicThemeData theme;
  final bool isSelected;
  final Language language;
  final void Function(Language) onTapSelectLanguage;

  static const _selectedBorderWidth = 3.0;
  static const _unselectedBorderWidth = 1.0;
  static const _lowOpacity = .2;
  static const _languageSelectButtonPadding = EdgeInsets.all(10);

  @override
  Widget build(BuildContext context) {
    final colors = theme.colors;

    return PicnicButton(
      borderRadius: const PicnicButtonRadius.semiRound(),
      emoji: language.flag,
      color: isSelected ? colors.blue.withOpacity(_lowOpacity) : Colors.transparent,
      borderColor: isSelected ? colors.blue : colors.blackAndWhite.shade400,
      style: PicnicButtonStyle.outlined,
      padding: _languageSelectButtonPadding,
      titleStyle: theme.styles.body30,
      borderWidth: isSelected ? _selectedBorderWidth : _unselectedBorderWidth,
      onTap: () => onTapSelectLanguage(language),
      title: language.title,
    );
  }
}
