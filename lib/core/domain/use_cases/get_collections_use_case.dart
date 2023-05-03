import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/collection.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/get_collections_failure.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/repositories/collections_repository.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class GetCollectionsUseCase {
  const GetCollectionsUseCase(
    this._collectionsRepository,
  );

  final CollectionsRepository _collectionsRepository;

  Future<Either<GetCollectionsFailure, PaginatedList<Collection>>> execute({
    required Id userId,
    required Cursor nextPageCursor,
    bool withPreviewPosts = true,
    bool returnSavedPostsCollection = true,
  }) =>
      _collectionsRepository.getCollections(
        nextPageCursor: nextPageCursor,
        userId: userId,
        withPreviewPosts: withPreviewPosts,
        returnSavedPostsCollection: returnSavedPostsCollection,
      );
}
