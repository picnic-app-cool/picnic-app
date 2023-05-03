import 'package:flutter/material.dart';
import 'package:picnic_app/features/onboarding/widgets/splash_picnic_logo.dart';

class CenteredPicnicLogo extends StatelessWidget {
  const CenteredPicnicLogo({
    Key? key,
    this.backgroundColor = Colors.transparent,
    this.animated = false,
    this.showShadow = false,
    this.onAnimationEnd,
  }) : super(key: key);

  final Color backgroundColor;
  final bool animated;
  final bool showShadow;
  final VoidCallback? onAnimationEnd;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      child: Center(
        child: SplashPicnicLogo(
          animated: animated,
          showShadow: showShadow,
          onAnimationEnd: onAnimationEnd,
        ),
      ),
    );
  }
}
