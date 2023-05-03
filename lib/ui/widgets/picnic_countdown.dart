import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/current_time_provider.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/countdown_timer_builder.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class PicnicCountdown extends StatelessWidget {
  const PicnicCountdown({
    required this.currentTimeProvider,
    required this.deadline,
    this.onTapApprove,
    this.onTapReject,
  });

  final CurrentTimeProvider currentTimeProvider;
  final DateTime deadline;
  final VoidCallback? onTapApprove;
  final VoidCallback? onTapReject;

  static const _durationValue = 60;

  @override
  Widget build(BuildContext context) {
    final styles = PicnicTheme.of(context).styles;
    final bottomSectionExists = onTapApprove != null || onTapReject != null;

    return CountdownTimerBuilder(
      currentTimeProvider: currentTimeProvider,
      deadline: deadline,
      builder: (context, timeRemaining) => Column(
        children: [
          Row(
            children: [
              Image.asset(
                Assets.images.clock.path,
              ),
              const Gap(14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appLocalizations.countdownValue(
                      timeRemaining.inDays,
                      timeRemaining.inHours.remainder(_durationValue),
                      timeRemaining.inMinutes.remainder(_durationValue),
                    ),
                    style: styles.body20,
                  ),
                  Text(
                    appLocalizations.countdownHint,
                    style: styles.caption10,
                  ),
                ],
              ),
            ],
          ),
          if (bottomSectionExists) const Gap(14),
          _PicnicCountdownBottomSection(
            onTapApprove: onTapApprove,
            onTapReject: onTapReject,
          ),
        ],
      ),
    );
  }
}

class _PicnicCountdownBottomSection extends StatelessWidget {
  const _PicnicCountdownBottomSection({
    Key? key,
    this.onTapApprove,
    this.onTapReject,
  }) : super(key: key);

  final VoidCallback? onTapApprove;
  final VoidCallback? onTapReject;

  static const _borderButtonWidth = 2.5;

  @override
  Widget build(BuildContext context) {
    final colors = PicnicTheme.of(context).colors;
    final approveExists = onTapApprove != null;
    final rejectExists = onTapReject != null;

    return Row(
      children: [
        if (approveExists)
          Expanded(
            child: PicnicButton(
              title: appLocalizations.approveAction,
              onTap: onTapApprove,
              padding: const EdgeInsets.symmetric(
                vertical: 8,
              ),
              size: PicnicButtonSize.large,
            ),
          ),
        if (approveExists && rejectExists) const Gap(10),
        if (rejectExists)
          Expanded(
            child: PicnicButton(
              title: appLocalizations.rejectAction,
              onTap: onTapReject,
              padding: const EdgeInsets.symmetric(
                vertical: 6,
              ),
              borderColor: colors.pink,
              borderWidth: _borderButtonWidth,
              titleColor: colors.pink,
              style: PicnicButtonStyle.outlined,
              size: PicnicButtonSize.large,
            ),
          ),
      ],
    );
  }
}
