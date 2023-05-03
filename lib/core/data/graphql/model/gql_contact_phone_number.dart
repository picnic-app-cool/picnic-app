import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/model/contact_phone_number.dart';

class GqlContactPhoneNumber {
  GqlContactPhoneNumber({
    required this.label,
    required this.number,
  });

  factory GqlContactPhoneNumber.fromJson(
    Map<String, dynamic> json,
  ) {
    return GqlContactPhoneNumber(
      label: asT<String>(json, 'label'),
      number: asT<String>(json, 'number'),
    );
  }

  final String label;
  final String number;

  ContactPhoneNumber toDomain() => ContactPhoneNumber(
        label: label,
        number: number,
      );
}
