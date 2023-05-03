import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/durations.dart';

class EmptyViewSwitcher extends StatelessWidget {
  const EmptyViewSwitcher({
    this.isEmpty = false,
    this.replacement = const SizedBox.shrink(),
    required this.child,
    super.key,
  });

  final bool isEmpty;
  final Widget replacement;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const MediumDuration(),
      child: isEmpty ? replacement : child,
    );
  }
}
