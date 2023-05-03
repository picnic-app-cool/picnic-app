import 'package:flutter/material.dart';

/// GestureDetector specialized in detecting swipes in various directions
class SwipeDetector extends StatefulWidget {
  const SwipeDetector({
    super.key,
    this.onSwipeLeft,
    this.onSwipeRight,
    this.onSwipeDown,
    this.onSwipeUp,
    this.swipeThreshold = defaultSwipeThreshold,
    required this.child,
  }) : assert(
          onSwipeLeft != null || onSwipeRight != null,
          'you have to provide at least one listening callback, f.e: onSwipeLeft',
        );

  static const defaultSwipeThreshold = 20.0;

  final VoidCallback? onSwipeLeft;
  final VoidCallback? onSwipeRight;
  final VoidCallback? onSwipeDown;
  final VoidCallback? onSwipeUp;

  // what distance needs to be dragged in single update to detect it as swipe.
  final double swipeThreshold;
  final Widget child;

  @override
  State<SwipeDetector> createState() => _SwipeDetectorState();
}

class _SwipeDetectorState extends State<SwipeDetector> {
  bool _notified = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragCancel: () => _notified = false,
      onHorizontalDragEnd: (end) => _notified = false,
      onHorizontalDragUpdate: _horizontalDragUpdate,
      onVerticalDragCancel: () => _notified = false,
      onVerticalDragEnd: (end) => _notified = false,
      onVerticalDragUpdate: _verticalDragUpdate,
      child: widget.child,
    );
  }

  void _verticalDragUpdate(DragUpdateDetails update) {
    final dy = update.delta.dy;
    if (_notified) {
      return;
    }
    if (dy > widget.swipeThreshold) {
      _notified = true;
      widget.onSwipeDown?.call();
    } else if (dy < -widget.swipeThreshold) {
      _notified = true;
      widget.onSwipeUp?.call();
    }
  }

  void _horizontalDragUpdate(DragUpdateDetails update) {
    final dx = update.delta.dx;
    if (_notified) {
      return;
    }
    if (dx > widget.swipeThreshold) {
      _notified = true;
      widget.onSwipeRight?.call();
    } else if (dx < -widget.swipeThreshold) {
      _notified = true;
      widget.onSwipeLeft?.call();
    }
  }
}
