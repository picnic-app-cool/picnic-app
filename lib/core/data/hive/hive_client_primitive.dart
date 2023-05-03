import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:picnic_app/core/domain/model/local_store_read_failure.dart';
import 'package:picnic_app/core/domain/model/local_store_save_failure.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/utils/logging.dart';

/// Wraps hive into abstraction that takes care to convert all operations to return `Future<Either<L,R>>` type
class HiveClientPrimitive<K, V> {
  const HiveClientPrimitive({
    required this.boxName,
  });

  final String boxName;

  Future<Box<V>> get _box => Hive.isBoxOpen(boxName) //
      ? Future.value(Hive.box(boxName))
      : Hive.openBox(boxName);

  Future<Either<LocalStoreSaveFailure, Unit>> save(K key, V? value) async {
    try {
      final box = await _box;
      if (value != null) {
        await box.put(key, value);
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
      final box = await _box;
      final result = box.get(key);
      return success(result);
    } catch (ex, stack) {
      logError(ex, stack: stack);
      return failure(LocalStoreReadFailure.unknown(ex));
    }
  }
}
