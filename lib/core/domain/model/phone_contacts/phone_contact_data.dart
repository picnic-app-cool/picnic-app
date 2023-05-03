import 'package:equatable/equatable.dart';

class PhoneContactData extends Equatable {
  const PhoneContactData(
    this.label,
    this.value,
  );

  const PhoneContactData.empty()
      : label = '',
        value = '';

  final String label;
  final String value;

  @override
  List<Object> get props => [
        label,
        value,
      ];

  PhoneContactData copyWith({
    String? label,
    String? value,
  }) {
    return PhoneContactData(
      label ?? this.label,
      value ?? this.value,
    );
  }
}
