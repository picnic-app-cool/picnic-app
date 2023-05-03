import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/features/posts/domain/model/basic_comment.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/utils/extensions/string_formatting.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class CommentChatReplyBar extends StatelessWidget {
  const CommentChatReplyBar({
    required this.comment,
    required this.onTapCancelReply,
  });

  final BasicComment comment;
  final VoidCallback? onTapCancelReply;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final textStyleBody10 = theme.styles.body10;
    final textStyleCaption10 = theme.styles.caption10;
    final title = appLocalizations.chatReply(
      comment.author.username.formattedUsername,
    );

    final blackAndWhite = theme.colors.blackAndWhite;
    final darkBlue = theme.colors.darkBlue;

    final textColor = blackAndWhite.shade900.withOpacity(0.6);

    final replyIcon = Image.asset(
      Assets.images.reply.path,
      color: darkBlue.shade600.withOpacity(0.5),
      height: 18,
      width: 18,
    );

    final verticalDivider = Container(
      color: theme.colors.green.shade600,
      width: 1.5,
      height: 32,
      margin: const EdgeInsets.symmetric(vertical: 2.5),
    );

    final closeIcon = Image.asset(
      Assets.images.close.path,
      width: 18,
      color: darkBlue.shade600,
    );

    return Row(
      children: [
        const Gap(6),
        replyIcon,
        const Gap(12),
        verticalDivider,
        const Gap(8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: textStyleBody10.copyWith(
                  color: textColor,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              const Gap(1),
              Text(
                comment.text,
                style: textStyleCaption10.copyWith(
                  color: textColor,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),
        InkWell(
          onTap: onTapCancelReply,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: closeIcon,
          ),
        ),
      ],
    );
  }
}
