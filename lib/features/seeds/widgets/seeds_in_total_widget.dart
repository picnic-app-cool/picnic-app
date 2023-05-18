import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class SeedsInTotalWidget extends StatelessWidget {
  const SeedsInTotalWidget({super.key, required this.seedsCount});

  final int seedsCount;
  static const _seedsIconSize = 20.0;
  static const _radius = 12.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final blackAndWhite = theme.colors.blackAndWhite;
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        color: blackAndWhite.shade200,
        borderRadius: BorderRadius.circular(_radius),
      ),
      child: Row(
        children: [
          Assets.images.acorn.image(width: _seedsIconSize),
          const Gap(4),
          Text(
            appLocalizations.circleElectionYouHaveSeedInCircle(seedsCount.toString()),
            style: theme.styles.body30.copyWith(color: blackAndWhite.shade900),
          ),
        ],
      ),
    );
  }
}
