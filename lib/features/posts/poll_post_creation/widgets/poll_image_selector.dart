import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/user_mention.dart';
import 'package:picnic_app/features/posts/domain/model/images_poll_form.dart';
import 'package:picnic_app/features/posts/poll_post_creation/widgets/poll_image.dart';

class PollImageSelector extends StatelessWidget {
  const PollImageSelector({
    super.key,
    required this.onTapLeft,
    required this.onTapRight,
    required this.pollForm,
    required this.isMentionsPollPostCreationEnabled,
    this.onChanged,
    this.suggestedUsersToMention,
    this.onTapSuggestedMentionLeft,
    this.onTapSuggestedMentionRight,
  });

  final VoidCallback onTapLeft;
  final VoidCallback onTapRight;
  final ImagesPollForm pollForm;
  final ValueChanged<String>? onChanged;
  final PaginatedList<UserMention>? suggestedUsersToMention;
  final ValueChanged<UserMention>? onTapSuggestedMentionLeft;
  final ValueChanged<UserMention>? onTapSuggestedMentionRight;
  final bool isMentionsPollPostCreationEnabled;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: PollImage(
            offSet: const Offset(0, 8),
            imagePath: pollForm.leftImagePath,
            onTap: onTapLeft,
            onChanged: onChanged,
            suggestedUsersToMention: suggestedUsersToMention,
            onTapSuggestedMention: onTapSuggestedMentionLeft,
            mentionedUser: pollForm.leftMentionedUser,
            isMentionsPollPostCreationEnabled: isMentionsPollPostCreationEnabled,
          ),
        ),
        const Gap(7),
        Expanded(
          child: PollImage(
            offSet: const Offset(-184, 8),
            imagePath: pollForm.rightImagePath,
            onTap: onTapRight,
            onChanged: onChanged,
            suggestedUsersToMention: suggestedUsersToMention,
            onTapSuggestedMention: onTapSuggestedMentionRight,
            mentionedUser: pollForm.rightMentionedUser,
            isMentionsPollPostCreationEnabled: isMentionsPollPostCreationEnabled,
          ),
        ),
      ],
    );
  }
}
