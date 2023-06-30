import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class CountryCodePrefix extends StatelessWidget {
  const CountryCodePrefix({
    required this.flag,
    required this.code,
    required this.onTapCountryCode,
  });

  final String flag;
  final String code;
  final void Function() onTapCountryCode;

  static const _prefixDividerHeight = 24.0;
  static const _prefixDividerWidth = 1.0;
  static const _downArrowSize = 20.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final darkBlue = theme.colors.darkBlue;
    final textStyle = theme.styles.link20.copyWith(color: darkBlue.shade600);
    return GestureDetector(
      onTap: onTapCountryCode,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Gap(16),
          Text(
            flag,
            style: textStyle,
          ),
          const Gap(2),
          Text(
            code,
            style: textStyle,
          ),
          Icon(
            Icons.arrow_drop_down,
            color: darkBlue.shade700,
            size: _downArrowSize,
          ),
          const Gap(4),
          Container(
            height: _prefixDividerHeight,
            width: _prefixDividerWidth,
            color: darkBlue.shade400,
          ),
          const Gap(8),
        ],
      ),
    );
  }
}
