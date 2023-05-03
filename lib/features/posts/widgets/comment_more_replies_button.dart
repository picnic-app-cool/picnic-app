import 'package:flutter/material.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_text_button.dart';

class CommentMoreRepliesButton extends StatelessWidget {
  const CommentMoreRepliesButton({
    required this.moreRepliesCount,
    required this.onTap,
    super.key,
  });

  final VoidCallback onTap;
  final int moreRepliesCount;

  static const expandIconSize = 24.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final green = theme.colors.green.shade500;

    return Align(
      alignment: Alignment.centerLeft,
      child: PicnicTextButton(
        leadingIcon: Image.asset(
          Assets.images.reply.path,
          height: expandIconSize,
          width: expandIconSize,
          color: green,
        ),
        label: appLocalizations.moreRepliesMessage(moreRepliesCount),
        labelStyle: theme.styles.body20.copyWith(
          color: green,
        ),
        onTap: onTap,
      ),
    );
  }
}
