import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ViewInForegroundDetector extends StatefulWidget {
  const ViewInForegroundDetector({
    super.key,
    this.viewDidAppear,
    this.viewDidDisappear,
    this.visibilityFraction = 1,
    required this.child,
  });

  final VoidCallback? viewDidAppear;
  final VoidCallback? viewDidDisappear;

  /// Specifies what fraction of the [child] is considered as view appeared event.
  final double visibilityFraction;

  final Widget child;

  @override
  State<ViewInForegroundDetector> createState() => _ViewInForegroundDetectorState();
}

class _ViewInForegroundDetectorState extends State<ViewInForegroundDetector> {
  final _visibilityKey = UniqueKey();

  bool? _visible;

  @override
  Widget build(BuildContext context) => VisibilityDetector(
        key: _visibilityKey,
        onVisibilityChanged: _onVisibilityChanged,
        child: widget.child,
      );

  void _onVisibilityChanged(VisibilityInfo info) {
    if (!mounted) {
      return;
    }
    if (info.visibleFraction >= widget.visibilityFraction) {
      if (_visible != true) {
        _visible = true;
        widget.viewDidAppear?.call();
      }
    } else {
      if (_visible != false) {
        _visible = false;
        widget.viewDidDisappear?.call();
      }
    }
  }
}
