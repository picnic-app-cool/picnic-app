import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:picnic_app/core/domain/model/local_store_read_failure.dart';
import 'package:picnic_app/core/domain/model/local_store_save_failure.dart';
import 'package:picnic_app/core/domain/model/secure_local_storage_key.dart';
import 'package:picnic_app/core/domain/repositories/secure_local_storage_repository.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/utils/logging.dart';

class FlutterSecureLocalStorageRepository extends SecureLocalStorageRepository {
  final _storage = const FlutterSecureStorage();

  final _localStorageValueListeners = List<LocalStorageValueListener<dynamic>>.empty(growable: true);

  @override
  Future<void> registerLocalStorageValueListener<T>(LocalStorageValueListener<T> listener) async {
    _localStorageValueListeners.add(listener);
    final value = (await read<T>(key: listener.key)).getSuccess();
    listener.notify(value);
  }

  @override
  void unregisterLocalStorageValueListener<T>(LocalStorageValueListener<T> listener) {
    _localStorageValueListeners.remove(listener);
  }

  @override
  Future<Either<LocalStoreSaveFailure, Unit>> write({
    required SecureLocalStorageKey key,
    required dynamic value,
  }) async {
    try {
      if (value == null) {
        await _storage.write(
          key: key.value,
          value: null,
        );
      } else {
        final json = jsonEncode(value);
        await _storage.write(
          key: key.value,
          value: json,
        );
      }

      _notifyListeners(key: key, value: value);

      return success(unit);
    } catch (ex, stack) {
      logError(ex, stack: stack);
      return failure(LocalStoreSaveFailure.unknown(ex));
    }
  }

  @override
  Future<Either<LocalStoreReadFailure, T?>> read<T>({
    required SecureLocalStorageKey key,
    T? defaultValue,
  }) async {
    try {
      T? result;
      final value = await _storage.read(key: key.value);
      if (value != null) {
        result = jsonDecode(value) as T;
      }
      return success(result ?? defaultValue);
    } catch (ex, stack) {
      logError(ex, stack: stack);
      return failure(LocalStoreReadFailure.unknown(ex));
    }
  }

  void _notifyListeners({
    required SecureLocalStorageKey key,
    required dynamic value,
  }) {
    for (final listener in _localStorageValueListeners.where((element) => element.key == key)) {
      try {
        listener.notify(value);
      } catch (ex, stack) {
        logError(ex, stack: stack);
      }
    }
  }
}
