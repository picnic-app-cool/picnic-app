import 'package:picnic_app/core/domain/repositories/session_expired_repository.dart';

class RemoveSessionExpiredListenerUseCase {
  const RemoveSessionExpiredListenerUseCase(this._sessionExpiredRepository);

  final SessionExpiredRepository _sessionExpiredRepository;

  void execute(SessionExpiredListener listener) {
    _sessionExpiredRepository.removeListener(listener);
  }
}
