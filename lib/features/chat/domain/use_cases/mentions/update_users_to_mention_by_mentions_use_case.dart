import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/user_mention.dart';
import 'package:picnic_app/utils/extensions/string_formatting.dart';

class UpdateUsersToMentionByMentionsUseCase {
  const UpdateUsersToMentionByMentionsUseCase();

  PaginatedList<UserMention> execute({
    required PaginatedList<UserMention> usersToMention,
    required List<String> mentions,
  }) {
    final items = usersToMention.items;

    // Check if we need to update or not
    final everyContains = items.every(
      (element) => mentions.contains(element.name.formattedUsername),
    );
    final hasSameLength = items.length == mentions.length;
    if (everyContains && hasSameLength) {
      return usersToMention; // Nothing changed
    }

    var updatedUsersToMention = usersToMention.copyWith();

    for (final user in items) {
      final isContains = mentions.contains(user.name.formattedUsername);
      if (!isContains) {
        updatedUsersToMention = updatedUsersToMention.copyWith(
          items: List.unmodifiable([...updatedUsersToMention.items]..remove(user)),
        );
      }
    }

    return updatedUsersToMention;
  }
}
