import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/repositories/collections_repository.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/profile/domain/model/remove_collection_posts_failure.dart';

class RemoveCollectionPostUseCase {
  const RemoveCollectionPostUseCase(this._collectionsRepository);

  final CollectionsRepository _collectionsRepository;

  Future<Either<RemoveCollectionPostsFailure, Unit>> execute({
    required List<Id> postIds,
    required Id collectionId,
  }) async {
    return _collectionsRepository.deletePostsFromCollection(collectionId: collectionId, postIds: postIds);
  }
}
