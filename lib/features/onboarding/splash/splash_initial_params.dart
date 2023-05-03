import 'package:flutter/material.dart';

class SplashInitialParams {
  const SplashInitialParams({
    required this.onTapLogin,
    required this.onTapGetStarted,
  });

  final VoidCallback onTapLogin;
  final VoidCallback onTapGetStarted;
}
