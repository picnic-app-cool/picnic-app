import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/core/utils/logging.dart';
import 'package:picnic_app/main.dart';
import 'package:picnic_app/resources/assets.gen.dart';

class OnboardingBackground extends StatefulWidget {
  const OnboardingBackground({
    Key? key,
  }) : super(key: key);

  @override
  State<OnboardingBackground> createState() => _OnboardingBackgroundState();
}

class _OnboardingBackgroundState extends State<OnboardingBackground> {
  late double _opacity = 0.0;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: AnimatedOpacity(
        curve: const Interval(
          0.0,
          0.5,
          curve: Curves.easeIn,
        ),
        duration: Constants.splashTransitionDuration,
        opacity: _opacity,
        child: Lottie.asset(
          Assets.lottie.onboardingBackground,
          onWarning: (warning) => debugLog(warning),
          animate: !isUnitTests,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => setState(() => _opacity = 1.0),
    );
  }
}
