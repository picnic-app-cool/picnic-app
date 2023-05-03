import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/language.dart';
import 'package:picnic_app/features/main/languages_list/widgets/language_list_item.dart';

class LanguagesListView extends StatelessWidget {
  const LanguagesListView({
    Key? key,
    required this.languages,
    required this.onLanguageSelected,
    required this.selectedLanguage,
  }) : super(key: key);

  final List<Language> languages;
  final Function(Language) onLanguageSelected;
  final Language selectedLanguage;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: languages
          .map(
            (e) => LanguageListItem(
              language: e,
              isSelected: selectedLanguage == e,
              onLanguageSelected: () => onLanguageSelected(e),
            ),
          )
          .toList(),
    );
  }
}
