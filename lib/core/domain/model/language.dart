import 'package:equatable/equatable.dart';

class Language extends Equatable {
  const Language({
    required this.title,
    required this.code,
    required this.flag,
  });

  const Language.empty()
      : title = '',
        code = '',
        flag = '';

  const Language.english()
      : title = 'english',
        code = 'eng',
        flag = '🇺🇸';

  final String title;
  final String code;
  final String flag;

  @override
  // TODO: implement props
  List<Object?> get props => [
        title,
        code,
        flag,
      ];

  Language copyWith({
    String? title,
    String? code,
    String? flag,
  }) =>
      Language(
        title: title ?? this.title,
        code: code ?? this.code,
        flag: flag ?? this.flag,
      );
}
