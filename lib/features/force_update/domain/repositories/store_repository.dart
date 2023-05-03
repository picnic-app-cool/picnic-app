import 'package:dartz/dartz.dart';
import 'package:picnic_app/features/force_update/domain/model/open_store_failure.dart';

abstract class StoreRepository {
  Future<Either<OpenStoreFailure, Unit>> openStore(String packageName);
}
