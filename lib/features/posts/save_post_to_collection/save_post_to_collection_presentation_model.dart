import 'package:picnic_app/core/domain/model/collection.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/save_post_to_collection/save_post_to_collection_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class SavePostToCollectionPresentationModel implements SavePostToCollectionViewModel {
  /// Creates the initial state
  SavePostToCollectionPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    SavePostToCollectionInitialParams initialParams,
  )   : postCollections = const PaginatedList.empty(),
        postId = initialParams.postId,
        userId = initialParams.userId;

  /// Used for the copyWith method
  SavePostToCollectionPresentationModel._({
    required this.postCollections,
    required this.userId,
    required this.postId,
  });

  @override
  final PaginatedList<Collection> postCollections;

  @override
  final Id userId;

  @override
  final Id postId;

  SavePostToCollectionPresentationModel byAppendingPostCollections(
    PaginatedList<Collection> newItems,
  ) =>
      copyWith(
        postCollections: postCollections + newItems,
      );

  SavePostToCollectionPresentationModel byAddingPostCollection(
    Collection newCollection,
  ) =>
      copyWith(
        postCollections: postCollections.byAddingFirst(element: newCollection),
      );

  SavePostToCollectionPresentationModel copyWith({
    PaginatedList<Collection>? postCollections,
    Id? userId,
    Id? postId,
  }) {
    return SavePostToCollectionPresentationModel._(
      postCollections: postCollections ?? this.postCollections,
      userId: userId ?? this.userId,
      postId: postId ?? this.postId,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class SavePostToCollectionViewModel {
  PaginatedList<Collection> get postCollections;

  Id get userId;

  Id get postId;
}
