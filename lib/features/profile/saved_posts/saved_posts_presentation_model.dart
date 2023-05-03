import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/profile/domain/model/get_saved_posts_failure.dart';
import 'package:picnic_app/features/profile/saved_posts/saved_posts_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class SavedPostsPresentationModel implements SavedPostsViewModel {
  /// Creates the initial state
  SavedPostsPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    SavedPostsInitialParams initialParams,
  )   : posts = const PaginatedList.empty(),
        postsResult = const FutureResult.empty();

  /// Used for the copyWith method
  SavedPostsPresentationModel._({
    required this.posts,
    required this.postsResult,
  });

  final FutureResult<Either<GetSavedPostsFailure, PaginatedList<Post>>> postsResult;

  @override
  final PaginatedList<Post> posts;

  @override
  bool get isPostsLoading => postsResult.isPending();

  SavedPostsPresentationModel copyWith({
    PaginatedList<Post>? posts,
    FutureResult<Either<GetSavedPostsFailure, PaginatedList<Post>>>? postsResult,
  }) {
    return SavedPostsPresentationModel._(
      posts: posts ?? this.posts,
      postsResult: postsResult ?? this.postsResult,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class SavedPostsViewModel {
  PaginatedList<Post> get posts;

  bool get isPostsLoading;
}
