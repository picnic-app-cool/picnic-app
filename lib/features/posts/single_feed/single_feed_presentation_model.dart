import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/displayable_failure.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/features/circles/circle_details/models/posts_sorting_type.dart';
import 'package:picnic_app/features/posts/domain/model/post_overlay_theme.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/single_feed/single_feed_initial_params.dart';
import 'package:picnic_app/features/posts/single_feed/sorting_handler.dart';

typedef LoadMoreCallback = Future<Either<DisplayableFailure, PaginatedList<Post>>> Function();
typedef RefreshCallback = Future<Either<DisplayableFailure, PaginatedList<Post>>> Function();
typedef OnPostsListUpdatedCallback = void Function(PaginatedList<Post>);

typedef RefreshResult = FutureResult<Either<DisplayableFailure, PaginatedList<Post>>>;

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class SingleFeedPresentationModel implements SingleFeedViewModel {
  /// Creates the initial state
  SingleFeedPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    SingleFeedInitialParams initialParams,
    UserStore userStore,
  )   : privateProfile = userStore.privateProfile,
        loadMoreCallback = initialParams.loadMore,
        refreshCallback = initialParams.refresh,
        refreshResult = const FutureResult.empty(),
        onPostsListUpdatedCallback = initialParams.onPostsListUpdated,
        posts = initialParams.preloadedPosts,
        initialIndex = initialParams.initialIndex,
        sortingHandler = initialParams.sortingHandler,
        currentPost = initialParams.preloadedPosts[initialParams.initialIndex];

  /// Used for the copyWith method
  SingleFeedPresentationModel._({
    required this.privateProfile,
    required this.loadMoreCallback,
    required this.refreshCallback,
    required this.refreshResult,
    required this.onPostsListUpdatedCallback,
    required this.posts,
    required this.initialIndex,
    required this.currentPost,
    required this.sortingHandler,
  });

  final LoadMoreCallback loadMoreCallback;
  final RefreshCallback refreshCallback;
  final OnPostsListUpdatedCallback onPostsListUpdatedCallback;

  final RefreshResult refreshResult;

  final PrivateProfile privateProfile;

  @override
  final PaginatedList<Post> posts;

  @override
  final int initialIndex;

  final Post currentPost;

  final SortingHandler sortingHandler;

  @override
  bool get isRefreshing => refreshResult.isPending();

  @override
  PostOverlayTheme get overlayTheme => currentPost.overlayTheme;

  bool get isAuthor => privateProfile.user.id == currentPost.author.id;

  bool get canDeletePost => isAuthor || currentPost.circle.permissions.canManagePosts;

  bool get canReportPost => !isAuthor;

  @override
  PostsSortingType get selectedSortOption => sortingHandler.selectedSortOption();

  @override
  bool get showSortButton => sortingHandler.showSorting;

  SingleFeedPresentationModel byAppendingPosts(PaginatedList<Post> newList) => copyWith(
        posts: posts + newList,
      );

  SingleFeedPresentationModel byRemovingPost(Post post) => copyWith(
        posts: posts.byRemovingWhere((p) => p.id == post.id),
      );

  SingleFeedPresentationModel byUpdatingPost(Post updatedPost) {
    final newPostsList = <Post>[];
    for (final post in posts) {
      if (post.id == updatedPost.id) {
        newPostsList.add(updatedPost);
        continue;
      }

      var tempPost = post;

      final newFollowAuthorStatus = updatedPost.author.iFollow;
      if (post.author.id == updatedPost.author.id && post.author.iFollow != newFollowAuthorStatus) {
        tempPost = tempPost.copyWith(
          author: tempPost.author.copyWith(iFollow: newFollowAuthorStatus),
        );
      }

      final newJoinedCircleStatus = updatedPost.circle.iJoined;
      if (post.circle.id == updatedPost.circle.id && post.circle.iJoined != newJoinedCircleStatus) {
        tempPost = tempPost.copyWith(
          circle: tempPost.circle.copyWith(iJoined: newJoinedCircleStatus),
        );
      }

      newPostsList.add(tempPost);
    }

    return copyWith(posts: posts.copyWith(items: newPostsList));
  }

  SingleFeedPresentationModel copyWith({
    LoadMoreCallback? loadMoreCallback,
    RefreshCallback? refreshCallback,
    OnPostsListUpdatedCallback? onPostsListUpdatedCallback,
    RefreshResult? refreshResult,
    PrivateProfile? privateProfile,
    PaginatedList<Post>? posts,
    int? initialIndex,
    Post? currentPost,
    SortingHandler? sortingHandler,
  }) {
    return SingleFeedPresentationModel._(
      loadMoreCallback: loadMoreCallback ?? this.loadMoreCallback,
      refreshCallback: refreshCallback ?? this.refreshCallback,
      onPostsListUpdatedCallback: onPostsListUpdatedCallback ?? this.onPostsListUpdatedCallback,
      refreshResult: refreshResult ?? this.refreshResult,
      privateProfile: privateProfile ?? this.privateProfile,
      posts: posts ?? this.posts,
      initialIndex: initialIndex ?? this.initialIndex,
      currentPost: currentPost ?? this.currentPost,
      sortingHandler: sortingHandler ?? this.sortingHandler,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class SingleFeedViewModel {
  PaginatedList<Post> get posts;

  int get initialIndex;

  PostOverlayTheme get overlayTheme;

  bool get isRefreshing;

  bool get showSortButton;

  PostsSortingType get selectedSortOption;
}
