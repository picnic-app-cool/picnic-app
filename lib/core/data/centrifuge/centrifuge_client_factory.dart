import 'package:picnic_app/core/data/centrifuge/centrifuge_client.dart';
import 'package:picnic_app/core/domain/live_data_client.dart';

class CentrifugeClientFactory {
  CentrifugeClient<T> createClient<T>({required LiveDataClientParserCallback<T?> eventParser}) => CentrifugeClient<T>(
        eventParser,
      );
}
