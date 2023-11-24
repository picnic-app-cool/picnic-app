import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/features/chat/domain/model/basic_chat.dart';
import 'package:picnic_app/features/chat/widgets/chat_avatar.dart';
import 'package:picnic_app/features/chat/widgets/down_arrow.dart';
import 'package:picnic_app/ui/widgets/achievement_badge/badged_title.dart';
import 'package:picnic_app/ui/widgets/achievement_badge/model/badged_title_displayable.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_colors.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class SingleChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SingleChatAppBar({
    Key? key,
    required this.user,
    required this.onTapChatSettings,
    required this.isLoading,
    required this.chat,
  }) : super(key: key);

  final User user;
  final VoidCallback onTapChatSettings;
  final bool isLoading;
  final BasicChat chat;

  @override
  Size get preferredSize => const Size.fromHeight(Constants.toolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final userAbandoned = user.id.isNone;

    final userAbandonedAvatarSource = PicnicImageSource.url(
      chat.image,
      fit: BoxFit.cover,
    );
    final userEmptyAvatarSource = PicnicImageSource.emoji(
      Constants.smileEmoji,
      style: const TextStyle(fontSize: 26.0),
    );
    final userAvatarSource = PicnicImageSource.url(
      user.profileImageUrl,
      fit: BoxFit.cover,
    );
    final avatarWidget = ChatAvatar(
      imageSource: userAbandoned
          ? userAbandonedAvatarSource
          : user.profileImageUrl.url.isEmpty
              ? userEmptyAvatarSource
              : userAvatarSource,
      backgroundColor: PicnicColors.primaryButtonBlue,
    );
    final chatTitle = userAbandoned //
        ? BadgedTitleDisplayable(name: chat.name)
        : user.toBadgedAuthorDisplayable(formatName: false);

    return PicnicAppBar(
      backgroundColor: colors.blackAndWhite.shade100,
      child: isLoading
          ? const SizedBox.shrink()
          : InkWell(
              onTap: !userAbandoned ? onTapChatSettings : null,
              child: FittedBox(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    avatarWidget,
                    const Gap(8),
                    BadgedTitle(
                      model: chatTitle,
                      style: theme.styles.subtitle30,
                    ),
                    const Gap(12),
                    if (!userAbandoned) DownArrow(),
                  ],
                ),
              ),
            ),
    );
  }
}
