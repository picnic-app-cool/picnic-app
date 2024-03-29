import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DarkStatusBar extends StatelessWidget {
  const DarkStatusBar({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        // Only for Android
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
      ),
      child: child,
    );
  }
}
