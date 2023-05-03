import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/comment_preview.dart';
import 'package:picnic_app/features/posts/widgets/comment_preview_item.dart';

class CommentFixedList extends StatelessWidget {
  const CommentFixedList({
    Key? key,
    required this.availableHeight,
    required this.comments,
    required this.onTapCommentAuthor,
    required this.onTapLikeUnlike,
    required this.onTapReply,
    required this.onTapComment,
    required this.onLongTapComment,
    required this.onDoubleTapComment,
  }) : super(key: key);

  final double availableHeight;
  final List<CommentPreview> comments;
  final void Function(CommentPreview) onTapLikeUnlike;
  final void Function(CommentPreview) onTapReply;
  final void Function(CommentPreview) onLongTapComment;
  final void Function(CommentPreview) onTapComment;
  final Function(CommentPreview) onDoubleTapComment;
  final void Function(Id) onTapCommentAuthor;

  @override
  Widget build(BuildContext context) {
    const commentSize = 42.0;
    final maxPossibleNumberOfCommentsToDisplay = (availableHeight / commentSize).floor();
    final numberOfCommentsToDisplay = math.min(comments.length, maxPossibleNumberOfCommentsToDisplay);
    final maxHeight = numberOfCommentsToDisplay * commentSize;

    return AnimatedSize(
      duration: const ShortDuration(),
      child: SizedBox(
        height: maxHeight,
        child: ListView.builder(
          //we don't want to allow comments to scroll, otherwise it would interfere with vertical scroll
          // of feed
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemExtent: commentSize,
          itemCount: numberOfCommentsToDisplay,
          itemBuilder: (context, index) {
            final comment = comments[index];
            return CommentPreviewItem(
              comment: comments[index],
              isDense: true,
              onTap: () => onTapComment(comment),
              onDoubleTap: () => onDoubleTapComment(comment),
              onLongPress: () => onLongTapComment(comment),
              onTapReply: () => onTapReply(comment),
              onTapLikeUnlike: () => onTapLikeUnlike(comment),
              onTapCommentAuthor: () => onTapCommentAuthor(comment.author.id),
            );
          },
        ),
      ),
    );
  }
}
