import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class SendReasonButton extends StatelessWidget {
  const SendReasonButton({Key? key, required this.onTapSendReport}) : super(key: key);

  final VoidCallback? onTapSendReport;
  static const _buttonPadding = EdgeInsets.symmetric(
    horizontal: 24,
    vertical: 8.0,
  );

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final blackAndWhite = colors.blackAndWhite;
    final textStyleBody30 = theme.styles.body30;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        PicnicButton(
          padding: _buttonPadding,
          titleStyle: textStyleBody30.copyWith(
            color: blackAndWhite.shade100,
          ),
          title: appLocalizations.reportFormButtonLabel,
          onTap: onTapSendReport,
        ),
        const Gap(8),
      ],
    );
  }
}
