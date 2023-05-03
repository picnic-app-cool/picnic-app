import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PicnicTextButton extends StatelessWidget {
  const PicnicTextButton({
    super.key,
    required this.label,
    this.onTap,
    this.leadingIcon,
    this.labelStyle,
    this.padding,
    this.alignment,
  });

  final VoidCallback? onTap;
  final String label;
  final TextStyle? labelStyle;
  final Widget? leadingIcon;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry? alignment;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final labelColor = theme.colors.blackAndWhite.shade600;

    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        foregroundColor: labelStyle?.color ?? labelColor,
        shape: const StadiumBorder(),
        padding: padding,
        alignment: alignment,
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
            label,
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
