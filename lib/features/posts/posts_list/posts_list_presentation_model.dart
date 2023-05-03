import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/features/feed/domain/model/feed.dart';
import 'package:picnic_app/features/feed/domain/model/feed_type.dart';
import 'package:picnic_app/features/posts/domain/model/get_feed_posts_list_failure.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/posts_list/posts_list_initial_params.dart';
import 'package:picnic_app/utils/extensions/list_extension.dart';

typedef RefreshResult = FutureResult<Either<GetFeedPostsListFailure, PaginatedList<Post>>>;

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class PostsListPresentationModel implements PostsListViewModel {
  /// Creates the initial state
  PostsListPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    PostsListInitialParams initialParams,
    UserStore userStore,
  )   : gridView = initialParams.gridView,
        feed = initialParams.feed,
        onPostChangedCallback = initialParams.onPostChanged,
        postsListResult = const FutureResult.empty(),
        refreshResult = const RefreshResult.empty(),
        privateProfile = userStore.privateProfile,
        localPost = initialParams.localPost,
        ignoreLocalPost = false,
        remotePosts = const PaginatedList.empty();

  /// Used for the copyWith method
  PostsListPresentationModel._({
    required this.gridView,
    required this.feed,
    required this.postsListResult,
    required this.refreshResult,
    required this.onPostChangedCallback,
    required this.privateProfile,
    required this.localPost,
    required this.ignoreLocalPost,
    required this.remotePosts,
  });

  final FutureResult<void> postsListResult;

  final RefreshResult refreshResult;

  final PrivateProfile privateProfile;

  @override
  final bool gridView;

  final Feed feed;

  final PaginatedList<Post> remotePosts;

  final OnDisplayedPostChangedCallback onPostChangedCallback;

  @override
  final Post localPost;

  final bool ignoreLocalPost;

  @override
  PaginatedList<Post> get posts {
    return localPost != const Post.empty() && !ignoreLocalPost
        ? remotePosts.copyWith(
            items: List.unmodifiable(
              [localPost] +
                  remotePosts.items //
                      .where((e) => e.id != localPost.id)
                      .toList(),
            ),
          )
        : remotePosts;
  }

  @override
  bool get isInitialLoading => postsListResult.isNotStarted || postsListResult.isPending() && remotePosts.items.isEmpty;

  @override
  bool get isRefreshing => refreshResult.isPending();

  Cursor get cursor => posts.nextPageCursor();

  @override
  bool get showTimestamps {
    // we want to hide timestamps for `for you` feed and there is no better way of finding it other
    // than looking at its name 🤡
    return feed.feedType != FeedType.user || feed.name.toLowerCase() != 'for you';
  }

  PostsListPresentationModel byAppendingPostsList(PaginatedList<Post> newList) => copyWith(
        remotePosts: remotePosts + newList,
      );

  PostsListPresentationModel copyWith({
    FutureResult<void>? postsListResult,
    RefreshResult? refreshResult,
    bool? gridView,
    Feed? feed,
    PaginatedList<Post>? remotePosts,
    OnDisplayedPostChangedCallback? onPostChangedCallback,
    PrivateProfile? privateProfile,
    Post? localPost,
    bool? ignoreLocalPost,
  }) {
    return PostsListPresentationModel._(
      postsListResult: postsListResult ?? this.postsListResult,
      refreshResult: refreshResult ?? this.refreshResult,
      gridView: gridView ?? this.gridView,
      feed: feed ?? this.feed,
      remotePosts: remotePosts ?? this.remotePosts,
      onPostChangedCallback: onPostChangedCallback ?? this.onPostChangedCallback,
      privateProfile: privateProfile ?? this.privateProfile,
      localPost: localPost ?? this.localPost,
      ignoreLocalPost: ignoreLocalPost ?? this.ignoreLocalPost,
    );
  }

  PostsListViewModel byUpdatingPostInList(Post post) {
    final updatedList = posts.items.byUpdatingItem(
      update: (_) => post,
      itemFinder: (item) => item.id == post.id,
    );
    return copyWith(remotePosts: posts.copyWith(items: updatedList));
  }
}

/// Interface to expose fields used by the view (page).
abstract class PostsListViewModel {
  bool get isInitialLoading;

  bool get isRefreshing;

  PaginatedList<Post> get posts;

  bool get gridView;

  Post get localPost;

  bool get showTimestamps;
}

typedef OnDisplayedPostChangedCallback = void Function(Post post);
