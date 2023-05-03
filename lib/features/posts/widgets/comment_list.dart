import 'package:flutter/material.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/comment_preview.dart';
import 'package:picnic_app/features/posts/widgets/comment_preview_item.dart';

class CommentList extends StatelessWidget {
  const CommentList({
    Key? key,
    required this.comments,
    required this.onTapCommentAuthor,
    required this.onTapLikeUnlike,
    required this.onTapReply,
    required this.onTapComment,
    required this.onLongTapComment,
    required this.onDoubleTapComment,
  }) : super(key: key);

  final List<CommentPreview> comments;
  final void Function(CommentPreview) onTapLikeUnlike;
  final void Function(CommentPreview) onTapReply;
  final void Function(CommentPreview) onTapComment;
  final void Function(CommentPreview) onLongTapComment;
  final void Function(Id) onTapCommentAuthor;
  final Function(CommentPreview) onDoubleTapComment;

  @override
  Widget build(BuildContext context) {
    return ListView(
      //we don't want to allow comments to scroll, otherwise it would interfere with vertical scroll
      // of feed
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: comments
          .map(
            (comment) => CommentPreviewItem(
              comment: comment,
              isDense: true,
              onTap: () => onTapComment(comment),
              onDoubleTap: () => onDoubleTapComment(comment),
              onLongPress: () => onLongTapComment(comment),
              onTapReply: () => onTapReply(comment),
              onTapLikeUnlike: () => onTapLikeUnlike(comment),
              onTapCommentAuthor: () => onTapCommentAuthor(comment.author.id),
            ),
          )
          .toList(),
    );
  }
}
