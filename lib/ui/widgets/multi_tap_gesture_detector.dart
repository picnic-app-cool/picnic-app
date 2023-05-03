import 'dart:async';

import 'package:flutter/material.dart';

class MultiTapGestureDetector extends StatefulWidget {
  const MultiTapGestureDetector({
    super.key,
    required this.child,
    required this.onMultiTap,
    required this.numberOfTaps,
    this.tapDuration = const Duration(milliseconds: 500),
  });

  final VoidCallback onMultiTap;
  final int numberOfTaps;
  final Widget child;
  final Duration tapDuration;

  @override
  State<MultiTapGestureDetector> createState() => _MultiTapGestureDetectorState();
}

class _MultiTapGestureDetectorState extends State<MultiTapGestureDetector> {
  int tapsCount = 0;
  Timer? resetTimer;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _reset();
    super.dispose();
  }

  void _onTap() {
    tapsCount++;
    if (tapsCount == widget.numberOfTaps) {
      _reset();
      widget.onMultiTap();
    } else {
      resetTimer?.cancel();
      resetTimer = Timer(widget.tapDuration, _reset);
    }
  }

  void _reset() {
    tapsCount = 0;
    resetTimer?.cancel();
    resetTimer = null;
  }
}
