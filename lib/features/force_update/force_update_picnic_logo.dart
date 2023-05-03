import 'dart:math';

import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/main.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';

class ForceUpdatePicnicLogo extends StatefulWidget {
  const ForceUpdatePicnicLogo({
    Key? key,
    this.animated = false,
    this.onAnimationEnd,
  }) : super(key: key);

  final bool animated;
  final VoidCallback? onAnimationEnd;

  @override
  State<ForceUpdatePicnicLogo> createState() => _ForceUpdatePicnicLogoState();
}

class _ForceUpdatePicnicLogoState extends State<ForceUpdatePicnicLogo> with SingleTickerProviderStateMixin {
  late AnimationController _animation;
  static const double _logoContainerSize = 88.0;
  static const _backgroundColor = Color(0xffF2F2F2);

  @override
  void initState() {
    super.initState();
    _initAnimationController();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
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
        backgroundColor: _backgroundColor,
        imageSource: PicnicImageSource.asset(
          ImageUrl(Assets.images.picnicLogo.path),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }

  void _initAnimationController() {
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
}
