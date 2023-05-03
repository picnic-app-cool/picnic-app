import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/utils/stat_extensions.dart';
import 'package:picnic_app/features/chat/chat_feed/widgets/feed_list_header.dart';
import 'package:picnic_app/features/chat/chat_feed/widgets/non_scrollable_feed_list_message.dart';
import 'package:picnic_app/features/chat/chat_feed/widgets/scrollable_feed_list_message.dart';
import 'package:picnic_app/features/chat/domain/model/chat_messages_feed.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class FeedListItem extends StatelessWidget {
  const FeedListItem({
    Key? key,
    required this.chatMessagesFeed,
    this.onTapCircle,
    this.onTapFeed,
    this.messageIdToScrollTo,
  }) : super(key: key);

  final ChatMessagesFeed chatMessagesFeed;
  final ValueChanged<Circle>? onTapCircle;
  final ValueChanged<Circle>? onTapFeed;
  final Id? messageIdToScrollTo;

  static const _borderWidth = 6.0;
  static const _borderRadius = 16.0;
  static const _messageContainerHeight = 236.0;
  static const _blurRadius = 40.0;
  static const _boxShadowOpacity = 0.05;
  static const _boxBackgroundOpacity = 0.5;
  static const _disabledBackgroundOpacity = 0.1;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final blackAndWhiteColor = colors.blackAndWhite;
    final boxBackgroundColor = blackAndWhiteColor.shade200.withOpacity(_boxBackgroundOpacity);

    final circle = chatMessagesFeed.circle;
    final chatEnabled = circle.chatEnabled && circle.hasPermissionToChat;

    return InkWell(
      onTap: () => onTapFeed?.call(chatMessagesFeed.circle),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: _blurRadius,
              color: blackAndWhiteColor.shade900.withOpacity(_boxShadowOpacity),
              offset: const Offset(0, 16),
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(_borderRadius),
          border: Border.all(
            width: _borderWidth,
            color: Colors.white,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Gap(8),
            FeedListHeader(
              onTapImage: () => onTapCircle?.call(chatMessagesFeed.circle),
              title: chatMessagesFeed.name,
              emoji: chatMessagesFeed.emoji,
              image: chatMessagesFeed.image,
              subTitle: appLocalizations.membersCount(chatMessagesFeed.membersCount).replaceAll(
                    chatMessagesFeed.membersCount.toString(),
                    chatMessagesFeed.membersCount.formattingToStat(),
                  ),
            ),
            const Gap(4),
            Container(
              height: _messageContainerHeight,
              decoration: BoxDecoration(
                color: chatEnabled
                    ? boxBackgroundColor
                    : blackAndWhiteColor.shade900.withOpacity(_disabledBackgroundOpacity),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(_borderRadius),
                  bottomRight: Radius.circular(_borderRadius),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: (messageIdToScrollTo != null)
                    ? ScrollableFeedListMessage(
                        chatMessages: chatMessagesFeed.messages,
                        messageIdToScrollTo: messageIdToScrollTo,
                      )
                    : NonScrollableFeedListMessage(
                        chatMessages: chatMessagesFeed.messages,
                      ),
              ),
            ),
            if (!chatEnabled)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  appLocalizations.disabledChatLabel,
                  textAlign: TextAlign.center,
                  style: theme.styles.body10,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
