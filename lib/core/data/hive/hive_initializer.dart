import 'package:hive_flutter/hive_flutter.dart';
import 'package:picnic_app/core/data/hive/adapters/hive_json_adapter.dart';
import 'package:picnic_app/core/domain/repositories/library_initializer.dart';

class HiveInitializer implements LibraryInitializer {
  static const _jsonTypeAdapterId = 1; // DO NOT CHANGE VALUE

  @override
  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(HiveJsonAdapter(_jsonTypeAdapterId));
  }
}
