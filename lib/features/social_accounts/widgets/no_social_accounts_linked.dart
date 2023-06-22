import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class NoSocialAccountsLinked extends StatelessWidget {
  static const _imageSize = 61.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final styles = theme.styles;
    final darkBlue = theme.colors.darkBlue;
    return Column(
      children: [
        Image.asset(
          Assets.images.sadFace.path,
          width: _imageSize,
          height: _imageSize,
        ),
        const Gap(12),
        Text(
          appLocalizations.nothingYet,
          style: styles.link40.copyWith(color: darkBlue.shade800),
        ),
        const Gap(6),
        Text(
          appLocalizations.noSocialAccountsYet,
          textAlign: TextAlign.center,
          style: styles.body10.copyWith(color: darkBlue.shade600),
        ),
        const Gap(16),
      ],
    );
  }
}
