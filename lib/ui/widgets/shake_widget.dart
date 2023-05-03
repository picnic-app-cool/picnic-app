import 'dart:math';
import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/durations.dart';

class ShakeWidget extends StatefulWidget {
  const ShakeWidget({
    this.duration = const LongDuration(),
    //ignore: no-magic-number
    this.shakeCount = 3,
    //ignore: no-magic-number
    this.shakeOffset = 7.0,
    this.shakeOnStart = false,
    required this.child,
    Key? key,
  }) : super(key: key);

  final Duration duration;
  final int shakeCount;
  final double shakeOffset;
  final Widget child;
  final bool shakeOnStart;

  @override
  State<ShakeWidget> createState() => ShakeWidgetState();
}

class ShakeWidgetState extends State<ShakeWidget> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: widget.duration);
    _animationController.addStatusListener(_updateStatus);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.shakeOnStart) {
        shake();
      }
    });
  }

  @override
  void dispose() {
    _animationController.removeStatusListener(_updateStatus);
    _animationController.dispose();
    super.dispose();
  }

  void shake() {
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: widget.child,
      builder: (context, child) {
        final sineValue = sin(widget.shakeCount * 2 * pi * _animationController.value);
        return Transform.translate(
          offset: Offset(sineValue * widget.shakeOffset, 0),
          child: child,
        );
      },
    );
  }

  void _updateStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _animationController.reset();
    }
  }
}
