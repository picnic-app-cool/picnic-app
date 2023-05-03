import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/features/chat/widgets/chat_avatar.dart';
import 'package:picnic_app/features/chat/widgets/down_arrow.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_circle_avatar.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class CircleChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CircleChatAppBar({
    Key? key,
    required this.onTapChatSettings,
    required this.name,
    required this.emoji,
    required this.image,
    required this.membersCount,
  }) : super(key: key);

  final String name;
  final String emoji;
  final String image;
  final int membersCount;
  final VoidCallback onTapChatSettings;

  @override
  Size get preferredSize => const Size.fromHeight(Constants.toolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;

    final membersCountText = appLocalizations.membersCount(membersCount);
    final nameView = Text(name, style: theme.styles.body30);
    final membersCountView =
        Text(membersCountText, style: theme.styles.caption10.copyWith(color: colors.blackAndWhite.shade600));

    return PicnicAppBar(
      iconPathLeft: Assets.images.backArrow.path,
      showBackButton: true,
      backgroundColor: colors.blackAndWhite.shade100,
      child: FittedBox(
        child: InkWell(
          onTap: onTapChatSettings,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              PicnicCircleAvatar(
                emoji: emoji,
                image: image,
                emojiSize: Constants.emojiSize,
                avatarSize: ChatAvatar.avatarSize,
                bgColor: colors.blackAndWhite.shade200,
              ),
              const Gap(8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  nameView,
                  membersCountView,
                ],
              ),
              const Gap(8),
              DownArrow(),
            ],
          ),
        ),
      ),
    );
  }
}
