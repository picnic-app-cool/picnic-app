import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/comment_preview.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/text_post_content.dart';
import 'package:picnic_app/features/posts/domain/model/post_overlay_theme.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/text_post_creation/utils/color_to_color_option.dart';
import 'package:picnic_app/features/posts/widgets/comment_fixed_list.dart';
import 'package:picnic_app/features/posts/widgets/post_summary_bar.dart';
import 'package:picnic_app/ui/widgets/picnic_post/picnic_post.dart';

class TextPostView extends StatelessWidget {
  const TextPostView({
    Key? key,
    required this.post,
    required this.onTapExpand,
    required this.comments,
    required this.commentBarHeight,
    required this.onTapCircleTag,
    required this.onTapFollow,
    required this.onTapAuthor,
    required this.onTapJoinCircle,
    required this.onTapReply,
    required this.onTapLikeUnlike,
    required this.onTapComment,
    required this.onLongTapComment,
    required this.onDoubleTapComment,
    required this.onTapCommentAuthor,
    required this.onTapCircle,
    this.onDoubleTap,
    this.padding,
    this.shouldExpand = false,
    this.showPostSummaryBarAbovePost = false,
  }) : super(key: key);

  final Post post;
  final void Function(String) onTapExpand;
  final void Function(CommentPreview) onTapReply;
  final void Function(CommentPreview) onTapLikeUnlike;
  final void Function(CommentPreview) onTapComment;
  final void Function(CommentPreview) onLongTapComment;
  final void Function(CommentPreview) onDoubleTapComment;
  final void Function(Id) onTapCommentAuthor;
  final List<CommentPreview> comments;
  final double commentBarHeight;
  final VoidCallback onTapCircleTag;
  final VoidCallback onTapFollow;
  final VoidCallback onTapAuthor;
  final VoidCallback onTapJoinCircle;
  final VoidCallback? onDoubleTap;
  final VoidCallback onTapCircle;
  final EdgeInsetsGeometry? padding;
  final bool shouldExpand;
  final bool showPostSummaryBarAbovePost;

  static const _borderRadius = 24.0;

  TextPostContent get content {
    assert(post.content is TextPostContent, "post.content must be a TextPostContent when it's used in TextPostView");
    return post.content as TextPostContent;
  }

  @override
  Widget build(BuildContext context) {
    final additionalText = content.additionalText;
    final colorGradient = colorToColorOption(content.color);

    const mainTextFlex = 2;

    return LayoutBuilder(
      builder: (context, constraints) {
        // we can't fully rely on relative to screen height size here, because
        // it might not be enough to display even 1 line of text
        // 240px is enough to display 3 lines of text + expand button
        // additional 100 px allows us to put 1 line of additional text with expand button
        // tested on iphone 13 pro, on devices with different width there can be different results
        final minReservedPostSize = 240 + (additionalText.isNotEmpty ? 100 : 0);
        final availableForCommentsHeight = math.max(constraints.maxHeight - minReservedPostSize, 0.0);

        return Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Flexible(
                    flex: mainTextFlex,
                    fit: !shouldExpand ? FlexFit.loose : FlexFit.tight,
                    child: Padding(
                      padding: padding ?? const EdgeInsets.symmetric(horizontal: 16),
                      child: PicnicPost(
                        bodyText: content.text,
                        postSummaryBar: showPostSummaryBarAbovePost
                            ? null
                            : PostSummaryBar(
                                overlayTheme: PostOverlayTheme.light,
                                author: post.author,
                                post: post,
                                onTapTag: onTapCircleTag,
                                padding: EdgeInsets.zero,
                                showTagBackground: true,
                                isDense: true,
                                showTagPrefixIcon: false,
                                onToggleFollow: onTapFollow,
                                onTapAuthor: onTapAuthor,
                                onTapJoinCircle: onTapJoinCircle,
                                onTapCircle: onTapCircle,
                                showFollowButton: true,
                              ),
                        onTapExpand: () => onTapExpand(content.text),
                        onDoubleTap: onDoubleTap,
                        background: BoxDecoration(
                          gradient: colorGradient,
                          borderRadius: BorderRadius.circular(TextPostView._borderRadius),
                        ),
                        post: post,
                        shouldExpand: shouldExpand,
                      ),
                    ),
                  ),
                  if (additionalText.isNotEmpty && !shouldExpand) ...[
                    const Gap(12),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        alignment: Alignment.topCenter,
                        child: PicnicPost(
                          bodyText: additionalText,
                          onDoubleTap: onDoubleTap,
                          onTapExpand: () => onTapExpand(additionalText),
                          background: BoxDecoration(
                            gradient: colorGradient,
                            borderRadius: BorderRadius.circular(TextPostView._borderRadius),
                          ),
                          post: post,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (!shouldExpand) const Gap(8),
            CommentFixedList(
              availableHeight: availableForCommentsHeight,
              comments: comments,
              onTapReply: onTapReply,
              onTapLikeUnlike: onTapLikeUnlike,
              onTapComment: onTapComment,
              onLongTapComment: onLongTapComment,
              onDoubleTapComment: onDoubleTapComment,
              onTapCommentAuthor: onTapCommentAuthor,
            ),
          ],
        );
      },
    );
  }
}
