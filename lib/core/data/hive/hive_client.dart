import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:picnic_app/core/domain/model/local_store_read_failure.dart';
import 'package:picnic_app/core/domain/model/local_store_save_failure.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/utils/json_codec.dart';
import 'package:picnic_app/core/utils/logging.dart';
import 'package:picnic_app/core/utils/utils.dart';

/// Wraps hive into abstraction that takes care to convert all operations to return `Future<Either<L,R>>` type
class HiveClient<K, V> {
  const HiveClient({
    required this.boxName,
    required this.jsonCodec,
  });

  final String boxName;
  final JsonCodec<V?> jsonCodec;

  Future<Box<String>> get _box => Hive.isBoxOpen(boxName) //
      ? Future.value(Hive.box(boxName))
      : Hive.openBox(boxName);

  Future<Either<LocalStoreSaveFailure, Unit>> save(K key, V? value) async {
    try {
      final box = await _box;
      if (value != null) {
        final jsonString = compute(toJsonMethod, jsonCodec.toJson(value));
        await box.put(key, await jsonString);
      } else {
        await box.delete(key);
      }
      return success(unit);
    } catch (ex, stack) {
      logError(ex, stack: stack);
      return failure(LocalStoreSaveFailure.unknown(ex));
    }
  }

  Future<Either<LocalStoreReadFailure, V?>> read(K key) async {
    try {
      V? result;
      final box = await _box;
      final string = box.get(key);
      if (string != null) {
        final jsonMap = await compute(fromJsonMethod, string);
        result = jsonCodec.fromJson(jsonMap);
      }
      return success(result);
    } catch (ex, stack) {
      logError(ex, stack: stack);
      return failure(LocalStoreReadFailure.unknown(ex));
    }
  }
}
