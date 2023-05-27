import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/language.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class LanguageSelectButton extends StatelessWidget {
  const LanguageSelectButton({
    Key? key,
    this.isSelected = false,
    required this.language,
    required this.onTapSelectLanguage,
  }) : super(key: key);

  final bool isSelected;
  final Language language;
  final void Function(Language) onTapSelectLanguage;

  static const _selectedBorderWidth = 3.0;
  static const _unselectedBorderWidth = 1.0;
  static const _lowOpacity = .2;
  static const _languageSelectButtonPadding = EdgeInsets.all(16);

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;

    return PicnicButton(
      borderRadius: const PicnicButtonRadius.semiRound(),
      emoji: language.flag,
      color: isSelected ? colors.blue.withOpacity(_lowOpacity) : Colors.transparent,
      borderColor: isSelected ? colors.blue : colors.blackAndWhite.shade400,
      style: PicnicButtonStyle.outlined,
      padding: _languageSelectButtonPadding,
      titleStyle: theme.styles.body30,
      onTap: () => onTapSelectLanguage(language),
      borderWidth: isSelected ? _selectedBorderWidth : _unselectedBorderWidth,
      title: language.title,
    );
  }
}
