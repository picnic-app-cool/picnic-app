import 'package:flutter/material.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class CirclesSideMenuButton extends StatelessWidget {
  const CirclesSideMenuButton({
    Key? key,
    required this.onTap,
    required this.title,
    required this.assetPath,
  }) : super(key: key);

  final VoidCallback onTap;
  final String title;
  final String assetPath;

  static const double _itemHeight = 40;
  static const double _itemRadius = 80;
  static const double _iconSize = 16;
  static const _contentPadding = EdgeInsets.symmetric(horizontal: 16.0);

  @override
  Widget build(BuildContext context) {
    final styles = PicnicTheme.of(context).styles;
    final colors = PicnicTheme.of(context).colors;
    final darkBlue = colors.darkBlue.shade800;
    final titleStyle = styles.link0.copyWith(color: darkBlue);

    return InkWell(
      onTap: onTap,
      child: Container(
        height: _itemHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_itemRadius),
          //ignore: no-magic-number
          color: Colors.black.withOpacity(0.07),
        ),
        child: Padding(
          padding: _contentPadding,
          child: Row(
            children: [
              Text(
                title,
                style: titleStyle,
              ),
              const Spacer(),
              Image.asset(
                assetPath,
                color: darkBlue,
                height: _iconSize,
                width: _iconSize,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
