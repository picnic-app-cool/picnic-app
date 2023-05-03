import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/get_user_contact_failure.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/user_contact.dart';
import 'package:picnic_app/core/domain/repositories/contacts_repository.dart';

class GetContactsUseCase {
  const GetContactsUseCase(this._contactsRepository);

  final ContactsRepository _contactsRepository;

  Future<Either<GetUserContactFailure, PaginatedList<UserContact>>> execute({
    required Cursor nextPageCursor,
    required String? searchQuery,
  }) =>
      _contactsRepository.getSavedContacts(nextPageCursor: nextPageCursor, searchQuery: searchQuery);
}
