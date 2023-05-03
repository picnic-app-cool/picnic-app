import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:picnic_app/core/fx_effect_overlay/fx_effect.dart';
import 'package:picnic_app/resources/assets.gen.dart';

class LottieFxEffect extends FxEffect {
  LottieFxEffect({
    required super.duration,
    required this.lottieAnimation,
  });

  factory LottieFxEffect.glitter() => LottieFxEffect(
        duration: const Duration(seconds: 4),
        lottieAnimation: Assets.lottie.glitterEffect,
      );

  final String lottieAnimation;

  @override
  Widget build(BuildContext context) => Lottie.asset(
        lottieAnimation,
        repeat: false,
      );
}
