import 'package:picnic_app/core/data/utils/safe_convert.dart';

class GqlWord {
  const GqlWord({
    required this.word,
  });

  factory GqlWord.fromJson(Map<String, dynamic> json) => GqlWord(
        word: asT(
          json,
          'word',
        ),
      );

  final String word;

  String toDomain() => word;
}
