import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PicnicMelonsCountLabel extends StatelessWidget {
  const PicnicMelonsCountLabel({
    Key? key,
    required this.label,
    this.backgroundColor,
    this.suffix,
    this.prefix,
    this.padding,
    this.labelStyle,
  }) : super(key: key);

  final String label;
  final Color? backgroundColor;
  final Widget? suffix;
  final Widget? prefix;
  final EdgeInsets? padding;
  final TextStyle? labelStyle;

  static const EdgeInsets _defaultMelonsCountPadding = EdgeInsets.symmetric(
    horizontal: 10,
    vertical: 8,
  );
  static const double _defaultMelonsCountRadius = 10;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final trailingExists = suffix != null;
    final leadingExists = prefix != null;

    return Container(
      padding: padding ?? _defaultMelonsCountPadding,
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.colors.blackAndWhite.shade200,
        borderRadius: BorderRadius.circular(_defaultMelonsCountRadius),
      ),
      child: Row(
        children: [
          if (leadingExists) ...[
            prefix!,
            const Gap(5),
          ],
          Text(
            label,
            style: labelStyle ?? theme.styles.body10,
          ),
          if (trailingExists) ...[
            const Spacer(),
            suffix!,
          ],
        ],
      ),
    );
  }
}
