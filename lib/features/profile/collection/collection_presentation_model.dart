import 'package:async/async.dart';
import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/collection.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/utils/future_result.dart';
import 'package:picnic_app/core/utils/utils.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/profile/collection/collection_initial_params.dart';
import 'package:picnic_app/features/profile/domain/model/get_posts_in_collection_failure.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class CollectionPresentationModel implements CollectionViewModel {
  /// Creates the initial state
  CollectionPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    CollectionInitialParams initialParams,
    UserStore userStore,
  )   : posts = const PaginatedList.empty(),
        selectedPosts = [],
        isMultiSelectionEnabled = false,
        onPostRemovedCallback = initialParams.onPostRemovedCallback,
        postsResult = const FutureResult.empty(),
        privateProfile = userStore.privateProfile,
        collection = initialParams.collection,
        getCollectionPostsOperation = null;

  /// Used for the copyWith method
  CollectionPresentationModel._({
    required this.posts,
    required this.collection,
    required this.selectedPosts,
    required this.isMultiSelectionEnabled,
    required this.onPostRemovedCallback,
    required this.privateProfile,
    required this.postsResult,
    required this.getCollectionPostsOperation,
  });

  @override
  final PaginatedList<Post> posts;

  final PrivateProfile privateProfile;

  final VoidCallback? onPostRemovedCallback;

  final FutureResult<Either<GetPostsInCollectionFailure, PaginatedList<Post>>> postsResult;

  final CancelableOperation<Either<GetPostsInCollectionFailure, PaginatedList<Post>>>? getCollectionPostsOperation;

  @override
  final bool isMultiSelectionEnabled;

  @override
  final List<Post> selectedPosts;

  @override
  final Collection collection;

  @override
  String get collectionName => collection.title;

  @override
  bool get isCollectionOwner => privateProfile.id.value == collection.ownerId.value;

  @override
  bool get isLoadingPosts => postsResult.isPending();

  CollectionPresentationModel byAppendingPostsList({
    required PaginatedList<Post> newList,
  }) =>
      copyWith(
        posts: posts + newList,
      );

  CollectionPresentationModel copyWith({
    PaginatedList<Post>? posts,
    List<Post>? selectedPosts,
    bool? isMultiSelectionEnabled,
    Collection? collection,
    VoidCallback? onPostRemovedCallback,
    PrivateProfile? privateProfile,
    FutureResult<Either<GetPostsInCollectionFailure, PaginatedList<Post>>>? postsResult,
    CancelableOperation<Either<GetPostsInCollectionFailure, PaginatedList<Post>>>? getCollectionPostsOperation,
  }) {
    return CollectionPresentationModel._(
      posts: posts ?? this.posts,
      selectedPosts: selectedPosts ?? this.selectedPosts,
      collection: collection ?? this.collection,
      onPostRemovedCallback: onPostRemovedCallback ?? this.onPostRemovedCallback,
      isMultiSelectionEnabled: isMultiSelectionEnabled ?? this.isMultiSelectionEnabled,
      privateProfile: privateProfile ?? this.privateProfile,
      postsResult: postsResult ?? this.postsResult,
      getCollectionPostsOperation: getCollectionPostsOperation ?? this.getCollectionPostsOperation,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class CollectionViewModel {
  PaginatedList<Post> get posts;

  Collection get collection;

  String get collectionName;

  List<Post> get selectedPosts;

  bool get isMultiSelectionEnabled;

  bool get isCollectionOwner;

  bool get isLoadingPosts;
}
