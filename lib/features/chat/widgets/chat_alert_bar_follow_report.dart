//ignore_for_file: unused-code, unused-files
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class ChatAlertBarFollowReport extends StatelessWidget {
  const ChatAlertBarFollowReport({
    Key? key,
    required this.onTapFollow,
    required this.onTapReport,
  }) : super(key: key);

  final VoidCallback onTapFollow;
  final VoidCallback onTapReport;

  static const _blurRadius = 5.0;
  static const _shadowOpacity = 0.15;
  static const _borderWidth = 2.0;

  static const _primaryFilledButtonPadding = EdgeInsets.symmetric(
    horizontal: 24,
    vertical: 8.0,
  );
  static const _secondaryOutlinedButtonPadding = EdgeInsets.symmetric(
    horizontal: 24,
    vertical: 6.0,
  );

  static const _barHeight = 70.0;
  static const _spreadRadius = 2.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final textStyleBody30 = theme.styles.body30;
    final white = colors.blackAndWhite.shade100;
    return Container(
      height: _barHeight,
      decoration: BoxDecoration(
        color: white,
        boxShadow: [
          BoxShadow(
            blurRadius: _blurRadius,
            spreadRadius: _spreadRadius,
            blurStyle: BlurStyle.outer,
            color: colors.blackAndWhite.shade900.withOpacity(_shadowOpacity),
            offset: const Offset(0, 4),
          ),
        ],
      ),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                appLocalizations.chatAlertBarTitle,
                style: theme.styles.body20,
              ),
              Text(
                appLocalizations.chatAlertBarDescription,
                style: theme.styles.caption10.copyWith(
                  color: colors.blackAndWhite.shade600,
                ),
              ),
            ],
          ),
          const Gap(16),
          PicnicButton(
            color: Colors.transparent,
            borderColor: colors.pink,
            style: PicnicButtonStyle.outlined,
            padding: _secondaryOutlinedButtonPadding,
            borderWidth: _borderWidth,
            onTap: onTapReport,
            titleStyle: textStyleBody30.copyWith(color: colors.pink),
            title: appLocalizations.reportAction,
          ),
          const Gap(8),
          PicnicButton(
            padding: _primaryFilledButtonPadding,
            titleStyle: textStyleBody30.copyWith(
              color: white,
            ),
            title: appLocalizations.followAction,
            onTap: onTapFollow,
          ),
        ],
      ),
    );
  }
}
