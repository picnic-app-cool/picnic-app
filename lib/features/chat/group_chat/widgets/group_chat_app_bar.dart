import 'package:flutter/material.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_container_icon_button.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class GroupChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GroupChatAppBar({
    required this.name,
    required this.membersCount,
    required this.onlineCount,
    required this.onTapMore,
    this.isOnlineCountVisible = true,
    Key? key,
  }) : super(key: key);

  final String name;
  final int membersCount;
  final int onlineCount;
  final bool isOnlineCountVisible;
  final VoidCallback onTapMore;

  @override
  Size get preferredSize => const Size.fromHeight(Constants.toolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;

    final membersCountText = isOnlineCountVisible
        ? appLocalizations.groupChatSubtitle(membersCount, onlineCount)
        : appLocalizations.membersCount(membersCount);

    final nameView = Text(name, style: theme.styles.body30);
    final membersCountView =
        Text(membersCountText, style: theme.styles.caption10.copyWith(color: colors.blackAndWhite.shade600));

    return PicnicAppBar(
      backgroundColor: colors.blackAndWhite.shade100,
      actions: [
        PicnicContainerIconButton(
          iconPath: Assets.images.moreCircle.path,
          onTap: onTapMore,
        ),
      ],
      child: FittedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            nameView,
            membersCountView,
          ],
        ),
      ),
    );
  }
}
