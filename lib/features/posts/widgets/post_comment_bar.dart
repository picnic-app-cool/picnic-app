import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/features/posts/comment_chat/widgets/comment_chat_reply_bar.dart';
import 'package:picnic_app/features/posts/domain/model/comment_preview.dart';
import 'package:picnic_app/features/posts/domain/model/post_overlay_theme.dart';
import 'package:picnic_app/features/posts/widgets/horizontal_post_bar_buttons.dart';
import 'package:picnic_app/features/posts/widgets/post_bar_button/post_bar_button_params.dart';
import 'package:picnic_app/features/posts/widgets/post_bar_like_button/post_bar_like_button_params.dart';
import 'package:picnic_app/features/posts/widgets/vertical_post_bar_buttons.dart';

class PostCommentBar extends StatefulWidget {
  const PostCommentBar({
    required this.likeButtonParams,
    required this.commentsButtonParams,
    required this.shareButtonParams,
    required this.dislikeButtonParams,
    required this.bookmarkButtonParams,
    required this.bookmarkEnabled,
    required this.hasActionsBelow,
    required this.overlayTheme,
    this.focusNode,
    this.replyingComment = const CommentPreview.empty(),
    this.onTapCancelReply,
    this.buttonsAreVertical = false,
    super.key,
  });

  final bool hasActionsBelow;
  final CommentPreview replyingComment;
  final VoidCallback? onTapCancelReply;
  final FocusNode? focusNode;

  final PostOverlayTheme overlayTheme;
  final PostBarLikeButtonParams likeButtonParams;
  final PostBarButtonParams commentsButtonParams;
  final PostBarButtonParams shareButtonParams;
  final PostBarButtonParams bookmarkButtonParams;
  final PostBarButtonParams dislikeButtonParams;
  final bool bookmarkEnabled;
  final bool buttonsAreVertical;

  @override
  State<PostCommentBar> createState() => _PostCommentBarState();
}

class _PostCommentBarState extends State<PostCommentBar> {
  final spacing = const Gap(8);
  final commentController = TextEditingController();

  bool isUserTyping = false;

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          if (widget.replyingComment != const CommentPreview.empty()) ...[
            CommentChatReplyBar(
              comment: widget.replyingComment,
              onTapCancelReply: widget.onTapCancelReply,
            ),
            const Gap(14),
          ],
          if (widget.buttonsAreVertical)
            Row(
              children: [
                Expanded(child: Container()),
                VerticalPostBarButtons(
                  likeButtonParams: widget.likeButtonParams,
                  commentsButtonParams: widget.commentsButtonParams,
                  shareButtonParams: widget.shareButtonParams,
                  bookmarkButtonParams: widget.bookmarkButtonParams,
                  bookmarkEnabled: widget.bookmarkEnabled,
                  dislikeButtonParams: widget.dislikeButtonParams,
                ),
              ],
            )
          else
            HorizontalPostBarButtons(
              likeButtonParams: widget.likeButtonParams,
              commentsButtonParams: widget.commentsButtonParams,
              shareButtonParams: widget.shareButtonParams,
              bookmarkButtonParams: widget.bookmarkButtonParams,
              bookmarkEnabled: widget.bookmarkEnabled,
              dislikeButtonParams: widget.dislikeButtonParams,
            ),
          const Gap(4),
        ],
      ),
    );
  }
}
