import 'package:flutter/material.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/theme/picnic_colors.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class SellSeedsSecondStepBottomPanel extends StatelessWidget {
  const SellSeedsSecondStepBottomPanel({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final VoidCallback? onTap;

  static const double _barBorderRadius = 32;

  @override
  Widget build(BuildContext context) {
    final colors = PicnicTheme.of(context).colors;
    final blackAndWhite = colors.blackAndWhite.shade100;

    return SafeArea(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: blackAndWhite,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(_barBorderRadius),
            topRight: Radius.circular(_barBorderRadius),
          ),
          boxShadow: const [
            BoxShadow(
              color: PicnicColors.lightGrey,
              offset: Offset(0, -1),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: PicnicButton(
            icon: Assets.images.send.path,
            titleColor: blackAndWhite,
            title: appLocalizations.sellSeedsSendOffer,
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
