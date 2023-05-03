import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/comment_chat/comments_focus_target.dart';
import 'package:picnic_app/features/posts/comment_chat/widgets/feed_post_preview_in_comments.dart';
import 'package:picnic_app/features/posts/domain/model/post_overlay_theme.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/domain/model/tree_comment.dart';
import 'package:picnic_app/features/posts/widgets/comment_tree.dart';
import 'package:picnic_app/features/posts/widgets/comments_key_storage.dart';
import 'package:picnic_app/features/posts/widgets/post_summary_bar.dart';
import 'package:picnic_app/ui/widgets/paging_list/load_more_scroll_notification.dart';
import 'package:picnic_app/ui/widgets/poll_post/picnic_poll_post.dart';
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
    required this.onTapReply,
    required this.onTapProfile,
    required this.onLoadMore,
    required this.onTapMore,
    required this.onDoubleTap,
    required this.onLongPress,
    required this.user,
    required this.showPostSummary,
    required this.collapsedCommentIds,
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
  final CommentsOnLikeUnlikeTapCallback onTapLike;
  final CommentsOnReplyTapCallback onTapReply;
  final CommentsOnProfileTapCallback onTapProfile;
  final CommentsOnLoadMoreCallback onLoadMore;
  final CommentsOnTapCallback? onTap;
  final CommentsOnDoubleTapLikeCallback onDoubleTap;
  final CommentsOnLongPressCallback onLongPress;

  @override
  State<CommentsListCustomScrollView> createState() => _CommentsListCustomScrollViewState();
}

class _CommentsListCustomScrollViewState extends State<CommentsListCustomScrollView> {
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
    return LoadMoreScrollNotification(
      emptyItems: false,
      hasMore: topLevelComments.hasNextPage,
      loadMore: () => widget.onLoadMore(commentsRoot),
      builder: (context) => CustomScrollView(
        controller: widget.scrollController,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        // Without this param - `_scrollController.position.maxScrollExtent` gives incorrect value
        cacheExtent: double.maxFinite,
        slivers: [
          if (widget.showPostSummary)
            SliverToBoxAdapter(
              child: Column(
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
                  const Gap(20),
                ],
              ),
            ),
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
              onReply: widget.onTapReply,
              onLoadMore: widget.onLoadMore,
              onProfileTap: widget.onTapProfile,
              commentToBeHighlighted: widget.commentToBeHighlighted,
              onTapLink: widget.onTapLink,
              collapsedCommentIds: widget.collapsedCommentIds,
            ),
          SliverToBoxAdapter(
            child: SizedBox(
              key: widget.anchorKey,
            ),
          ),
        ],
      ),
    );
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
