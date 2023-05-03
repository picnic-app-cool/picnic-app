import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:picnic_ui_components/resources/assets.gen.dart';
import 'package:picnic_ui_components/utils.dart';

const _displayDuration = Duration(seconds: 1);

// ignore_for_file: unused-code, unused-files
class PicnicHeartbeatAnimation extends StatefulWidget {
  const PicnicHeartbeatAnimation({
    super.key,
    required this.heartLastAnimatedAt,
    this.onWarning,
  });

  final DateTime heartLastAnimatedAt;
  final Function(String)? onWarning;

  @override
  State<PicnicHeartbeatAnimation> createState() => _PicnicHeartbeatAnimationState();
}

class _PicnicHeartbeatAnimationState extends State<PicnicHeartbeatAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _opacity = 0.0;
  static const _dimension = 150.0;
  Timer? _hideButtonTimer;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      curve: const Interval(
        0.0,
        0.5,
        curve: Curves.easeIn,
      ),
      duration: const Duration(milliseconds: 300),
      opacity: _opacity,
      child: IgnorePointer(
        child: Lottie.asset(
          Assets.lottie.heartbeat,
          onWarning: widget.onWarning,
          animate: !isUnitTests,
          width: _dimension,
          height: _dimension,
          repeat: false,
          controller: _controller,
          package: uiPackage,
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(covariant PicnicHeartbeatAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.heartLastAnimatedAt != widget.heartLastAnimatedAt) {
      _display();
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    _hideButtonTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _display() {
    setState(() {
      _opacity = 1.0;
    });
    _hideButtonTimer?.cancel();
    _controller.forward();
    _hideButtonTimer = Timer(_displayDuration, _hide);
  }

  void _hide() {
    setState(() {
      _opacity = 0.0;
    });
    _hideButtonTimer?.cancel();
    _controller.reverse();
  }
}
