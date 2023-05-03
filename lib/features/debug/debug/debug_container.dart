import 'package:flutter/material.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/debug/debug/debug_initial_params.dart';
import 'package:picnic_app/features/debug/debug/debug_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/ui/widgets/multi_tap_gesture_detector.dart';

class DebugContainer extends StatelessWidget {
  const DebugContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  static const numberOfTaps = 3;

  @override
  Widget build(BuildContext context) {
    return MultiTapGestureDetector(
      numberOfTaps: numberOfTaps,
      //intentionally using AppNavigator.navigatorKey here, since our context has no navigator above it
      onMultiTap: () => _openDebug(),
      child: child,
    );
  }

  Future<dynamic> _openDebug() {
    return Navigator.of(AppNavigator.currentContext, rootNavigator: true).push(
      materialRoute(
        getIt<DebugPage>(
          param1: const DebugInitialParams(),
        ),
      ),
    );
  }
}
