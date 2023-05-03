import 'package:flutter/material.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class ChatMoreAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatMoreAppBar({
    required this.title,
    required this.subtitle,
    Key? key,
  }) : super(key: key);

  final String title;
  final String subtitle;

  @override
  Size get preferredSize => const Size.fromHeight(Constants.toolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;

    return PicnicAppBar(
      child: FittedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: theme.styles.body30),
            Text(subtitle, style: theme.styles.caption10.copyWith(color: colors.blackAndWhite.shade600)),
          ],
        ),
      ),
    );
  }
}
