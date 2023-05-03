import 'dart:ui';

import 'package:picnic_app/features/onboarding/splash/splash_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class SplashPresentationModel implements SplashViewModel {
  /// Creates the initial state
  SplashPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    this.initialParams,
  );

  /// Used for the copyWith method
  SplashPresentationModel._({
    required this.initialParams,
  });

  final SplashInitialParams initialParams;

  VoidCallback get onTapLoginCallback => initialParams.onTapLogin;

  VoidCallback get onTapGetStartedCallback => initialParams.onTapGetStarted;

  SplashPresentationModel copyWith({
    SplashInitialParams? initialParams,
  }) {
    return SplashPresentationModel._(
      initialParams: initialParams ?? this.initialParams,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class SplashViewModel {}
