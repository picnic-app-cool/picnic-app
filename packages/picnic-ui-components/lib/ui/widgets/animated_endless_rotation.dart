import 'dart:math';

import 'package:flutter/material.dart';
import 'package:picnic_ui_components/utils.dart';

// ignore_for_file: unused-code, unused-files
class AnimatedEndlessRotation extends StatefulWidget {
  const AnimatedEndlessRotation({
    super.key,
    required this.child,
    this.cycleDuration = const Duration(milliseconds: 1500),
    this.reverse = false,
  });

  final Duration cycleDuration;
  final Widget child;
  final bool reverse;

  @override
  State<AnimatedEndlessRotation> createState() => _AnimatedEndlessRotationState();
}

class _AnimatedEndlessRotationState extends State<AnimatedEndlessRotation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _setUpController();
  }

  @override
  void didUpdateWidget(covariant AnimatedEndlessRotation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.cycleDuration != widget.cycleDuration) {
      _setUpController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (context, child) {
        final rotationValue = (widget.reverse ? -1 : 1) * _controller.value * pi * 2;
        return Transform.rotate(
          angle: rotationValue,
          child: child,
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _setUpController() {
    _controller.duration = widget.cycleDuration;
    if (!isUnitTests) {
      _controller.repeat();
    }
  }
}
