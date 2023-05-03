import 'package:picnic_app/features/connection_status/domain/model/connection_status.dart';
import 'package:picnic_app/features/connection_status/domain/repositories/connection_status_repository.dart';

class GetConnectionStatusUseCase {
  const GetConnectionStatusUseCase(this._connectionStatusRepository);

  final ConnectionStatusRepository _connectionStatusRepository;

  Stream<ConnectionStatus> execute() => _connectionStatusRepository.onConnectionStatusChanged();
}
