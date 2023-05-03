import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/local_store_read_failure.dart';
import 'package:picnic_app/core/domain/model/local_store_save_failure.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';

abstract class LocalStorageRepository {
  Future<Either<LocalStoreSaveFailure, Unit>> saveCurrentUser({
    required PrivateProfile? user,
  });

  Future<Either<LocalStoreReadFailure, PrivateProfile?>> getCurrentUser();
}
