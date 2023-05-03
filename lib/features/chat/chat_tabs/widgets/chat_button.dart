import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/features/chat/domain/model/chat_tab_type.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class ChatButton extends StatelessWidget {
  const ChatButton({
    Key? key,
    required this.type,
    this.onTap,
    this.leadingIcon,
    this.labelStyle,
  }) : super(key: key);

  final ChatTabType type;
  final VoidCallback? onTap;
  final TextStyle? labelStyle;
  final Widget? leadingIcon;

  static const double kBadgeSize = 16;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final labelColor = colors.blackAndWhite.shade600;

    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        foregroundColor: labelStyle?.color ?? labelColor,
        shape: const StadiumBorder(),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (leadingIcon != null) ...[
            leadingIcon!,
            const Gap(7),
          ],
          Text(
            type.label,
            style: labelStyle ??
                theme.styles.caption10.copyWith(
                  color: labelColor,
                ),
          ),
        ],
      ),
    );
  }
}
