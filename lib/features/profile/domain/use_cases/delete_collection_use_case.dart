import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/repositories/collections_repository.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/profile/domain/model/delete_collection_failure.dart';

class DeleteCollectionUseCase {
  const DeleteCollectionUseCase(this._collectionsRepository);

  final CollectionsRepository _collectionsRepository;

  Future<Either<DeleteCollectionFailure, Unit>> execute({required Id collectionId}) async {
    return _collectionsRepository.deleteCollection(collectionId: collectionId);
  }
}
