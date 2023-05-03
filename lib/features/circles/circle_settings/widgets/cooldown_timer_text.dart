import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/current_time_provider.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/countdown_timer_builder.dart';
import 'package:picnic_app/utils/extensions/string_formatting.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class CooldownTimerText extends StatelessWidget {
  const CooldownTimerText({
    Key? key,
    required this.timeStamp,
    required this.currentTimeProvider,
  }) : super(key: key);

  final CurrentTimeProvider currentTimeProvider;
  final DateTime timeStamp;

  @override
  Widget build(BuildContext context) {
    final provider = currentTimeProvider;
    final _timeout = timeStamp;
    final theme = PicnicTheme.of(context);
    final cooldownStyle = theme.styles.caption10.copyWith(color: theme.colors.blackAndWhite[600]);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: CountdownTimerBuilder(
        currentTimeProvider: provider,
        deadline: _timeout,
        builder: (context, timeRemaining) => Row(
          children: [
            Text(
              '•${(timeRemaining.isNegative ? Duration.zero : timeRemaining).formattedMMss} ',
              style: cooldownStyle,
            ),
            Text(
              appLocalizations.cooldown,
              style: cooldownStyle,
            ),
          ],
        ),
        timerCompleteBuilder: (context) => Container(),
      ),
    );
  }
}
