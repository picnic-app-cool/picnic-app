import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/core/domain/model/link_url.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/main/widgets/size_reporting_widget.dart';
import 'package:picnic_app/features/posts/domain/model/tree_comment.dart';
import 'package:picnic_app/features/posts/widgets/comment_badge.dart';
import 'package:picnic_app/features/posts/widgets/comment_tree.dart';
import 'package:picnic_app/features/posts/widgets/comment_tree_item/comment_arc.dart';
import 'package:picnic_app/features/posts/widgets/comment_tree_item/comment_line.dart';
import 'package:picnic_app/features/posts/widgets/comments_key_storage.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/achievement_badge/badged_title.dart';
import 'package:picnic_app/ui/widgets/achievement_badge/model/badged_title_displayable.dart';
import 'package:picnic_app/ui/widgets/buttons/picnic_like_button.dart';
import 'package:picnic_app/ui/widgets/expandable_link_text.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_container_icon_button.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/utils/extensions/time_ago_formatting.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class CommentTreeItem extends StatefulWidget {
  const CommentTreeItem({
    required this.treeComment,
    this.onTapMore,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    this.onTapLike,
    this.onTapDislike,
    this.onReply,
    this.onLoadMore,
    this.onProfileTap,
    this.highlightSingleColor,
    this.highlightAllColor,
    this.keyStorage,
    this.showChildren = true,
    this.collapsedCommentIds = const [],
    this.maxTextLines,
    this.onTapLink,
    this.showMoreRepliesButton = true,
    super.key,
    required this.onTapShareCommentItem,
  });

  final TreeComment treeComment;
  final CommentsOnTapMoreCallback? onTapMore;
  final CommentsOnTapCallback? onTap;
  final CommentsOnDoubleTapLikeCallback? onDoubleTap;
  final CommentsOnLongPressCallback? onLongPress;
  final CommentsOnLikeReactUnreactTapCallback? onTapLike;
  final CommentsOnDislikeReactUnreactTapCallback? onTapDislike;
  final CommentsOnReplyTapCallback? onReply;
  final CommentsKeyStorage? keyStorage;
  final CommentsOnLoadMoreCallback? onLoadMore;
  final CommentsOnProfileTapCallback? onProfileTap;
  final Color? highlightSingleColor;
  final Color? highlightAllColor;
  final bool showChildren;
  final List<Id> collapsedCommentIds;
  final int? maxTextLines;
  final Function(LinkUrl)? onTapLink;
  final bool showMoreRepliesButton;
  final Function(String) onTapShareCommentItem;

  @override
  State<CommentTreeItem> createState() => _CommentTreeItemState();
}

class _CommentTreeItemState extends State<CommentTreeItem> {
  double? _commentHeight;
  double _childsHeight = 0.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final blackAndWhite = colors.blackAndWhite;
    final blue = colors.blue;
    final lightGrey = blackAndWhite.shade300;
    final darkGrey = blackAndWhite.shade600;
    final nestingLinesColor = lightGrey;

    final authorNameColor = blackAndWhite.shade900;
    final styleBody0 = theme.styles.body0;
    final authorStyle = styleBody0.copyWith(
      color: authorNameColor,
    );
    final styleCaption10 = theme.styles.caption10;
    final children = widget.treeComment.children;

    final isDeleted = widget.treeComment.isDeleted;

    final tag = widget.treeComment.tag;

    final author = widget.treeComment.author;
    final profileImageUrl = author.profileImageUrl;

    const avatarSize = 24.0;
    const avatarSizeHalf = avatarSize / 2;
    const commentRepliesActionSize = 16.0;
    const borderRadius = 10.0;
    const commentsHighlightHeight = 80.0;
    const pinnedCommentIconSize = 14.0;
    const chatIconSize = 16.0;

    const commentArcSize = Size(avatarSize - 4, avatarSize);

    final repliesCount = widget.treeComment.repliesCount;

    const maxNestedCount = Constants.defaultCommentsDepthLevel;

    final isRoot = widget.treeComment.parent.id == const Id.empty();

    final isCollapsed = widget.collapsedCommentIds.contains(widget.treeComment.id);

    final childrenShouldBeShown = widget.showChildren && //
        widget.treeComment.parentsCount < maxNestedCount &&
        !isCollapsed;

    final timeElapsed = widget.treeComment.createdAt?.timeElapsed();

    final tappableUsernameRadius = BorderRadius.circular(10);

    const maxLines = 3;

    final dislikeIconPath =
        widget.treeComment.iDisliked ? Assets.images.dislikeFilled.path : Assets.images.dislikeOutlined.path;

