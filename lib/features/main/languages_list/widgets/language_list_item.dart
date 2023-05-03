import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/language.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class LanguageListItem extends StatelessWidget {
  const LanguageListItem({
    Key? key,
    required this.onLanguageSelected,
    required this.language,
    required this.isSelected,
  }) : super(key: key);

  final VoidCallback onLanguageSelected;
  final Language language;
  final bool isSelected;

  static const _borderRadius = 12.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    return InkWell(
      onTap: onLanguageSelected,
      child: Container(
        padding: const EdgeInsets.all(11),
        decoration: BoxDecoration(
          color: isSelected ? theme.colors.green.shade300 : null,
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        child: Text(
          language.flag + language.title,
          style: theme.styles.body30,
        ),
      ),
    );
  }
}
