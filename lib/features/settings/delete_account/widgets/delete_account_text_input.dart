import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/current_time_provider.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/countdown_timer_builder.dart';
import 'package:picnic_app/ui/widgets/picnic_text_input.dart';
import 'package:picnic_app/utils/extensions/string_formatting.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

//ignore_for_file: unused-code, unused-files
//TODO: https://picnic-app.atlassian.net/browse/GS-1750 : UI - Delete account - implement OTP confirmation
class DeleteAccountTextInput extends StatelessWidget {
  const DeleteAccountTextInput({
    super.key,
    required this.currentTimeProvider,
    required this.deadline,
  });

  final DateTime deadline;
  final CurrentTimeProvider currentTimeProvider;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);

    final countdown = CountdownTimerBuilder(
      deadline: deadline,
      builder: (context, timeRemaining) => Padding(
        padding: const EdgeInsets.only(
          top: 12.0,
        ),
        child: Text(
          (timeRemaining.isNegative ? Duration.zero : timeRemaining).formattedMMss,
          style: theme.styles.body20.copyWith(
            color: theme.colors.blackAndWhite.shade500,
          ),
        ),
      ),
      currentTimeProvider: currentTimeProvider,
    );

    return PicnicTextInput(
      hintText: appLocalizations.verificationCodeHint,
      suffix: countdown,
      //TODO determine if the verification code is only numbers
      keyboardType: TextInputType.number,
    );
  }
}
