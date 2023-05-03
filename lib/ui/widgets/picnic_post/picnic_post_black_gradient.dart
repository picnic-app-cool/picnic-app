import 'package:flutter/material.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PicnicPostBlackGradient extends StatelessWidget {
  const PicnicPostBlackGradient({Key? key}) : super(key: key);
  static const _stops = <double>[
    0,
    0.345,
    0.7956,
    1,
  ];

  @override
  Widget build(BuildContext context) {
    final black = PicnicTheme.of(context).colors.blackAndWhite.shade900;
    final blackWithOpacity0 = black.withOpacity(0.0);
    final blackWithOpacity20 = black.withOpacity(0.2);
    final blackWithOpacity40 = black.withOpacity(0.4);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            blackWithOpacity0,
            blackWithOpacity0,
            blackWithOpacity20,
            blackWithOpacity40,
          ],
          stops: _stops,
        ),
      ),
    );
  }
}
