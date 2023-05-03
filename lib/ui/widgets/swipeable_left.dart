import 'dart:math';

import 'package:flutter/material.dart';
import 'package:picnic_app/features/chat/widgets/message_timestamp.dart';
import 'package:picnic_app/ui/widgets/horizontal_drag_detector.dart';

/// default width setup for [MessageTimestamp]
const _defaultHiddenChildWidth = 68.0;

/// Widget that adds hiddenChild to the right side of the child
///
/// set offset value > 0 to reveal hiddenChild
/// offset can be controlled by [HorizontalDragDetector]

class SwipeableLeft extends StatelessWidget {
  const SwipeableLeft({
    super.key,
    required this.child,
    required this.hiddenChild,
    this.offset = 0,
    this.hiddenChildWidth = _defaultHiddenChildWidth,
  });

  final Widget child;
  final Widget hiddenChild;
  final double offset;
  final double hiddenChildWidth;

  @override
  Widget build(BuildContext context) {
    final rightMargin = max(min(offset, hiddenChildWidth), 0.0);
    final rightPosition = min(offset - hiddenChildWidth, 0.0);

    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        AnimatedContainer(
          margin: EdgeInsets.only(right: rightMargin),
          duration: offset == 0 ? kThemeAnimationDuration : Duration.zero,
          child: child,
        ),
        AnimatedPositioned(
          right: rightPosition,
          duration: offset == 0 ? kThemeAnimationDuration : Duration.zero,
          child: hiddenChild,
        ),
      ],
    );
  }
}
