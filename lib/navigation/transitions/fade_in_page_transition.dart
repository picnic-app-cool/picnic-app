import 'package:flutter/material.dart';

RouteTransitionsBuilder fadeInPageTransition({
  required bool fadeOut,
}) =>
    (
      context,
      animation,
      secondaryAnimation,
      child,
    ) =>
        FadeTransition(
          opacity: Tween<double>(begin: 0, end: 1).animate(animation),
          child: fadeOut
              ? FadeTransition(
                  opacity: Tween<double>(begin: 1, end: 0).animate(secondaryAnimation),
                  child: child,
                )
              : child,
        );
