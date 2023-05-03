import 'package:flutter/material.dart';
import 'package:picnic_ui_components/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/widgets/animated_endless_rotation.dart';
import 'package:picnic_ui_components/utils.dart';

// ignore_for_file: unused-code, unused-files
class PicnicLoadingIndicator extends StatelessWidget {
  const PicnicLoadingIndicator({
    super.key,
    this.color,
    this.isLoading = true,
  });

  final bool isLoading;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 150),
      child: isLoading //
          ? AnimatedEndlessRotation(
              child: Assets.images.loaderIcon.image(color: color, package: uiPackage),
            )
          : const SizedBox.shrink(),
    ); // TODO
  }
}
