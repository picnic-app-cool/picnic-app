import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/user_mention.dart';

class UpdateUsersToMentionByUserUseCase {
  const UpdateUsersToMentionByUserUseCase();

  PaginatedList<UserMention> execute({
    required PaginatedList<UserMention> usersToMention,
    required UserMention user,
  }) {
    var updatedUsersToMention = usersToMention.copyWith();

    final isContains = updatedUsersToMention.items.any((element) => element.id == user.id);
    if (!isContains) {
      updatedUsersToMention = updatedUsersToMention.copyWith(
        items: List.unmodifiable([...updatedUsersToMention.items, user]),
      );
    }

    return updatedUsersToMention;
  }
}
