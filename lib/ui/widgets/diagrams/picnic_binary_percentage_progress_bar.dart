import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PicnicBinaryPercentageProgressBar extends StatelessWidget {
  const PicnicBinaryPercentageProgressBar({
    Key? key,
    required this.leftPartPercentage,
    required this.avatar,
    required this.isAvatarOnLeftPart,
  })  : assert(
          leftPartPercentage <= _maxPercent && leftPartPercentage >= 0,
          "leftPartPercentage must be between [0, 100]",
        ),
        super(key: key);

  final int leftPartPercentage;
  final Widget avatar;
  final bool isAvatarOnLeftPart;

  static const _maxPercent = 100;
  static const _barHeight = 37.0;
  static const _borderRadius = 12.0;
  static const _percentOffset = 10;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;

    final leftPercent = leftPartPercentage;
    final rightPercent = 100 - leftPartPercentage;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      clipBehavior: Clip.antiAlias,
      height: _barHeight,
      child: Row(
        children: [
          if (leftPercent > 0)
            Expanded(
              flex: _percentOffset + leftPercent + (isAvatarOnLeftPart ? _percentOffset : 0),
              child: Container(
                color: colors.blue.shade500,
                height: _barHeight,
                child: _PercentageText(
                  percent: '$leftPercent%',
                  isLeftText: true,
                  prefix: isAvatarOnLeftPart ? avatar : null,
                ),
              ),
            ),
          if (rightPercent > 0)
            Expanded(
              flex: _percentOffset + rightPercent + (isAvatarOnLeftPart ? 0 : _percentOffset),
              child: Container(
                color: colors.pink.shade500,
                height: _barHeight,
                child: _PercentageText(
                  percent: '$rightPercent%',
                  isLeftText: false,
                  postfix: isAvatarOnLeftPart ? null : avatar,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _PercentageText extends StatelessWidget {
  const _PercentageText({
    Key? key,
    required this.percent,
    required this.isLeftText,
    this.prefix,
    this.postfix,
  }) : super(key: key);

  final String percent;
  final bool isLeftText;
  final Widget? prefix;
  final Widget? postfix;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;

    final textTheme = theme.styles.subtitle20.copyWith(
      color: colors.blackAndWhite.shade100,
    );
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!isLeftText) const Gap(8),
        if (prefix != null) ...[
          const Gap(4),
          prefix!,
        ],
        if (isLeftText) const Spacer(),
        Text(
          percent,
          style: textTheme,
        ),
        if (!isLeftText) const Spacer(),
        if (postfix != null) ...[
          postfix!,
          const Gap(4),
        ],
        if (isLeftText) const Gap(8),
      ],
    );
  }
}
