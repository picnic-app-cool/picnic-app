import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/data/hive/codecs/hive_user_json_codec.dart';
import 'package:picnic_app/core/data/hive/hive_client.dart';
import 'package:picnic_app/core/data/hive/hive_client_factory.dart';
import 'package:picnic_app/core/domain/model/local_store_read_failure.dart';
import 'package:picnic_app/core/domain/model/local_store_save_failure.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/repositories/local_storage_repository.dart';

class HiveLocalStorageRepository implements LocalStorageRepository {
  const HiveLocalStorageRepository(
    this.hiveClientFactory,
  );

  final HiveClientFactory hiveClientFactory;

  static const _currentUserKey = "current_user";
  static const _usersBox = 'users';

  HiveClient<String, PrivateProfile> get usersHiveClient => hiveClientFactory.createClient(
        boxName: _usersBox,
        jsonCodec: HiveUserJsonCodec(),
      );

  @override
  Future<Either<LocalStoreReadFailure, PrivateProfile?>> getCurrentUser() => usersHiveClient.read(_currentUserKey);

  @override
  Future<Either<LocalStoreSaveFailure, Unit>> saveCurrentUser({
    required PrivateProfile? user,
  }) =>
      usersHiveClient.save(_currentUserKey, user);
}
