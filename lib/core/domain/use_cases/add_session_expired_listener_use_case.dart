import 'package:picnic_app/core/domain/repositories/session_expired_repository.dart';

class AddSessionExpiredListenerUseCase {
  const AddSessionExpiredListenerUseCase(this._sessionExpiredRepository);

  final SessionExpiredRepository _sessionExpiredRepository;

  void execute(SessionExpiredListener listener) {
    _sessionExpiredRepository.addListener(listener);
  }
}
