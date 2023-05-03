import 'package:picnic_app/features/connection_status/domain/model/connection_status.dart';

abstract class ConnectionStatusRepository {
  Stream<ConnectionStatus> onConnectionStatusChanged();
}
