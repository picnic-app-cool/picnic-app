import 'package:picnic_app/core/data/hive/hive_client.dart';
import 'package:picnic_app/core/utils/json_codec.dart';

class HiveClientFactory {
  HiveClient<K, V> createClient<K, V>({
    required String boxName,
    required JsonCodec<V> jsonCodec,
  }) =>
      HiveClient(boxName: boxName, jsonCodec: jsonCodec);
}
