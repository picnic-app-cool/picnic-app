import 'package:google_sign_in/google_sign_in.dart';
import 'package:picnic_app/core/data/session_invalidated_listeners_container.dart';
import 'package:picnic_app/core/domain/repositories/session_expired_repository.dart';

class ImplSessionExpiredRepository implements SessionExpiredRepository {
  ImplSessionExpiredRepository(
    this._sessionInvalidatedListenersContainer,
    this._googleSignIn,
  );

  final GoogleSignIn _googleSignIn;
  final SessionInvalidatedListenersContainer _sessionInvalidatedListenersContainer;

  @override
  void addListener(SessionExpiredListener listener) {
    _sessionInvalidatedListenersContainer.registerOnSessionInvalidatedListener((_) => listener());
  }

  @override
  void removeListener(SessionExpiredListener listener) {
    _sessionInvalidatedListenersContainer.unregisterOnSessionInvalidatedListener((_) => listener());
  }

  @override
  void clearHandledTokens() {
    _sessionInvalidatedListenersContainer.clearHandledTokens();
    if (_googleSignIn.currentUser != null) {
      _clearGoogleUserToken();
    }
  }

  void _clearGoogleUserToken() {
    _googleSignIn.disconnect();
  }
}
