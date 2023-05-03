import 'package:flutter/material.dart';

RouteTransitionsBuilder fadeInWithDelayPageTransition({
  required bool fadeOut,
  required double animationDelayPercent,
}) =>
    (
      context,
      animation,
      secondaryAnimation,
      child,
    ) =>
        FadeTransition(
          opacity: Tween<double>(begin: 0, end: 1).animate(_delayed(animation, animationDelayPercent)),
          child: fadeOut
              ? FadeTransition(
                  opacity: Tween<double>(begin: 1, end: 0).animate(_delayed(secondaryAnimation, animationDelayPercent)),
                  child: child,
                )
              : child,
        );

CurvedAnimation _delayed(Animation<double> animation, double delayPercentage) =>
    CurvedAnimation(parent: animation, curve: Interval(delayPercentage, 1.0));
