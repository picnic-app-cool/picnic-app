import 'package:flutter/material.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PicnicCommentAction extends StatelessWidget {
  const PicnicCommentAction({
    Key? key,
    required this.count,
    required this.iconPath,
    this.onTap,
    this.iconColor,
    this.overlay = false,
  }) : super(key: key);

  final int count;
  final bool overlay;
  final String iconPath;
  final VoidCallback? onTap;
  final Color? iconColor;

  static const _iconSize = 18.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final whiteColor = colors.blackAndWhite.shade100;
    final greyColor = colors.blackAndWhite.shade600;
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            iconPath,
            width: _iconSize,
            height: _iconSize,
            color: iconColor,
          ),
          Text(
            count.toString(),
            style: theme.styles.body0.copyWith(
              color: overlay ? whiteColor : greyColor,
            ),
          ),
        ],
      ),
    );
  }
}
