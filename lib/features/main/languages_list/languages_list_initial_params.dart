import 'package:picnic_app/core/domain/model/language.dart';

class LanguagesListInitialParams {
  const LanguagesListInitialParams({
    required this.selectedLanguage,
  });

  final Language selectedLanguage;
}
