import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class OnboardingBackButton extends StatelessWidget {
  const OnboardingBackButton({
    Key? key,
    required this.onTap,
    required this.canPop,
  }) : super(key: key);

  final bool canPop;
  final VoidCallback onTap;

  static const _borderRadius = 12.0;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(_borderRadius);
    return AnimatedOpacity(
      // We intentionally use opacity, so that the widget is in the widget tree and hero animation works correctly
      opacity: canPop ? 1.0 : 0.0,
      duration: const ShortDuration(),
      child: Material(
        borderRadius: radius,
        color: PicnicTheme.of(context).colors.blackAndWhite.shade100,
        child: InkWell(
          radius: _borderRadius,
          onTap: canPop ? onTap : null,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Assets.images.backArrow.image(),
          ),
        ),
      ),
    );
  }
}
