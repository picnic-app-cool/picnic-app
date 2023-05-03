import 'package:flutter/material.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class ChatMessagesDayWidget extends StatelessWidget {
  const ChatMessagesDayWidget({
    required this.dayText,
    super.key,
  });

  final String dayText;
  static const _padding = EdgeInsets.all(8.0);
  static const _textPadding = EdgeInsets.only(
    left: 8,
    right: 8,
    top: 2,
    bottom: 2,
  );

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);

    final blackAndWhite = theme.colors.blackAndWhite;
    final dayBackgroundColor = blackAndWhite.shade300;
    final dayTextStyle = theme.styles.body10.copyWith(color: blackAndWhite.shade700);

    return Padding(
      padding: _padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                color: dayBackgroundColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                    100,
                  ),
                ),
              ),
              child: Padding(
                padding: _textPadding,
                child: Text(
                  dayText,
                  style: dayTextStyle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
