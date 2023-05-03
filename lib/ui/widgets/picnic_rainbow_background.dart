import 'package:flutter/material.dart';

class PicnicRainbowBackground extends StatelessWidget {
  const PicnicRainbowBackground({
    required this.child,
    super.key,
  });

  final Widget child;

  static const _opacity = 0.3;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFFFD473).withOpacity(_opacity),
            const Color.fromRGBO(
              255,
              154,
              116,
              _opacity,
            ),
            const Color.fromRGBO(
              230,
              130,
              255,
              _opacity,
            ),
            const Color(0xFF819DFF).withOpacity(_opacity),
            const Color.fromRGBO(
              116,
              213,
              255,
              _opacity,
            ),
          ],
        ),
      ),
      child: child,
    );
  }
}
