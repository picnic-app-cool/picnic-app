import 'package:picnic_app/core/data/hive/hive_client_primitive.dart';

class HiveClientPrimitiveFactory {
  HiveClientPrimitive<K, V> createClient<K, V>({
    required String boxName,
  }) =>
      HiveClientPrimitive(boxName: boxName);
}
