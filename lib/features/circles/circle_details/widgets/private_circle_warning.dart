import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PrivateCircleWarning extends StatelessWidget {
  const PrivateCircleWarning({super.key});

  static const double _circleSize = 88;
  static const double _circleBackgroundColorOpacity = 0.05;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final styles = theme.styles;
    final colors = theme.colors;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          constraints: BoxConstraints.tight(
            const Size.square(_circleSize),
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colors.blackAndWhite.shade900.withOpacity(
              _circleBackgroundColorOpacity,
            ),
          ),
          alignment: Alignment.center,
          child: const Text(
            '🔒',
            style: TextStyle(fontSize: 42),
          ),
        ),
        const Gap(16),
        Text(
          appLocalizations.privateCircleWarningTitle,
          style: styles.title30,
        ),
        Text(
          appLocalizations.privateCircleWarningMessage,
          style: styles.body20.copyWith(
            color: colors.blackAndWhite.shade600,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
