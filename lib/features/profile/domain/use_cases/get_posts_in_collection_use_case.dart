import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/repositories/collections_repository.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/profile/domain/model/get_posts_in_collection_failure.dart';

class GetPostsInCollectionUseCase {
  const GetPostsInCollectionUseCase(
    this._collectionsRepository,
  );

  final CollectionsRepository _collectionsRepository;

  Future<Either<GetPostsInCollectionFailure, PaginatedList<Post>>> execute({
    required Id collectionId,
    required Cursor nextPageCursor,
  }) =>
      _collectionsRepository.getPostsInCollection(
        collectionId: collectionId,
        nextPageCursor: nextPageCursor,
      );
}
