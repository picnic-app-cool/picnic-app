import 'package:flutter/material.dart';
import 'package:picnic_app/features/posts/domain/model/post_details_mode.dart';
import 'package:picnic_app/features/posts/domain/model/post_overlay_theme.dart';
import 'package:picnic_app/features/posts/domain/model/post_type.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/widgets/horizontal_post_bar_buttons.dart';
import 'package:picnic_app/features/posts/widgets/post_bar_button/post_bar_button_params.dart';
import 'package:picnic_app/features/posts/widgets/post_bar_like_button/post_bar_like_button_params.dart';
import 'package:picnic_app/features/posts/widgets/post_list_item.dart';
import 'package:picnic_app/features/posts/widgets/post_summary_bar.dart';

class PostTabBody extends StatelessWidget {
  const PostTabBody({
    required this.post,
    required this.onTapView,
    required this.likeButtonParams,
    required this.commentsButtonParams,
    required this.shareButtonParams,
    required this.bookmarkButtonParams,
    required this.dislikeButtonParams,
    required this.bookmarkEnabled,
    required this.onToggleFollow,
    required this.onTapAuthor,
    this.onReport,
    this.onPostUpdated,
    this.showPostSummaryBarAbovePost = false,
    super.key,
  });

  final Post post;
  final ValueChanged<Post> onTapView;
  final ValueChanged<Post>? onReport;
  final ValueChanged<Post>? onPostUpdated;
  final PostBarLikeButtonParams likeButtonParams;
  final PostBarButtonParams commentsButtonParams;
  final PostBarButtonParams shareButtonParams;
  final PostBarButtonParams bookmarkButtonParams;
  final PostBarButtonParams dislikeButtonParams;
  final bool bookmarkEnabled;
  final ValueChanged<Post>? onToggleFollow;
  final ValueChanged<Post>? onTapAuthor;
  final bool showPostSummaryBarAbovePost;

  static const double _aspectRatio = 0.7;
  static const double _height = 460;

  @override
  Widget build(BuildContext context) {
    final postListItem = Padding(
      padding: post.type != PostType.text ? EdgeInsets.zero : const EdgeInsets.symmetric(horizontal: 16.0),
      child: PostListItem(
        onPostUpdated: (post) => onPostUpdated?.call(post),
        onReport: (post) => onReport?.call(post),
        post: post,
        showPostCommentBar: false,
        initiallyMuted: true,
        allowUnmute: false,
        showVideoControls: false,
        postDetailsMode: PostDetailsMode.postsTab,
        showTimestamp: true,
        showPostSummaryBarAbovePost: showPostSummaryBarAbovePost,
      ),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showPostSummaryBarAbovePost)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: PostSummaryBar(
              author: post.author,
              post: post,
              overlayTheme: PostOverlayTheme.dark,
              onToggleFollow: () => onToggleFollow?.call(post),
              onTapTag: null,
              onTapAuthor: () => onTapAuthor?.call(post),
              showTimestamp: true,
              displayTag: false,
              isDense: true,
              showViewCountAtEnd: true,
            ),
          ),
        Stack(
          children: [
            if (post.type != PostType.text)
              AspectRatio(
                aspectRatio: _aspectRatio,
                child: postListItem,
              )
            else
              SizedBox(
                height: _height,
                child: postListItem,
              ),
            Positioned.fill(
              child: InkWell(
                onTap: () => onTapView(post),
                child: const SizedBox.expand(),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: HorizontalPostBarButtons(
            likeButtonParams: likeButtonParams,
            commentsButtonParams: commentsButtonParams,
            shareButtonParams: shareButtonParams,
            bookmarkButtonParams: bookmarkButtonParams,
            bookmarkEnabled: bookmarkEnabled,
            dislikeButtonParams: dislikeButtonParams,
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
          ),
        ),
      ],
    );
  }
}
