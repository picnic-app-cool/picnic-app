import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/local_store_read_failure.dart';
import 'package:picnic_app/core/domain/model/local_store_save_failure.dart';
import 'package:picnic_app/core/domain/model/secure_local_storage_key.dart';

abstract class SecureLocalStorageRepository {
  Future<void> registerLocalStorageValueListener<T>(LocalStorageValueListener<T> listener);

  void unregisterLocalStorageValueListener<T>(LocalStorageValueListener<T> listener);

  Future<Either<LocalStoreSaveFailure, Unit>> write({
    required SecureLocalStorageKey key,
    required dynamic value,
  });

  Future<Either<LocalStoreReadFailure, T?>> read<T>({
    required SecureLocalStorageKey key,
    T? defaultValue,
  });
}

/// [key] - the key you want to listen for changes
/// [T] - type of value you expect to receive
/// [function] - function that will be triggered when the value for corresponding key changes.
class LocalStorageValueListener<T> {
  LocalStorageValueListener({
    required this.key,
    required this.function,
  });

  final SecureLocalStorageKey key;
  final Function(T? value) function;

  void notify(dynamic value) {
    if (value is T?) {
      function(value);
    }
  }
}
