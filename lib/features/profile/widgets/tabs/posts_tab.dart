import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/post_overlay_theme.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/widgets/post_bar_button/post_bar_button_params.dart';
import 'package:picnic_app/features/posts/widgets/post_bar_like_button/post_bar_like_button_params.dart';
import 'package:picnic_app/features/profile/widgets/post_tab_body.dart';
import 'package:picnic_app/features/profile/widgets/tabs/preview_tab.dart';
import 'package:picnic_app/ui/widgets/paging_list/picnic_paging_list_view.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class PostsTab extends StatelessWidget {
  const PostsTab({
    super.key,
    required this.posts,
    required this.onLoadMore,
    required this.onTapHeart,
    required this.onTapComments,
    required this.onTapShare,
    required this.onTapBookmark,
    required this.bookmarkEnabled,
    required this.onToggleFollow,
    required this.onTapAuthor,
    this.isLoading = false,
    required this.onTapView,
    required this.onReport,
    required this.onPostUpdated,
    this.onTapAvatar,
    this.hideAuthorAvatar = false,
    required this.postsTabType,
    this.isMultiSelectionEnabled,
    this.selectedPosts,
    this.onTapSelectedView,
    this.onTapClosePostsSelection,
    this.onTapConfirmPostsSelection,
  });

  final PaginatedList<Post> posts;
  final Future<void> Function() onLoadMore;
  final ValueChanged<Post> onTapView;
  final ValueChanged<Id>? onTapAvatar;
  final bool hideAuthorAvatar;
  final ValueChanged<Post>? onReport;
  final ValueChanged<Post>? onPostUpdated;
  final PostsTabType postsTabType;
  final bool? isMultiSelectionEnabled;
  final List<Post>? selectedPosts;
  final ValueChanged<Post>? onTapSelectedView;
  final VoidCallback? onTapClosePostsSelection;
  final VoidCallback? onTapConfirmPostsSelection;
  final bool bookmarkEnabled;
  final ValueChanged<Post> onTapHeart;
  final ValueChanged<Post> onTapComments;
  final ValueChanged<Post> onTapShare;
  final ValueChanged<Post> onTapBookmark;
  final ValueChanged<Post> onToggleFollow;
  final ValueChanged<Post> onTapAuthor;

  final bool isLoading;

  static const _separatorBuilderHeight = 8.0;
  static const _separatorBuilderColorOpacity = 0.05;

  @override
  Widget build(BuildContext context) {
    const overlayTheme = PostOverlayTheme.dark;

    return PicnicPagingListView<Post>(
      paginatedList: posts,
      loadMore: onLoadMore,
      loadingBuilder: (_) => const PicnicLoadingIndicator(),
      itemBuilder: (context, post) {
        return PostTabBody(
          post: post,
          onTapView: onTapView,
          onPostUpdated: onPostUpdated,
          onReport: onReport,
          likeButtonParams: PostBarLikeButtonParams(
            isLiked: post.iReacted,
            likes: post.likesCount.toString(),
            onTap: () => onTapHeart(post),
            overlayTheme: overlayTheme,
            isVertical: false,
          ),
          commentsButtonParams: PostBarButtonParams(
            onTap: () => onTapComments(post),
            overlayTheme: overlayTheme,
            text: post.commentsCount.toString(),
            isVertical: false,
          ),
          shareButtonParams: PostBarButtonParams(
            onTap: () => onTapShare(post),
            overlayTheme: overlayTheme,
            text: post.sharesCount.toString(),
            isVertical: false,
          ),
          bookmarkButtonParams: PostBarButtonParams(
            onTap: () => onTapBookmark(post),
            overlayTheme: overlayTheme,
            text: post.savesCount.toString(),
            selected: post.iSaved,
            isVertical: false,
          ),
          bookmarkEnabled: bookmarkEnabled,
          onTapAuthor: onTapAuthor,
          onToggleFollow: onToggleFollow,
          showPostSummaryBarAbovePost: true,
        );
      },
      separatorBuilder: (context, index) => Container(
        height: _separatorBuilderHeight,
        color: PicnicTheme.of(context).colors.darkBlue.shade600.withOpacity(
              _separatorBuilderColorOpacity,
            ),
      ),
    );
  }
}
