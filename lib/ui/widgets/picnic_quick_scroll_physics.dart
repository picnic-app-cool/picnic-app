import 'package:flutter/widgets.dart';

/// More quick and massive scrolling comparing to the default one
class PicnicQuickScrollPhysics extends ScrollPhysics {
  const PicnicQuickScrollPhysics({ScrollPhysics? parent}) : super(parent: parent);

  @override
  SpringDescription get spring => const SpringDescription(
        mass: 150,
        stiffness: 100,
        damping: 0.8,
      );

  @override
  PicnicQuickScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return PicnicQuickScrollPhysics(parent: buildParent(ancestor));
  }
}
