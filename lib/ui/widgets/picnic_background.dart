import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:picnic_app/core/utils/logging.dart';
import 'package:picnic_app/main.dart';
import 'package:picnic_app/resources/assets.gen.dart';

class PicnicBackground extends StatefulWidget {
  const PicnicBackground({
    Key? key,
  }) : super(key: key);

  @override
  State<PicnicBackground> createState() => _PicnicBackgroundState();
}

class _PicnicBackgroundState extends State<PicnicBackground> {
  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      Assets.lottie.onboardingBackground,
      onWarning: (warning) => debugLog(warning),
      animate: !isUnitTests,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
      bundle: DefaultAssetBundle.of(context),
    );
  }
}
