import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/user_mention.dart';
import 'package:picnic_app/features/chat/widgets/chat_mentions/chat_mention_everyone_item.dart';
import 'package:picnic_app/features/chat/widgets/chat_mentions/chat_suggested_users_list_item.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class ChatSuggestedUsersList extends StatelessWidget {
  const ChatSuggestedUsersList({
    required this.suggestedUsersToMention,
    required this.onTapSuggestedMention,
    super.key,
  });

  final PaginatedList<UserMention> suggestedUsersToMention;
  final ValueChanged<UserMention> onTapSuggestedMention;

  static const _borderRadius = 16.0;
  static const _blurRadius = 30.0;
  static const _shadowOpacity = 0.07;

  @override
  Widget build(BuildContext context) {
    final list = suggestedUsersToMention.items;
    final borderRadius = BorderRadius.circular(_borderRadius);
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;

    return Material(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: colors.blackAndWhite.shade100,
          borderRadius: borderRadius,
          boxShadow: [
            BoxShadow(
              blurRadius: _blurRadius,
              color: colors.blackAndWhite.shade900.withOpacity(_shadowOpacity),
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ChatSuggestedUsersListItem(
                    user: list[index],
                    onTapSuggestedMention: onTapSuggestedMention,
                  );
                },
                separatorBuilder: (context, index) => const Gap(24),
                itemCount: list.length,
              ),
              ChatMentionEveryoneItem(onTapSuggestedMention: onTapSuggestedMention),
              const Gap(16),
            ],
          ),
        ),
      ),
    );
  }
}
