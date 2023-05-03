import 'package:flutter/material.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PostOverlayGradient extends StatelessWidget {
  const PostOverlayGradient({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  static const opacityFactor005 = 0.05;
  static const opacityFactor01 = 0.1;
  static const opacityFactor02 = 0.2;

  @override
  Widget build(BuildContext context) {
    final color = PicnicTheme.of(context).colors.blackAndWhite.shade900;
    return IgnorePointer(
      child: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [
              0,
              0.345,
              0.7552,
              1.0,
            ],
            colors: [
              color.withOpacity(opacityFactor005),
              color.withOpacity(0),
              color.withOpacity(opacityFactor01),
              color.withOpacity(opacityFactor02),
            ],
          ),
        ),
      ),
    );
  }
}
