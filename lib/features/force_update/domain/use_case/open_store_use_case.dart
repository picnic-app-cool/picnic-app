import 'package:dartz/dartz.dart';
import 'package:picnic_app/features/force_update/domain/model/open_store_failure.dart';
import 'package:picnic_app/features/force_update/domain/repositories/store_repository.dart';

class OpenStoreUseCase {
  const OpenStoreUseCase(this._storeRepository);

  final StoreRepository _storeRepository;

  Future<Either<OpenStoreFailure, Unit>> execute(String packageName) {
    return _storeRepository.openStore(packageName);
  }
}
