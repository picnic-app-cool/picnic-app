// ignore_for_file: unused-code, unused-files
import 'package:flutter/material.dart';

class AnimatedVerticalSlide extends StatelessWidget {
  const AnimatedVerticalSlide({
    super.key,
    required this.show,
    required this.child,
    this.switchDuration = const Duration(milliseconds: 150),
    this.switchInCurve = Curves.easeInOut,
    this.switchOutCurve = Curves.easeInOut,
  });

  final bool show;
  final Widget child;
  final Duration switchDuration;
  final Curve switchInCurve;
  final Curve switchOutCurve;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: AnimatedSwitcher(
        switchInCurve: switchInCurve,
        switchOutCurve: switchOutCurve,
        duration: switchDuration,
        transitionBuilder: _transitionBuilder,
        child: show
            ? child
            : const SizedBox(
                width: double.infinity,
                height: 0,
              ),
      ),
    );
  }

  Widget _transitionBuilder(Widget child, Animation<double> animation) {
    return SlideTransition(
      position: Tween(
        begin: const Offset(0.0, -1.0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }
}
