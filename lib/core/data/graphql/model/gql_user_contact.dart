import 'package:picnic_app/core/data/graphql/model/gql_contact_phone_number.dart';
import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/model/user_contact.dart';
import 'package:picnic_app/core/utils/string_normalizer.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class GqlUserContact {
  GqlUserContact({
    required this.id,
    required this.name,
    required this.contactPhoneNumber,
  });

  factory GqlUserContact.fromJson(
    Map<String, dynamic> json,
  ) {
    return GqlUserContact(
      id: asT<String>(json, 'id'),
      name: asT<String>(json, 'name'),
      contactPhoneNumber: GqlContactPhoneNumber.fromJson(
        asT<Map<String, dynamic>>(json, 'phone'),
      ),
    );
  }

  final String id;
  final String name;
  final GqlContactPhoneNumber contactPhoneNumber;

  UserContact toDomain() => UserContact(
        id: Id(id),
        name: normalizeString(name),
        invited: false,
        contactPhoneNumber: contactPhoneNumber.toDomain(),
      );
}
