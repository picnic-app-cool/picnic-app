import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/features/posts/comment_chat/widgets/comment_chat_reply_bar.dart';
import 'package:picnic_app/features/posts/domain/model/comment_preview.dart';
import 'package:picnic_app/features/posts/domain/model/post_overlay_theme.dart';
import 'package:picnic_app/features/posts/widgets/disabled_comments_view.dart';
import 'package:picnic_app/features/posts/widgets/post_bar_button/post_bar_button_params.dart';
import 'package:picnic_app/features/posts/widgets/post_bar_buttons.dart';
import 'package:picnic_app/features/posts/widgets/post_bar_like_button/post_bar_like_button_params.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_comment_text_input.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_icon_button.dart';

class PostCommentBar extends StatefulWidget {
  const PostCommentBar({
    required this.likeButtonParams,
    required this.commentsButtonParams,
    required this.shareButtonParams,
    required this.bookmarkButtonParams,
    required this.bookmarkEnabled,
    required this.hasActionsBelow,
    required this.overlayTheme,
    required this.canComment,
    this.onCommentUpdated,
    this.onTapSend,
    this.focusNode,
    this.replyingComment = const CommentPreview.empty(),
    this.onTapCancelReply,
    super.key,
  });

  final Future<void> Function(String comment)? onTapSend;
  final ValueChanged<String>? onCommentUpdated;
  final bool hasActionsBelow;
  final CommentPreview replyingComment;
  final VoidCallback? onTapCancelReply;
  final FocusNode? focusNode;
  final bool canComment;

  final PostOverlayTheme overlayTheme;
  final PostBarLikeButtonParams likeButtonParams;
  final PostBarButtonParams commentsButtonParams;
  final PostBarButtonParams shareButtonParams;
  final PostBarButtonParams bookmarkButtonParams;
  final bool bookmarkEnabled;

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
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    const buttonSize = 40.0;

    final textInputHasFocus = widget.focusNode?.hasFocus == true;

    const images = Assets.images;
    final sendIconPath = images.send;
    final thoughtsBarBackgroundColor =
        widget.overlayTheme == PostOverlayTheme.light ? const Color(0x4DA0A0A0) : const Color(0x0D2B3F6C);
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
          Row(
            children: [
              Expanded(
                child: widget.canComment
                    ? PicnicCommentTextInput(
                        hintText: appLocalizations.commentsHint,
                        fillColor: thoughtsBarBackgroundColor,
                        textColor: widget.overlayTheme == PostOverlayTheme.light ? null : colors.blackAndWhite.shade900,
                        onChanged: _onCommentUpdated,
                        textController: commentController,
                        focusNode: widget.focusNode,
                        dropShadow: textInputHasFocus,
                      )
                    : DisabledCommentsView(
                        text: appLocalizations.commentingDisabled,
                      ),
              ),
              spacing,
              if (isUserTyping)
                PicnicIconButton(
                  icon: sendIconPath.path,
                  color: theme.colors.green,
                  size: buttonSize,
                  onTap: _onCommentSend,
                )
              else
                PostBarButtons(
                  likeButtonParams: widget.likeButtonParams,
                  commentsButtonParams: widget.commentsButtonParams,
                  shareButtonParams: widget.shareButtonParams,
                  bookmarkButtonParams: widget.bookmarkButtonParams,
                  bookmarkEnabled: widget.bookmarkEnabled,
                  spacing: const Gap(8),
                ),
            ],
          ),
          const Gap(4),
        ],
      ),
    );
  }

  void _onCommentUpdated(String comment) {
    setState(() {
      isUserTyping = comment.isNotEmpty;
    });
    final function = widget.onCommentUpdated;
    if (function != null) {
      function(comment);
    }
  }

  void _onCommentSend() {
    if (widget.onTapSend == null) {
      return;
    }
    final trimmedText = commentController.text.trim();
    if (trimmedText.isEmpty) {
      return;
    }
    widget.onTapSend!(trimmedText);
    setState(() {
      commentController.text = '';
      isUserTyping = false;
    });
  }
}
