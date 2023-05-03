import 'package:equatable/equatable.dart';

class ContactPhoneNumber extends Equatable {
  const ContactPhoneNumber({
    required this.label,
    required this.number,
  });

  const ContactPhoneNumber.empty()
      : label = '',
        number = '';

  final String label;
  final String number;

  @override
  List<Object?> get props => [label, number];

  ContactPhoneNumber copyWith({
    String? label,
    String? number,
  }) {
    return ContactPhoneNumber(
      label: label ?? this.label,
      number: number ?? this.number,
    );
  }
}
