import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/mention_user_failure.dart';
import 'package:picnic_app/core/domain/model/notify_meta.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/user_mention.dart';
import 'package:picnic_app/core/domain/repositories/contacts_repository.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';

class MentionUserUseCase {
  const MentionUserUseCase(
    this._contactsRepository,
  );

  final ContactsRepository _contactsRepository;

  Future<Either<MentionUserFailure, PaginatedList<UserMention>>> execute({
    required String query,
    required NotifyMeta notifyMeta,
    bool ignoreAtSign = false,
  }) {
    final words = query.split(' ');
    final mention = words.isNotEmpty && (words.last.startsWith('@') || ignoreAtSign) ? words.last : '';

    // Trim @ at the beginning
    final searchText = ignoreAtSign || mention.isEmpty ? mention : mention.substring(1);

    // Return an empty list to hide hints if:
    // - enter a space after the mention (a word with @ at the beginning)
    // - the last word in message doesn't contain @
    if (query.endsWith(' ') || searchText.isEmpty) {
      return Future.value(success(const PaginatedList.empty()));
    }

    return _contactsRepository
        .getUserMentions(
          searchQuery: searchText,
          notifyMeta: notifyMeta,
        )
        .mapSuccess((list) => list)
        .mapFailure((fail) => MentionUserFailure.unknown(fail));
  }
}
