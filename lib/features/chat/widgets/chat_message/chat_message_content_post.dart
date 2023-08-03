import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/features/chat/domain/model/displayable_chat_message.dart';
import 'package:picnic_app/features/chat/widgets/chat_message/chat_message_content_post_summary.dart';
import 'package:picnic_app/features/chat/widgets/chat_message/picnic_chat_style.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/image_post_content.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/link_post_content.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/poll_post_content.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/text_post_content.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/video_post_content.dart';
import 'package:picnic_app/features/posts/domain/model/post_type.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/link_post/widgets/link_placeholder.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_image.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/ui/widgets/poll_post/picnic_poll_post.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class ChatMessageContentPost extends StatelessWidget {
  const ChatMessageContentPost({
    required this.post,
    required this.onTap,
    required this.displayableMessage,
    required this.chatStyle,
  });

  final Post post;
  final VoidCallback onTap;
  final DisplayableChatMessage displayableMessage;
  final PicnicChatStyle chatStyle;
  static const _contentPadding = EdgeInsets.all(14);
  static const _textMaxLines = 4;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final styles = theme.styles;

    final black = colors.blackAndWhite.shade900;
    final white = colors.blackAndWhite.shade100;

    final borderColor = colors.darkBlue.shade300;

    final _containerBorderRadius = BorderRadius.circular(16);
    final _defaultBorderRadius = BorderRadius.circular(8);
    final screenSize = MediaQuery.of(context).size;
    final containerWidth = 246.0 * (screenSize.width / 375.0);

    final contentTextStyle = styles.body10.copyWith(
      color: colors.darkBlue.shade800,
    );

    Widget postContentWidget = const SizedBox();

    if (post == const Post.empty()) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: _containerBorderRadius,
          border: Border.all(
            color: borderColor,
          ),
        ),
        child: Padding(
          padding: _contentPadding,
          child: Text(
            appLocalizations.postNotAvailable,
            style: contentTextStyle,
          ),
        ),
      );
    }

    switch (post.type) {
      case PostType.text:
        postContentWidget = Text(
          (post.content as TextPostContent).text,
          style: contentTextStyle,
          maxLines: _textMaxLines,
          overflow: TextOverflow.ellipsis,
        );
        break;
      case PostType.image:
        final postContent = post.content as ImagePostContent;
        postContentWidget = Column(
          children: [
            if (postContent.text.isNotEmpty) ...[
              Text(
                postContent.text,
                style: contentTextStyle,
                maxLines: _textMaxLines,
                overflow: TextOverflow.ellipsis,
              ),
              const Gap(12),
            ],
            AspectRatio(
              aspectRatio: 1.0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: _defaultBorderRadius,
                ),
                clipBehavior: Clip.hardEdge,
                child: PicnicImage(
                  source: PicnicImageSource.url(
                    postContent.imageUrl,
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                ),
              ),
            ),
          ],
        );
        break;
      case PostType.video:
        final videoContainerWidth = 164.0 * (screenSize.width / 375.0);
        final videoContainerHeight = 220.0 * videoContainerWidth / 164.0;
        return InkWell(
          onTap: onTap,
          child: IgnorePointer(
            child: Container(
              width: videoContainerWidth,
              height: videoContainerHeight,
              decoration: BoxDecoration(
                borderRadius: _defaultBorderRadius,
              ),
              clipBehavior: Clip.hardEdge,
              child: Stack(
                children: [
                  PicnicImage(
                    source: PicnicImageSource.url(
                      (post.content as VideoPostContent).thumbnailUrl,
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: double.infinity,
                    ),
                  ),
                  Positioned(
                    left: 0,
                    bottom: 0,
                    width: videoContainerWidth,
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: ChatMessageContentPostSummary(
                        post: post,
                      ),
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      Assets.images.chatPostPlay.path,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      case PostType.link:
        final postContent = post.content as LinkPostContent;

        final image = Stack(
          children: [
            PicnicImage(
              source: PicnicImageSource.imageUrl(
                postContent.metadata.imageUrl,
                width: double.infinity,
                height: 80,
                fit: BoxFit.cover,
              ),
              placeholder: () => LinkPlaceholder(
                linkUrl: postContent.linkUrl,
              ),
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: _gradient(black),
                ),
              ),
            ),
          ],
        );

        postContentWidget = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (postContent.metadata.description.isNotEmpty) ...[
              Text(
                postContent.metadata.description,
                style: contentTextStyle,
                maxLines: _textMaxLines,
                overflow: TextOverflow.ellipsis,
              ),
              const Gap(12),
            ],
            ClipRRect(
              borderRadius: _defaultBorderRadius,
              child: Stack(
                children: [
                  image,
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 10.0,
                        bottom: 10.0,
                        right: 10.0,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            postContent.metadata.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.styles.link20.copyWith(color: white),
                          ),
                          Text(
                            postContent.metadata.host,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.styles.body0.copyWith(color: white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
        break;
      case PostType.poll:
        final contentWidth = 218.0 * (screenSize.width / 375.0);
        final contentHeight = 188.0 * contentWidth / 218.0;
        final pollContent = post.content as PollPostContent;

        var vote = pollContent.votedAnswerId.isNone
            ? null
            : (pollContent.votedAnswerId == pollContent.rightPollAnswer.id
                ? PicnicPollVote.right
                : PicnicPollVote.left);

        postContentWidget = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (pollContent.question.isNotEmpty) ...[
              Text(
                pollContent.question,
                style: contentTextStyle,
              ),
              const Gap(12),
            ],
            SizedBox(
              width: contentWidth,
              height: contentHeight,
              child: PicnicPollPost(
                onVote: (_) => doNothing,
                leftImage: pollContent.leftPollAnswer.imageUrl,
                rightImage: pollContent.rightPollAnswer.imageUrl,
                leftVotes: pollContent.leftVotesPercentage,
                rightVotes: pollContent.rightVotesPercentage,
                showAvatar: false,
                vote: vote,
                withRoundedCorners: true,
              ),
            ),
          ],
        );
        break;
      case PostType.unknown:
        break;
    }

    return InkWell(
      onTap: onTap,
      child: IgnorePointer(
        child: Container(
          width: containerWidth,
          decoration: BoxDecoration(
            borderRadius: _containerBorderRadius,
            border: Border.all(
              color: borderColor,
            ),
          ),
          child: Padding(
            padding: _contentPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ChatMessageContentPostSummary(
                  post: post,
                ),
                const Gap(12),
                postContentWidget,
              ],
            ),
          ),
        ),
      ),
    );
  }

  LinearGradient _gradient(Color color) {
    final colorWithOpacity20 = color.withOpacity(0.2);
    final colorWithOpacity0 = color.withOpacity(0.0);
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        colorWithOpacity0,
        colorWithOpacity0,
        colorWithOpacity0,
        colorWithOpacity0,
        colorWithOpacity20,
      ],
    );
  }
}
