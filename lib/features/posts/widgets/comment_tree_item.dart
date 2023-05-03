import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/core/domain/model/link_url.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/tree_comment.dart';
import 'package:picnic_app/features/posts/widgets/comment_badge.dart';
import 'package:picnic_app/features/posts/widgets/comment_more_replies_button.dart';
import 'package:picnic_app/features/posts/widgets/comment_tree.dart';
import 'package:picnic_app/features/posts/widgets/comments_key_storage.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/achievement_badge/badged_title.dart';
import 'package:picnic_app/ui/widgets/achievement_badge/model/badged_title_displayable.dart';
import 'package:picnic_app/ui/widgets/expandable_link_text.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/ui/widgets/picnic_like_heart_column.dart';
import 'package:picnic_app/utils/extensions/time_ago_formatting.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/animated_vertical_slide.dart';

class CommentTreeItem extends StatelessWidget {
  const CommentTreeItem({
    required this.treeComment,
    this.onTapMore,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    this.onLikeUnlikeTap,
    this.onReply,
    this.onLoadMore,
    this.onProfileTap,
    this.highlightSingleColor,
    this.highlightAllColor,
    this.keyStorage,
    this.showChildren = true,
    this.collapsedCommentIds = const [],
    this.maxTextLines,
    this.suppressBottomPadding = false,
    this.onTapLink,
    this.showMoreRepliesButton = true,
    super.key,
  });

  final TreeComment treeComment;
  final CommentsOnTapMoreCallback? onTapMore;
  final CommentsOnTapCallback? onTap;
  final CommentsOnDoubleTapLikeCallback? onDoubleTap;
  final CommentsOnLongPressCallback? onLongPress;
  final CommentsOnLikeUnlikeTapCallback? onLikeUnlikeTap;
  final CommentsOnReplyTapCallback? onReply;
  final CommentsKeyStorage? keyStorage;
  final CommentsOnLoadMoreCallback? onLoadMore;
  final CommentsOnProfileTapCallback? onProfileTap;
  final Color? highlightSingleColor;
  final Color? highlightAllColor;
  final bool suppressBottomPadding;
  final bool showChildren;
  final List<Id> collapsedCommentIds;
  final int? maxTextLines;
  final Function(LinkUrl)? onTapLink;
  final bool showMoreRepliesButton;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final blackAndWhite = colors.blackAndWhite;
    final green = colors.green;
    final lightGrey = blackAndWhite.shade300;
    final darkGrey = blackAndWhite.shade600;

    final authorNameColor = blackAndWhite.shade900.withOpacity(0.4);
    final styleBody0 = theme.styles.body0;
    final authorStyle = styleBody0.copyWith(
      color: authorNameColor,
    );
    final styleCaption10 = theme.styles.caption10;
    final children = treeComment.children;

    final profileImageUrl = treeComment.author.profileImageUrl;

    const avatarSize = 24.0;
    const borderRadius = 10.0;
    const commentsHighlightHeight = 80.0;
    const commentsLineWidth = 2.0;
    const commentsLineBorderRadius = 100.0;
    const pinnedCommentIconSize = 14.0;
    const chatIconSize = 16.0;
    const expandIconSize = 24.0;

    final hasMore = treeComment.repliesCount > 0;

    const maxNestedCount = Constants.defaultCommentsDepthLevel;

    final isCollapsed = collapsedCommentIds.contains(treeComment.id);

    final childrenShouldBeShown = showChildren && //
        treeComment.parentsCount < maxNestedCount &&
        !isCollapsed;

    final timeElapsed = treeComment.createdAt?.timeElapsed();

    final tappableUsernameRadius = BorderRadius.circular(10);

    const maxLines = 3;

