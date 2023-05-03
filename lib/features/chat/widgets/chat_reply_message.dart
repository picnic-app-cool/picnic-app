import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class ChatReplyMessage extends StatelessWidget {
  const ChatReplyMessage({
    required this.message,
    required this.onTapCancelReply,
  });

  final ChatMessage message;
  final VoidCallback onTapCancelReply;

  static const _verticalDividerWidth = 2.0;
  static const _closeIconWidth = 18.0;
  static const _replyTextOpacity = .6;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final textStyleBody10 = theme.styles.body10;
    final textStyleCaption10 = theme.styles.caption10;
    final title = appLocalizations.chatReply(
      message.repliedContent?.authorFormattedUsername ?? '',
    );
    final blackAndWhite = theme.colors.blackAndWhite;

    final replyIcon = Image.asset(
      Assets.images.reply.path,
      color: blackAndWhite.shade600,
    );
    final verticalDivider = Container(
      color: theme.colors.darkBlue.shade600,
      width: _verticalDividerWidth,
    );

    final closeIcon = Image.asset(
      Assets.images.close.path,
      width: _closeIconWidth,
    );
    return IntrinsicHeight(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Constants.defaultPadding),
        child: Row(
          children: [
            replyIcon,
            const Gap(24),
            verticalDivider,
            const Gap(8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: textStyleBody10.copyWith(
                            color: blackAndWhite.shade800.withOpacity(_replyTextOpacity),
                          ),
                        ),
                      ),
                      InkWell(onTap: onTapCancelReply, child: closeIcon),
                    ],
                  ),
                  const Gap(2),
                  Text(
                    message.content,
                    style: textStyleCaption10.copyWith(
                      color: blackAndWhite.shade600.withOpacity(_replyTextOpacity),
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
