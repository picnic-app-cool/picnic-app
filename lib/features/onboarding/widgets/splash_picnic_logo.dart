import 'dart:math';

import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/main.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class SplashPicnicLogo extends StatefulWidget {
  const SplashPicnicLogo({
    Key? key,
    this.animated = false,
    this.showShadow = true,
    this.onAnimationEnd,
  }) : super(key: key);

  final bool animated;
  final bool showShadow;
  final VoidCallback? onAnimationEnd;

  @override
  State<SplashPicnicLogo> createState() => _SplashPicnicLogoState();
}

class _SplashPicnicLogoState extends State<SplashPicnicLogo> with SingleTickerProviderStateMixin {
  late AnimationController _animation;
  static const double _logoContainerSize = 110.0;

  @override
  void initState() {
    super.initState();
    _animation = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        widget.onAnimationEnd?.call();
      }
    });
    if (widget.animated && !isUnitTests) {
      _animation.repeat(reverse: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);

    return Hero(
      tag: "splashLogoImage",
      child: AnimatedBuilder(
        animation: _animation,
        builder: (BuildContext context, Widget? child) {
          final firstAnim = CurvedAnimation(
            parent: _animation,
            curve: const Interval(
              0.3,
              0.6,
              curve: Curves.easeInOut,
            ),
          );
          final angle = -firstAnim.value / 2 * pi * 2.0;
          return Transform.rotate(angle: angle, child: child);
        },
        child: PicnicAvatar(
          size: _logoContainerSize,
          showShadow: widget.showShadow,
          backgroundColor: theme.colors.blackAndWhite.shade100,
          imageSource: PicnicImageSource.asset(
            ImageUrl(Assets.images.picnicLogo.path),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }
}
