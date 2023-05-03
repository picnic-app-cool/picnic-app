import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class EmptyFeedsView extends StatelessWidget {
  const EmptyFeedsView({super.key});

  static const _circleSize = 88.0;
  static const _borderRadius = 24.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(_borderRadius),
            border: Border.fromBorderSide(BorderSide(color: theme.colors.blackAndWhite.shade300)),
          ),
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(16),
          child: Column(
            children: [
              Center(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0XFFf2f2f2),
                    shape: BoxShape.circle,
                  ),
                  height: _circleSize,
                  width: _circleSize,
                  child: Center(
                    child: Image.asset(
                      Assets.images.monkey.path,
                    ),
                  ),
                ),
              ),
              const Gap(20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  appLocalizations.noCirclesTitle,
                  style: theme.styles.title30,
                  textAlign: TextAlign.start,
                ),
              ),
              const Gap(8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  appLocalizations.findCircleLabel,
                  style: theme.styles.caption20,
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
