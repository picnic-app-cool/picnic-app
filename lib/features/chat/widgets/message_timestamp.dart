import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:picnic_app/utils/extensions/date_formatting.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class MessageTimestamp extends StatelessWidget {
  const MessageTimestamp({
    required this.dateTime,
    this.dateFormat,
    this.formatPrefix,
    super.key,
  });

  final DateTime? dateTime;
  final DateFormat? dateFormat;
  final String? formatPrefix;

  @override
  Widget build(BuildContext context) {
    if (dateTime == null) {
      return const SizedBox.shrink();
    }
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final dateTextTheme = theme.styles.caption10;
    final dateTextColor = colors.blackAndWhite.shade600;
    final subTitleTextStyle = dateTextTheme.copyWith(color: dateTextColor);

    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        dateTime!.formatWithPrefix(
          formatPrefix: formatPrefix,
          dateFormat: dateFormat,
        ),
        style: subTitleTextStyle,
      ),
    );
  }
}
