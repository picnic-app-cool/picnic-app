import 'package:equatable/equatable.dart';

class CountryWithDialCode extends Equatable {
  const CountryWithDialCode({
    required this.code,
    required this.name,
    required this.flag,
  });

  const CountryWithDialCode.empty()
      : code = '',
        name = '',
        flag = '';

  final String code;
  final String name;
  final String flag;

  @override
  List<Object> get props => [
        code,
        name,
        flag,
      ];

  CountryWithDialCode copyWith({
    String? name,
    String? code,
    String? flag,
  }) {
    return CountryWithDialCode(
      code: code ?? this.code,
      name: name ?? this.name,
      flag: flag ?? this.flag,
    );
  }
}
