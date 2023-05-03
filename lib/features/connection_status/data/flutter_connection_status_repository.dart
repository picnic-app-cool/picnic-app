import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:picnic_app/features/connection_status/domain/model/connection_status.dart';
import 'package:picnic_app/features/connection_status/domain/repositories/connection_status_repository.dart';
import 'package:rxdart/rxdart.dart';

class FlutterConnectionStatusRepository implements ConnectionStatusRepository {
  const FlutterConnectionStatusRepository();

  @override
  Stream<ConnectionStatus> onConnectionStatusChanged() {
    return _onConnectionStatusChanged() //
        .distinct()
        .debounceTime(const Duration(seconds: 1))
        .map(
          (connectivityResult) =>
              connectivityResult == ConnectivityResult.none ? ConnectionStatus.offline : ConnectionStatus.online,
        );
  }

  Stream<ConnectivityResult> _onConnectionStatusChanged() async* {
    yield await Connectivity().checkConnectivity();
    yield* Connectivity().onConnectivityChanged;
  }
}
