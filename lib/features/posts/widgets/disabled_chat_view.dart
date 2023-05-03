import 'package:flutter/material.dart';
import 'package:picnic_app/features/posts/widgets/disabled_comments_view.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class DisabledChatView extends StatelessWidget {
  const DisabledChatView({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final blackAndWhite = theme.colors.blackAndWhite;
    final borderColor = blackAndWhite.shade300;
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        color: borderColor,
      ),
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(
          top: 1,
          left: 1,
          right: 1,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          color: blackAndWhite.shade100,
        ),
        child: DisabledCommentsView(
          text: text,
        ),
      ),
    );
  }
}
