import 'package:flutter/material.dart';

class DoubleTapDetector extends StatelessWidget {
  const DoubleTapDetector({
    super.key,
    required this.onDoubleTap,
    required this.child,
  });

  final VoidCallback onDoubleTap;
  final Widget child;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onDoubleTap: onDoubleTap,
        child: child,
      );
}
