import 'package:flutter/material.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PlayButton extends StatelessWidget {
  const PlayButton({
    this.padding = _defaultPadding,
    this.iconSize = _defaultIconSize,
    super.key,
  });

  const PlayButton.small({Key? key})
      : this(
          padding: _smallPadding,
          iconSize: _smallIconSize,
          key: key,
        );

  final double padding;
  final double iconSize;

  static const _smallPadding = 4.0;
  static const _defaultPadding = 8.0;
  static const _smallIconSize = 24.0;
  static const _defaultIconSize = 36.0;
  static const _opacity = 0.5;

  @override
  Widget build(BuildContext context) {
    final colors = PicnicTheme.of(context).colors;
    final white = colors.blackAndWhite.shade100;
    final black = colors.blackAndWhite.shade900;

    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: black.withOpacity(_opacity),
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.play_arrow,
        color: white,
        size: iconSize,
      ),
    );
  }
}
