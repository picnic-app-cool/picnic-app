import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/notify_contact_failure.dart';
import 'package:picnic_app/core/domain/model/notify_type.dart';
import 'package:picnic_app/core/domain/repositories/contacts_repository.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class NotifyContactUseCase {
  const NotifyContactUseCase(this._contactsRepository);

  final ContactsRepository _contactsRepository;

  Future<Either<NotifyContactFailure, Unit>> execute({
    required Id contactId,
    Id? entityId,
    required NotifyType notifyType,
  }) async {
    return _contactsRepository.notifyContact(
      entityId: entityId,
      contactId: contactId,
      notifyType: notifyType,
    );
  }
}
