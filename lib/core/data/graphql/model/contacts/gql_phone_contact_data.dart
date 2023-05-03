import 'package:picnic_app/core/domain/model/phone_contacts/phone_contact_data.dart';

extension GqlPhoneContactData on PhoneContactData {
  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'number': value,
    };
  }
}
