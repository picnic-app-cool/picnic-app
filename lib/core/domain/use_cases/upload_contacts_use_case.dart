import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/upload_contacts_failure.dart';
import 'package:picnic_app/core/domain/repositories/contacts_repository.dart';

class UploadContactsUseCase {
  const UploadContactsUseCase(this._contactsRepository);

  final ContactsRepository _contactsRepository;

  Future<Either<UploadContactsFailure, Unit>> execute() async {
    final contacts = await _contactsRepository.getContacts();
    return _contactsRepository.uploadContacts(contacts: contacts);
  }
}
