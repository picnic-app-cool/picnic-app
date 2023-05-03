import 'package:flutter/material.dart';
import 'package:picnic_app/features/seeds/sell_seeds/models/sell_seeds_step.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class SellSeedsStepIndicator extends StatelessWidget {
  const SellSeedsStepIndicator({Key? key, required this.step}) : super(key: key);

  final SellSeedsStep step;

  static const _halfSizeIndicator = 0.5;
  static const _indicatorHeight = 2.0;

  @override
  Widget build(BuildContext context) => FractionallySizedBox(
        widthFactor: step == SellSeedsStep.first ? _halfSizeIndicator : 1,
        child: Container(
          color: PicnicTheme.of(context).colors.green.shade400,
          height: _indicatorHeight,
        ),
      );
}
