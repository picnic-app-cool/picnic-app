import 'package:flutter/material.dart';

RouteTransitionsBuilder slideBottomPageTransition() => (
      context,
      animation,
      secondaryAnimation,
      child,
    ) =>
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 1.0),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutQuint)),
          child: child,
        );
