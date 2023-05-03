import 'package:picnic_app/core/data/firebase/firebase_provider.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/features/analytics/domain/model/analytics_event.dart';
import 'package:picnic_app/features/analytics/domain/repositories/analytics_repository.dart';

class FirebaseAnalyticsRepository implements AnalyticsRepository {
  const FirebaseAnalyticsRepository(
    this._firebaseProvider,
  );

  static const _userNameKey = 'username';

  final FirebaseProvider _firebaseProvider;

  @override
  void setUser(User? user) {
    final userId = user?.id.value;
    final username = user?.username;

    _firebaseProvider.analytics?.setUserId(id: userId);
    _firebaseProvider.analytics?.setUserProperty(name: _userNameKey, value: username);

    _firebaseProvider.crashlytics?.setUserIdentifier(userId ?? '');
    _firebaseProvider.crashlytics?.setCustomKey(_userNameKey, username ?? '');
  }

  @override
  void logEvent(AnalyticsEvent event) => _firebaseProvider.analytics?.logEvent(
        name: event.name,
        parameters: event.parameters,
      );
}
