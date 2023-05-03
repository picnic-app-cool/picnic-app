import 'package:picnic_app/core/data/graphql/model/contacts/gql_phone_contact_data.dart';
import 'package:picnic_app/core/domain/model/phone_contacts/phone_contact.dart';

extension GqlPhoneContact on PhoneContact {
  Map<String, dynamic> toJson() {
    return {
      'fullName': displayName,
      'familyName': familyName,
      'hasAvatar': avatar != null,
      'hasJobTitle': hasJobTitle,
      'phoneNumber': phones.map((e) => e.toJson()).toList(),
    };
  }
}
