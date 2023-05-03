import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/add_post_to_collection_failure.dart';
import 'package:picnic_app/core/domain/repositories/collections_repository.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class AddPostToCollectionUseCase {
  const AddPostToCollectionUseCase(
    this._collectionsRepository,
  );

  final CollectionsRepository _collectionsRepository;

  Future<Either<AddPostToCollectionFailure, Unit>> execute({required Id postId, required Id collectionId}) async {
    return _collectionsRepository.addPostToCollection(postId: postId, collectionId: collectionId);
  }
}
