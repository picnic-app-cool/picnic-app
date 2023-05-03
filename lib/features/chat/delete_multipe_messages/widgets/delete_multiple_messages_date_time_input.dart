import 'package:flutter/material.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_text_input.dart';
import 'package:picnic_app/utils/extensions/date_formatting.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class DeleteMultipleMessagesDateTimeInput extends StatelessWidget {
  const DeleteMultipleMessagesDateTimeInput({
    required this.title,
    required this.dateTime,
    required this.onTapInput,
  });

  final String title;
  final DateTime dateTime;
  final VoidCallback onTapInput;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final textStyleBody20 = theme.styles.body20;
    final iconColor = theme.colors.blackAndWhite.shade600;
    final calenderIcon = Image.asset(
      Assets.images.calendar.path,
      color: iconColor,
    );

    return PicnicTextInput(
      //The form field will change every time the Key changes.
      key: Key(dateTime.toIso8601String()),
      readOnly: true,
      initialValue: dateTime.yMdjmFormat(),
      outerLabel: Text(
        title,
        style: textStyleBody20,
      ),
      suffix: InkWell(
        onTap: onTapInput,
        child: calenderIcon,
      ),
      inputTextStyle: textStyleBody20,
      padding: 0,
    );
  }
}
