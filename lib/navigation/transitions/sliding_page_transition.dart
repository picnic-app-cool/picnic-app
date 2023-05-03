import 'package:flutter/material.dart';
import 'package:picnic_app/constants/constants.dart';

class SlidingPageTransition<T> extends PageRouteBuilder<T> {
  SlidingPageTransition(Widget page)
      : super(
          // ignore: prefer-trailing-comma
          pageBuilder: (_, __, ___) => page,
          opaque: false,
          transitionDuration: Constants.slidingTransitionDuration,
        );

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return const CupertinoPageTransitionsBuilder().buildTransitions(
      this,
      context,
      animation,
      secondaryAnimation,
      primaryTransition(
        animation,
        secondaryTransition(secondaryAnimation, child),
      ),
    );
  }

  static SlideTransition primaryTransition(
    Animation<double> animation,
    Widget child,
  ) {
    final isMainForward = animation.status == AnimationStatus.reverse;
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: isMainForward ? Curves.easeIn : Curves.easeOut,
        ),
      ),
      child: child,
    );
  }

  static SlideTransition secondaryTransition(
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final secondaryTweenPosition = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-0.3, 0.0),
    ).animate(
      CurvedAnimation(parent: secondaryAnimation, curve: Curves.easeIn),
    );
    final secondaryTweenOpacity = Tween<double>(begin: 1, end: 0) //
        .animate(
      CurvedAnimation(parent: secondaryAnimation, curve: Curves.easeIn),
    );
    return SlideTransition(
      position: secondaryTweenPosition,
      child: FadeTransition(
        opacity: secondaryTweenOpacity,
        child: child,
      ),
    );
  }
}
