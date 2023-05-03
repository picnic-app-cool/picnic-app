import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/get_user_contact_failure.dart';
import 'package:picnic_app/core/domain/model/mention_user_failure.dart';
import 'package:picnic_app/core/domain/model/notify_contact_failure.dart';
import 'package:picnic_app/core/domain/model/notify_meta.dart';
import 'package:picnic_app/core/domain/model/notify_type.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/phone_contacts/phone_contact.dart';
import 'package:picnic_app/core/domain/model/upload_contacts_failure.dart';
import 'package:picnic_app/core/domain/model/user_contact.dart';
import 'package:picnic_app/core/domain/model/user_mention.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

abstract class ContactsRepository {
  Future<List<PhoneContact>> getContacts();

  Future<Either<GetUserContactFailure, PaginatedList<UserContact>>> getSavedContacts({
    required Cursor nextPageCursor,
    required String? searchQuery,
  });

  Future<Either<UploadContactsFailure, Unit>> uploadContacts({required List<PhoneContact> contacts});

  Future<Either<NotifyContactFailure, Unit>> notifyContact({
    required Id contactId,
    required Id? entityId,
    required NotifyType notifyType,
  });

  Future<Either<MentionUserFailure, PaginatedList<UserMention>>> getUserMentions({
    required String searchQuery,
    required NotifyMeta? notifyMeta,
  });
}
