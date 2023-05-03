import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/circle_details/widgets/multi_select_posts_component.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/ui/widgets/paging_list/paging_grid_view.dart';
import 'package:picnic_app/ui/widgets/picnic_vertical_post_builder.dart';
import 'package:picnic_app/utils/extensions/string_formatting.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class PreviewTab extends StatelessWidget {
  const PreviewTab({
    super.key,
    required this.posts,
    required this.onLoadMore,
    this.isLoading = false,
    required this.onTapView,
    this.onTapAvatar,
    this.hideAuthorAvatar = false,
    this.onReport,
    this.onPostUpdated,
    required this.postsTabType,
    this.isMultiSelectionEnabled,
    this.selectedPosts,
    this.onTapSelectedView,
    this.onTapClosePostsSelection,
    this.onTapConfirmPostsSelection,
  });

  final PaginatedList<Post> posts;
  final Future<void> Function() onLoadMore;
  final Function(Post) onTapView;

  final Function(Id)? onTapAvatar;
  final bool hideAuthorAvatar;
  final ValueChanged<Post>? onReport;
  final ValueChanged<Post>? onPostUpdated;
  final PostsTabType postsTabType;
  final bool? isMultiSelectionEnabled;
  final List<Post>? selectedPosts;
  final Function(Post)? onTapSelectedView;
  final VoidCallback? onTapClosePostsSelection;
  final VoidCallback? onTapConfirmPostsSelection;

  final bool isLoading;

  static const int _columns = 2;

  static const double _postAspectRation = 0.66;
  static const double _spacing = 8;

  @override
  Widget build(BuildContext context) {
    return MultiSelectPostsComponent(
      selectedPosts: selectedPosts ?? [],
      onTapConfirm: () => onTapConfirmPostsSelection?.call(),
      onTapClose: () => onTapClosePostsSelection?.call(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: PagingGridView<Post>(
          paging: posts,
          columns: _columns,
          aspectRatio: _postAspectRation,
          loadMore: onLoadMore,
          mainAxisSpacing: _spacing,
          crossAxisSpacing: _spacing,
          loadingBuilder: (_) => Center(
            child: PicnicLoadingIndicator(
              isLoading: isLoading,
            ),
          ),
          itemBuilder: (context, index) {
            final post = posts.items[index];
            final footer = postsTabType == PostsTabType.circle
                ? post.author.username.formattedUsername
                : post.circle.name.formattedCircleName;
            return PicnicVerticalPostBuilder(
              hideAuthorAvatar: hideAuthorAvatar,
              onTapView: onTapView,
              post: post,
              onTapAvatar: onTapAvatar,
              footerText: footer,
              isMultiSelectionEnabled: isMultiSelectionEnabled,
              isSelected: selectedPosts?.contains(post),
              onTapSelectedView: onTapSelectedView,
            );
          },
        ),
      ),
    );
  }
}

enum PostsTabType {
  circle,
  profile,
}
