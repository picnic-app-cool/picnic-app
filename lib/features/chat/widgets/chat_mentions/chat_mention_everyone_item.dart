import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/user_mention.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class ChatMentionEveryoneItem extends StatelessWidget {
  const ChatMentionEveryoneItem({
    required this.onTapSuggestedMention,
    super.key,
  });

  final ValueChanged<UserMention> onTapSuggestedMention;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final styles = theme.styles;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      // TODO: Should be changed due to BE implementation
      // https://picnic-app.atlassian.net/browse/GS-5832
      onTap: () => onTapSuggestedMention(const _EveryoneMention.empty()),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Gap(16),
          Divider(
            height: 0,
            thickness: 1,
            color: colors.blackAndWhite.shade300,
          ),
          const Gap(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Assets.images.usersBold.image(),
              Text(
                // TODO: Maybe be changed due to BE implementation
                // https://picnic-app.atlassian.net/browse/GS-5832
                '@${appLocalizations.mentionEveryoneText}',
                style: styles.body20.copyWith(color: colors.darkBlue.shade600),
              ),
              const Gap(4),
              Text(
                appLocalizations.mentionEveryoneCaption,
                style: styles.caption10.copyWith(color: colors.blackAndWhite.shade600),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// TODO: Dummy class due to waiting for BE implementation
// https://picnic-app.atlassian.net/browse/GS-5832
class _EveryoneMention extends UserMention {
  const _EveryoneMention.empty() : super.empty();

  @override
  String get name => 'everyone';
}
