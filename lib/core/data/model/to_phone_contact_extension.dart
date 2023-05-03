import 'package:contacts_service/contacts_service.dart';
import 'package:picnic_app/core/domain/model/phone_contacts/phone_contact.dart';
import 'package:picnic_app/core/domain/model/phone_contacts/phone_contact_data.dart';

extension ToPhoneContactExtension on Contact {
  PhoneContact toPhoneContact() => PhoneContact.empty().copyWith(
        displayName: displayName ?? '',
        familyName: familyName ?? '',
        avatar: avatar,
        hasJobTitle: jobTitle?.isNotEmpty ?? false,
        phones: phones?.map((e) => e.toPhoneContactData()).toList() ?? [],
      );
}

extension PhoneContactDataExtension on Item {
  PhoneContactData toPhoneContactData() => PhoneContactData(
        label ?? '',
        value ?? '',
      );
}