    return Stack(
      children: [
        if (highlightSingleColor != null)
          Container(
            width: double.infinity,
            height: commentsHighlightHeight,
            decoration: BoxDecoration(
              color: highlightSingleColor,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
        GestureDetector(
          onTap: () => onTap?.call(treeComment),
          onDoubleTap: () => onDoubleTap?.call(treeComment),
          onLongPress: () => onLongPress?.call(treeComment),
          behavior: HitTestBehavior.opaque,
          child: IntrinsicHeight(
            child: Container(
              decoration: highlightAllColor != null
                  ? BoxDecoration(
                      color: highlightAllColor,
                      borderRadius: BorderRadius.circular(borderRadius),
                    )
                  : null,
              child: Row(
                children: [
                  Column(
                    children: [
                      if (treeComment.isDeleted)
                        Container(
                          width: avatarSize,
                          height: avatarSize,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: lightGrey,
                          ),
                          child: const Icon(
                            Icons.error_outline,
                            size: 17,
                          ),
                        )
                      else
                        PicnicAvatar(
                          imageSource: profileImageUrl.isAsset
                              ? PicnicImageSource.asset(profileImageUrl, fit: BoxFit.cover)
                              : PicnicImageSource.url(profileImageUrl, fit: BoxFit.cover),
                          size: avatarSize,
                          boxFit: PicnicAvatarChildBoxFit.cover,
                          onTap: () => onProfileTap?.call(treeComment.author.id),
                        ),
                      if (showChildren && children.isNotEmpty)
                        Expanded(
                          child: Container(
                            width: commentsLineWidth,
                            margin: const EdgeInsets.only(top: 5, bottom: 11),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(commentsLineBorderRadius),
                              color: blackAndWhite.shade300,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const Gap(8),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          key: keyStorage?.resolveKey(treeComment),
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Flexible(
                                              child: InkWell(
                                                borderRadius: tappableUsernameRadius,
                                                onTap: () => onProfileTap?.call(treeComment.author.id),
                                                child: treeComment.isDeleted
                                                    ? Text(
                                                        appLocalizations.commentDeletedTitle,
                                                        style: authorStyle,
                                                        overflow: TextOverflow.ellipsis,
                                                        maxLines: 1,
                                                      )
                                                    : BadgedTitle(
                                                        model: treeComment.author.toBadgedAuthorDisplayable(),
                                                        style: authorStyle,
                                                      ),
                                              ),
                                            ),
                                            const Gap(4),
                                            if (treeComment.tag != null) CommentBadge(tag: treeComment.tag!),
                                          ],
                                        ),
                                      ),
                                      if (treeComment.isPinned)
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            const Gap(4),
                                            Image.asset(
                                              Assets.images.pinnedComment.path,
                                              height: pinnedCommentIconSize,
                                              width: pinnedCommentIconSize,
                                            ),
                                            const Gap(4),
                                            Text(
                                              appLocalizations.commentPinnedTitle,
                                              style: styleBody0.copyWith(color: green),
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ExpandableLinkText(
                                        treeComment.isDeleted
                                            ? appLocalizations.commentDeletedDescription
                                            : treeComment.text,
                                        maxLines: maxLines,
                                        selectable: false,
                                        maxWidth: MediaQuery.of(context).size.width - avatarSize,
                                        textStyle: treeComment.isDeleted
                                            ? styleCaption10.copyWith(color: darkGrey)
                                            : styleCaption10,
                                        onTapLink: (link) => onTapLink?.call(LinkUrl(link.url)),
                                        onTap: () => onTap?.call(treeComment),
                                        overflow: TextOverflow.ellipsis,
                                        expandTextBuilder: (context, isExpanded) {
                                          return Text(
                                            isExpanded ? appLocalizations.seeLess : appLocalizations.seeMore,
                                            style: styleCaption10.copyWith(color: green),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Gap(8),
                            PicnicLikeHeartColumn(
                              likesCount: treeComment.likesCount,
                              onTapLikeHeart: () => onLikeUnlikeTap?.call(treeComment),
                              liked: treeComment.isLiked,
                            ),
                          ],
                        ),
                        const Gap(4),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () => onReply?.call(context, treeComment),
                              behavior: HitTestBehavior.opaque,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4),
                                child: Row(
                                  children: [
                                    if (timeElapsed != null) ...[
                                      Text(
                                        '$timeElapsed • ',
                                        style: styleCaption10.copyWith(color: blackAndWhite.shade800),
                                      ),
                                    ],
                                    Image.asset(
                                      Assets.images.chatStroked.path,
                                      color: blackAndWhite.shade600,
                                      width: chatIconSize,
                                      height: chatIconSize,
                                    ),
                                    const Gap(4),
                                    Text(
                                      appLocalizations.replyAction,
                                      style: styleCaption10.copyWith(color: blackAndWhite.shade600),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (isCollapsed) ...[
                              const Gap(8),
                              Expanded(
                                child: InkWell(
                                  onTap: () => onTap?.call(treeComment),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Image.asset(
                                        Assets.images.reply.path,
                                        height: expandIconSize,
                                        width: expandIconSize,
                                        color: green,
                                      ),
                                      const Gap(8),
                                      Flexible(
                                        child: Text(
                                          appLocalizations.moreRepliesMessage(treeComment.repliesCount),
                                          style: theme.styles.body20.copyWith(color: green),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        AnimatedVerticalSlide(
                          show: childrenShouldBeShown,
                          child: Column(
                            children: [
                              const Gap(22),
                              for (final child in children)
                                CommentTreeItem(
                                  keyStorage: keyStorage,
                                  treeComment: child,
                                  onLikeUnlikeTap: onLikeUnlikeTap,
                                  onLoadMore: onLoadMore,
                                  onReply: onReply,
                                  onProfileTap: onProfileTap,
                                  onTapMore: onTapMore,
                                  onTap: onTap,
                                  onDoubleTap: onDoubleTap,
                                  onLongPress: onLongPress,
                                  maxTextLines: maxTextLines,
                                  collapsedCommentIds: collapsedCommentIds,
                                  suppressBottomPadding: child == children.last,
                                ),
                              const Gap(4),
                            ],
                          ),
                        ),
                        if (showMoreRepliesButton && hasMore && treeComment.parentsCount == maxNestedCount)
                          CommentMoreRepliesButton(
                            moreRepliesCount: treeComment.repliesCount,
                            onTap: () => onTapMore?.call(treeComment),
                          ),
                        if (!childrenShouldBeShown && !suppressBottomPadding) const Gap(18),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
