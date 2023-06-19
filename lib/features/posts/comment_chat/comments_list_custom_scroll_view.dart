import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/main/widgets/size_reporting_widget.dart';
import 'package:picnic_app/features/posts/comment_chat/comments_focus_target.dart';
import 'package:picnic_app/features/posts/comment_chat/widgets/feed_post_preview_in_comments.dart';
import 'package:picnic_app/features/posts/domain/model/post_overlay_theme.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/domain/model/tree_comment.dart';
import 'package:picnic_app/features/posts/widgets/comment_tree.dart';
import 'package:picnic_app/features/posts/widgets/comments_key_storage.dart';
import 'package:picnic_app/features/posts/widgets/horizontal_post_bar_buttons.dart';
import 'package:picnic_app/features/posts/widgets/post_bar_button/post_bar_button_params.dart';
import 'package:picnic_app/features/posts/widgets/post_bar_like_button/post_bar_like_button_params.dart';
import 'package:picnic_app/features/posts/widgets/post_summary_bar.dart';
import 'package:picnic_app/ui/widgets/paging_list/load_more_scroll_notification.dart';
import 'package:picnic_app/ui/widgets/poll_post/picnic_poll_post.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class CommentsListCustomScrollView extends StatefulWidget {
  const CommentsListCustomScrollView({
    super.key,
    required this.scrollController,
    required this.anchorKey,
    required this.post,
    required this.isLoadingComments,
    required this.focusTarget,
    required this.commentsRoot,
    required this.commentsKeyStorage,
    required this.onToggleFollow,
    required this.onTapTag,
    required this.onTapLink,
    required this.onVoted,
    required this.onTapLike,
    required this.onTapDislike,
    required this.onTapReply,
    required this.onTapProfile,
    required this.onLoadMore,
    required this.onTapMore,
    required this.onDoubleTap,
    required this.onLongPress,
    required this.user,
    required this.showPostSummary,
    required this.collapsedCommentIds,
    required this.onTapLikePost,
    required this.onTapDislikePost,
    required this.onTapShareCommentItem,
    required this.onTapShare,
    required this.onTapBookmark,
    this.onTap,
    this.isPolling = false,
    this.vote,
    this.commentToBeHighlighted,
  });

  final AutoScrollController scrollController;
  final GlobalKey anchorKey;
  final Post post;
  final bool isLoadingComments;
  final CommentsFocusTarget focusTarget;
  final TreeComment commentsRoot;
  final CommentsKeyStorage commentsKeyStorage;
  final PrivateProfile user;
  final PicnicPollVote? vote;
  final bool isPolling;
  final TreeComment? commentToBeHighlighted;
  final bool showPostSummary;
  final List<Id> collapsedCommentIds;

  final VoidCallback onToggleFollow;
  final VoidCallback onTapTag;
  final PostPreviewOnLinkTapCallback onTapLink;
  final PostPreviewOnVotedCallback onVoted;
  final CommentsOnTapMoreCallback onTapMore;
  final CommentsOnLikeReactUnreactTapCallback onTapLike;
  final CommentsOnDislikeReactUnreactTapCallback onTapDislike;
  final CommentsOnReplyTapCallback onTapReply;
  final CommentsOnProfileTapCallback onTapProfile;
  final CommentsOnLoadMoreCallback onLoadMore;
  final CommentsOnTapCallback? onTap;
  final CommentsOnDoubleTapLikeCallback onDoubleTap;
  final CommentsOnLongPressCallback onLongPress;
  final VoidCallback onTapLikePost;
  final VoidCallback onTapDislikePost;
  final VoidCallback onTapShare;
  final Function(String) onTapShareCommentItem;

  final VoidCallback onTapBookmark;

  @override
  State<CommentsListCustomScrollView> createState() => _CommentsListCustomScrollViewState();
}

class _CommentsListCustomScrollViewState extends State<CommentsListCustomScrollView> {
  static const thickness = 10.0;

  var _topWidgetHeight = 0.0;
  var _actionsBarWidgetHeight = 0.0;
  static const _contentPadding = EdgeInsets.symmetric(vertical: 4, horizontal: 22);

