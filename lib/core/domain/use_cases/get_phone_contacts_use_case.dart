import 'package:picnic_app/core/domain/model/phone_contacts/phone_contact.dart';
import 'package:picnic_app/core/domain/repositories/contacts_repository.dart';

class GetPhoneContactsUseCase {
  const GetPhoneContactsUseCase(this._contactsRepository);

  final ContactsRepository _contactsRepository;

  Future<List<PhoneContact>> execute() => _contactsRepository.getContacts();
}
