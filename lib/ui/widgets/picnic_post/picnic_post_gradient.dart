import 'package:flutter/material.dart';

class PicnicPostGradient extends StatelessWidget {
  const PicnicPostGradient({
    Key? key,
    required this.gradient,
  }) : super(key: key);

  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
      ),
    );
  }
}
