import 'package:flutter/material.dart';

typedef HorizontalDragCallback = void Function(double offset);

class HorizontalDragDetector extends StatefulWidget {
  const HorizontalDragDetector({
    super.key,
    this.onDrag,
    this.onEnd,
    this.child,
  });

  final HorizontalDragCallback? onDrag;
  final VoidCallback? onEnd;
  final Widget? child;

  @override
  State<HorizontalDragDetector> createState() => _HorizontalDragDetectorState();
}

class _HorizontalDragDetectorState extends State<HorizontalDragDetector> {
  double startDx = 0;

  void onHorizontalDragStart(DragStartDetails details) {
    setState(() => startDx = details.localPosition.dx);
  }

  void onHorizontalDragUpdate(DragUpdateDetails details) {
    widget.onDrag?.call(startDx - details.localPosition.dx);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onHorizontalDragStart: onHorizontalDragStart,
      onHorizontalDragUpdate: onHorizontalDragUpdate,
      onHorizontalDragEnd: (_) => widget.onEnd?.call(),
      child: widget.child,
    );
  }
}
