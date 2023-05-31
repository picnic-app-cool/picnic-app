import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/link_url.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/tree_comment.dart';
import 'package:picnic_app/features/posts/widgets/comment_tree_item/comment_tree_item.dart';
import 'package:picnic_app/features/posts/widgets/comments_key_storage.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

typedef CommentsOnLikeUnlikeTapCallback = void Function(TreeComment);
typedef CommentsOnLoadMoreCallback = Future<void> Function(TreeComment);
typedef CommentsOnReplyTapCallback = void Function(BuildContext, TreeComment);
typedef CommentsOnProfileTapCallback = void Function(Id);

typedef CommentsOnTapMoreCallback = void Function(TreeComment);

typedef CommentsOnTapCallback = void Function(TreeComment);
typedef CommentsOnDoubleTapLikeCallback = void Function(TreeComment);
typedef CommentsOnLongPressCallback = void Function(TreeComment);

class CommentTree extends StatelessWidget {
  const CommentTree({
    required this.commentsRoot,
    required this.onTapMore,
    required this.onTap,
    required this.onDoubleTap,
    required this.onLongPress,
    required this.onTapLike,
    required this.onReply,
    required this.onLoadMore,
    required this.onProfileTap,
    required this.onTapLink,
    required this.controller,
    required this.collapsedCommentIds,
    this.commentToBeHighlighted,
    this.keyStorage,
    required this.onTapShareCommentItem,
    super.key,
  });

  final TreeComment commentsRoot;
  final CommentsKeyStorage? keyStorage;
  final CommentsOnLikeUnlikeTapCallback onTapLike;

  final CommentsOnTapMoreCallback onTapMore;

  final CommentsOnTapCallback onTap;
  final CommentsOnDoubleTapLikeCallback onDoubleTap;
  final CommentsOnLongPressCallback onLongPress;
  final CommentsOnReplyTapCallback onReply;
  final CommentsOnLoadMoreCallback onLoadMore;
  final CommentsOnProfileTapCallback onProfileTap;
  final AutoScrollController controller;
  final Function(LinkUrl) onTapLink;
  final TreeComment? commentToBeHighlighted;
  final List<Id> collapsedCommentIds;
  final Function(String) onTapShareCommentItem;

  @override
  Widget build(BuildContext context) {
    final colors = PicnicTheme.of(context).colors;
    final pink = colors.pink[100];
    final green = colors.blue[200];
    final comments = commentsRoot.children;

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final comment = comments[index];
            return AutoScrollTag(
              key: ValueKey(index),
              controller: controller,
              index: index,
              child: CommentTreeItem(
                treeComment: comment,
                keyStorage: keyStorage,
                onTapMore: onTapMore,
                onTap: onTap,
                onDoubleTap: onDoubleTap,
                onLongPress: onLongPress,
                onLikeUnlikeTap: onTapLike,
                onReply: onReply,
                onLoadMore: onLoadMore,
                onProfileTap: onProfileTap,
                onTapLink: onTapLink,
                onTapShareCommentItem: onTapShareCommentItem,
                collapsedCommentIds: collapsedCommentIds,
                highlightAllColor: comment.id == commentToBeHighlighted?.id ? pink : null,
                highlightSingleColor:
                    commentsRoot.hasParent && commentsRoot.children.first.id == comment.id ? green : null,
                showMoreRepliesButton: !commentsRoot.hasParent,
              ),
            );
          },
          childCount: comments.length,
        ),
      ),
    );
  }
}
