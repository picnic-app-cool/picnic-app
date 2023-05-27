import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/core/domain/model/user.dart';
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
  }) : super(key: key);

  final User user;
  final VoidCallback onTapChatSettings;

  @override
  Size get preferredSize => const Size.fromHeight(Constants.toolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;

    return PicnicAppBar(
      backgroundColor: colors.blackAndWhite.shade100,
      child: InkWell(
        onTap: onTapChatSettings,
        child: FittedBox(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ChatAvatar(
                imageSource: PicnicImageSource.url(
                  user.profileImageUrl,
                  fit: BoxFit.cover,
                ),
                backgroundColor: PicnicColors.primaryButtonBlue,
              ),
              const Gap(8),
              BadgedTitle(
                model: user.toBadgedAuthorDisplayable(formatName: false),
                style: theme.styles.subtitle30,
              ),
              const Gap(12),
              DownArrow(),
            ],
          ),
        ),
      ),
    );
  }
}