  @override
  void didUpdateWidget(covariant CommentsListCustomScrollView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.focusTarget != widget.focusTarget) {
      _onFocusTargetChanged(widget.focusTarget);
    }
  }

  @override
  Widget build(BuildContext context) {
    final commentsRoot = widget.commentsRoot;
    final topLevelComments = commentsRoot.children;

    final post = widget.post;

    const overlayTheme = PostOverlayTheme.dark;

    final actionsBarWidget = Padding(
      padding: _contentPadding,
      child: HorizontalPostBarButtons(
        likeButtonParams: PostBarLikeButtonParams(
          isLiked: post.iLiked,
          likes: post.contentStats.score.toString(),
          onTap: widget.onTapLikePost,
          overlayTheme: overlayTheme,
          isVertical: false,
        ),
        dislikeButtonParams: PostBarButtonParams(
          onTap: widget.onTapDislikePost,
          overlayTheme: overlayTheme,
          selected: post.iDisliked,
          isVertical: false,
        ),
        commentsButtonParams: PostBarButtonParams(
          onTap: doNothing,
          overlayTheme: overlayTheme,
          text: post.contentStats.comments.toString(),
          isVertical: false,
        ),
        shareButtonParams: PostBarButtonParams(
          onTap: widget.onTapShare,
          overlayTheme: overlayTheme,
          text: post.contentStats.shares.toString(),
          isVertical: false,
        ),
        bookmarkButtonParams: PostBarButtonParams(
          onTap: widget.onTapBookmark,
          overlayTheme: overlayTheme,
          text: post.contentStats.saves.toString(),
          selected: post.context.saved,
          isVertical: false,
        ),
        bookmarkEnabled: true,
      ),
    );

    final topWidget = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        PostSummaryBar(
          post: widget.post,
          author: widget.post.author,
          onToggleFollow: widget.onToggleFollow,
          onTapTag: widget.onTapTag,
          onTapAuthor: () => widget.onTapProfile(widget.post.author.id),
          overlayTheme: PostOverlayTheme.dark,
          showTagBackground: true,
        ),
        FeedPostPreviewInComments(
          post: widget.post,
          onTapLink: widget.onTapLink,
          onVoted: widget.onVoted,
          user: widget.user,
          isPolling: widget.isPolling,
          vote: widget.vote,
        ),
      ],
    );

    return Stack(
      children: [
        Opacity(
          opacity: 0,
          child: SingleChildScrollView(
            child: SizeReportingWidget(
              onSizeChange: _onTopWidgetSizeChanged,
              child: topWidget,
            ),
          ),
        ),
        Opacity(
          opacity: 0,
          child: SizeReportingWidget(
            onSizeChange: _onActionsBarWidgetSizeChanged,
            child: actionsBarWidget,
          ),
        ),
        LoadMoreScrollNotification(
          emptyItems: false,
          hasMore: topLevelComments.hasNextPage,
          loadMore: () => widget.onLoadMore(commentsRoot),
          builder: (context) => CustomScrollView(
            controller: widget.scrollController,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            // Without this param - `_scrollController.position.maxScrollExtent` gives incorrect value
            cacheExtent: double.maxFinite,
            slivers: [
              if (widget.showPostSummary && _topWidgetHeight != 0 && _actionsBarWidgetHeight != 0) ...[
                SliverAppBar(
                  expandedHeight: _topWidgetHeight + _actionsBarWidgetHeight,
                  toolbarHeight: 0,
                  flexibleSpace: FlexibleSpaceBar(
                    background: topWidget,
                    collapseMode: CollapseMode.pin,
                  ),
                  backgroundColor: Colors.white,
                  automaticallyImplyLeading: false,
                  pinned: true,
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(_actionsBarWidgetHeight),
                    child: Container(
                      color: Colors.white,
                      child: actionsBarWidget,
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: Gap(12),
                ),
              ],
              if (commentsRoot.children.isNotEmpty) ...[
                SliverToBoxAdapter(
                  child: Divider(
                    height: 1,
                    thickness: thickness,
                    color: PicnicTheme.of(context).colors.blackAndWhite.shade200,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: Gap(12),
                ),
              ],
              if (widget.isLoadingComments)
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: PicnicLoadingIndicator(),
                )
              else
                CommentTree(
                  controller: widget.scrollController,
                  keyStorage: widget.commentsKeyStorage,
                  commentsRoot: widget.commentsRoot,
                  onTapMore: widget.onTapMore,
                  onTap: (comment) => widget.onTap?.call(comment),
                  onDoubleTap: widget.onDoubleTap,
                  onLongPress: widget.onLongPress,
                  onTapLike: widget.onTapLike,
                  onTapDislike: widget.onTapDislike,
                  onReply: widget.onTapReply,
                  onLoadMore: widget.onLoadMore,
                  onProfileTap: widget.onTapProfile,
                  commentToBeHighlighted: widget.commentToBeHighlighted,
                  onTapLink: widget.onTapLink,
                  collapsedCommentIds: widget.collapsedCommentIds,
                  onTapShareCommentItem: widget.onTapShareCommentItem,
                ),
              SliverToBoxAdapter(
                child: SizedBox(
                  key: widget.anchorKey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _onTopWidgetSizeChanged(Size size) {
    setState(() {
      _topWidgetHeight = size.height;
    });
  }

  void _onActionsBarWidgetSizeChanged(Size size) {
    setState(() {
      _actionsBarWidgetHeight = size.height;
    });
  }

  void _onFocusTargetChanged(CommentsFocusTarget focusTarget) {
    // we need to wait 1 frame to be sure that `maxScrollExtent` is actual and whole tree with latest changes is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) => _handleFocusTargetChange(focusTarget));
  }

  // TODO: move to separate widget (https://picnic-app.atlassian.net/browse/GS-2265)
  void _handleFocusTargetChange(CommentsFocusTarget focusTarget) {
    if (!mounted) {
      return;
    }

    if (focusTarget is CommentsFocusTargetViewportEnd) {
      widget.scrollController.animateTo(
        widget.scrollController.position.maxScrollExtent,
        duration: const MediumDuration(),
        curve: Curves.easeOutQuad,
      );
    }

    if (focusTarget is CommentsFocusTargetComment) {
      final elementContext = widget.commentsKeyStorage.resolveContext(focusTarget.comment);
      if (elementContext == null) {
        return;
      }
      Scrollable.ensureVisible(
        elementContext,
        alignmentPolicy: ScrollPositionAlignmentPolicy.keepVisibleAtEnd,
        duration: const MediumDuration(),
        curve: Curves.easeOutQuad,
      );
    }
  }
}