    final styleCaption = styleCaption10.copyWith(color: blackAndWhite.shade600);
    final commentActions = Row(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            PicnicLikeButton(
              isLiked: widget.treeComment.iLiked,
              onTap: () => widget.onTapLike?.call(widget.treeComment),
              strokeColor: blackAndWhite.shade600,
              size: 16,
              image: Assets.images.likeOutlined,
            ),
            const Gap(2),
            Text(
              widget.treeComment.score.toString(),
              style: styleCaption,
            ),
            const Gap(6),
            GestureDetector(
              onTap: () => widget.onTapDislike?.call(widget.treeComment),
              child: Image.asset(
                dislikeIconPath,
                color: blackAndWhite.shade600,
                height: chatIconSize,
                width: chatIconSize,
              ),
            ),
          ],
        ),
        const Gap(20),
        GestureDetector(
          onTap: () => widget.onReply?.call(context, widget.treeComment),
          behavior: HitTestBehavior.opaque,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                Assets.images.chatStroked.path,
                color: blackAndWhite.shade600,
                width: chatIconSize,
                height: chatIconSize,
              ),
              const Gap(2),
              Text(
                repliesCount.toString(),
                style: styleCaption,
              ),
            ],
          ),
        ),
        const Gap(20),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => widget.onTapShareCommentItem(widget.treeComment.text),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                Assets.images.sendOutlined.path,
                color: blackAndWhite.shade600,
                width: chatIconSize,
                height: chatIconSize,
              ),
              const Gap(2),
              Text(
                appLocalizations.shareAction,
                style: styleCaption,
              ),
            ],
          ),
        ),
      ],
    );

    Widget childCommentWidget({required TreeComment child}) {
      return CommentTreeItem(
        keyStorage: widget.keyStorage,
        treeComment: child,
        onTapLike: widget.onTapLike,
        onTapDislike: widget.onTapDislike,
        onLoadMore: widget.onLoadMore,
        onReply: widget.onReply,
        onProfileTap: widget.onProfileTap,
        onTapMore: widget.onTapMore,
        onTap: widget.onTap,
        onDoubleTap: widget.onDoubleTap,
        onLongPress: widget.onLongPress,
        maxTextLines: widget.maxTextLines,
        collapsedCommentIds: widget.collapsedCommentIds,
        onTapShareCommentItem: widget.onTapShareCommentItem,
      );
    }

    Widget childrenWidget = const SizedBox();

    var childs = [...children.items];
    TreeComment? lastChild;
    if (childs.isNotEmpty) {
      lastChild = childs.removeLast();
    }

    if (childrenShouldBeShown) {
      childrenWidget = Column(
        children: [
          SizeReportingWidget(
            onSizeChange: _onChildsSizeChanged,
            child: Column(
              children: [
                const Gap(22),
                //ignore: avoid-returning-widgets
                for (final child in childs) childCommentWidget(child: child),
              ],
            ),
          ),
          //ignore: avoid-returning-widgets
          if (lastChild != null) childCommentWidget(child: lastChild),
        ],
      );
    } else {
      _childsHeight = 0.0;
    }

    return Stack(
      children: [
        if (!isRoot)
          Transform.translate(
            offset: const Offset(-avatarSize / 2 - 8, -avatarSize / 2),
            child: CommentArc(
              color: nestingLinesColor,
              size: commentArcSize,
            ),
          ),
        if (widget.highlightSingleColor != null)
          Container(
            width: double.infinity,
            height: commentsHighlightHeight,
            decoration: BoxDecoration(
              color: widget.highlightSingleColor,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
        GestureDetector(
          onTap: () => widget.onTap?.call(widget.treeComment),
          onDoubleTap: () => widget.onDoubleTap?.call(widget.treeComment),
          onLongPress: () => widget.onLongPress?.call(widget.treeComment),
          behavior: HitTestBehavior.opaque,
          child: IntrinsicHeight(
            child: Container(
              decoration: widget.highlightAllColor != null
                  ? BoxDecoration(
                      color: widget.highlightAllColor,
                      borderRadius: BorderRadius.circular(borderRadius),
                    )
                  : null,
              child: Row(
                children: [
                  Column(
                    children: [
                      if (isDeleted)
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
                          onTap: () => widget.onProfileTap?.call(author.id),
                        ),
                      if (widget.showChildren && children.isNotEmpty && _commentHeight != null)
                        Stack(
                          alignment: AlignmentDirectional.topCenter,
                          children: [
                            SizedBox(
                              height: _commentHeight! + _childsHeight - avatarSize - avatarSizeHalf,
                              child: CommentLine(
                                color: nestingLinesColor,
                              ),
                            ),
                            if (!isCollapsed)
                              Padding(
                                //ignore: no-magic-number
                                padding: EdgeInsets.only(top: _commentHeight! - avatarSize * 1.7),
                                child: Image.asset(
                                  Assets.images.commentRepliesMinus.path,
                                  height: commentRepliesActionSize,
                                  width: commentRepliesActionSize,
                                ),
                              ),
                          ],
                        ),
                    ],
                  ),
                  const Gap(8),
                  Expanded(
                    child: Column(
                      children: [
                        SizeReportingWidget(
                          onSizeChange: _onCommentSizeChanged,
                          child: Column(
                            children: [
                              Row(
                                key: widget.keyStorage?.resolveKey(widget.treeComment),
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
                                                      onTap: () => widget.onProfileTap?.call(author.id),
                                                      child: isDeleted
                                                          ? Text(
                                                              appLocalizations.commentDeletedTitle,
                                                              style: authorStyle,
                                                              overflow: TextOverflow.ellipsis,
                                                              maxLines: 1,
                                                            )
                                                          : BadgedTitle(
                                                              model: author.toBadgedAuthorDisplayable(),
                                                              style: authorStyle,
                                                            ),
                                                    ),
                                                  ),
                                                  const Gap(4),
                                                  if (timeElapsed != null) ...[
                                                    Text(
                                                      '• $timeElapsed ',
                                                      style: styleCaption10.copyWith(color: blackAndWhite.shade800),
                                                    ),
                                                  ],
                                                  const Gap(4),
                                                  if (tag != null) CommentBadge(tag: tag),
                                                ],
                                              ),
                                            ),
                                            if (widget.treeComment.isPinned)
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
                                                    style: styleBody0.copyWith(color: blue),
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
                                              isDeleted
                                                  ? appLocalizations.commentDeletedDescription
                                                  : widget.treeComment.text,
                                              maxLines: maxLines,
                                              selectable: false,
                                              maxWidth: MediaQuery.of(context).size.width - avatarSize,
                                              textStyle:
                                                  isDeleted ? styleCaption10.copyWith(color: darkGrey) : styleCaption10,
                                              onTapLink: (link) => widget.onTapLink?.call(LinkUrl(link.url)),
                                              onTap: () => widget.onTap?.call(widget.treeComment),
                                              overflow: TextOverflow.ellipsis,
                                              expandTextBuilder: (context, isExpanded) {
                                                return Text(
                                                  isExpanded ? appLocalizations.seeLess : appLocalizations.seeMore,
                                                  style: styleCaption10.copyWith(color: blue),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Gap(8),
                                  PicnicContainerIconButton(
                                    iconPath: Assets.images.options.path,
                                    onTap: () => widget.onLongPress?.call(widget.treeComment),
                                  ),
                                ],
                              ),
                              const Gap(4),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 4),
                                    child: commentActions,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        childrenWidget,
                        if (isCollapsed) ...[
                          Stack(
                            children: [
                              Transform.translate(
                                offset: const Offset(-avatarSizeHalf - 8, -avatarSizeHalf),
                                child: SizedBox(
                                  height: avatarSizeHalf,
                                  width: 1,
                                  child: CommentLine(
                                    color: nestingLinesColor,
                                  ),
                                ),
                              ),
                              Transform.translate(
                                offset: const Offset(-avatarSizeHalf - 8, 0),
                                child: CommentArc(
                                  size: commentArcSize,
                                  color: nestingLinesColor,
                                ),
                              ),
                              Column(
                                children: [
                                  //ignore: no-magic-number
                                  Gap(commentArcSize.height - commentRepliesActionSize / 2),
                                  Row(
                                    children: [
                                      const Gap(2),
                                      Image.asset(
                                        Assets.images.commentRepliesPlus.path,
                                        height: commentRepliesActionSize,
                                        width: commentRepliesActionSize,
                                      ),
                                      const Gap(5),
                                      Text(
                                        appLocalizations.moreRepliesMessage(repliesCount),
                                        style: styleBody0.copyWith(color: colors.darkBlue.shade600),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                        if (!childrenShouldBeShown) const Gap(18),
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

  void _onCommentSizeChanged(Size size) {
    if (size.height != _commentHeight) {
      setState(() {
        _commentHeight = size.height;
      });
    }
  }

  void _onChildsSizeChanged(Size size) {
    if (size.height != _childsHeight) {
      setState(() {
        _childsHeight = size.height;
      });
    }
  }
}
