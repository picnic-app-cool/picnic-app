import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/collection.dart';
import 'package:picnic_app/core/domain/repositories/collections_repository.dart';
import 'package:picnic_app/features/profile/domain/model/create_collection_failure.dart';
import 'package:picnic_app/features/profile/domain/model/create_collection_input.dart';

class CreateCollectionUseCase {
  const CreateCollectionUseCase(this._collectionsRepository);

  final CollectionsRepository _collectionsRepository;

  Future<Either<CreateCollectionFailure, Collection>> execute(CreateCollectionInput createCollectionInput) async =>
      _collectionsRepository.createCollection(createCollectionInput: createCollectionInput);
}
