import 'package:flutter/material.dart';
import 'package:picnic_app/core/data/firebase/firebase_provider.dart';

class CrashlyticsScreensObserver extends RouteObserver<ModalRoute<dynamic>> {
  CrashlyticsScreensObserver(this.firebaseProvider);

  static const undefinedScreenName = 'undefined';
  static const String screen = 'screen';

  final FirebaseProvider firebaseProvider;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    firebaseProvider.crashlytics?.setCustomKey(screen, route.settings.name ?? undefinedScreenName);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    firebaseProvider.crashlytics?.setCustomKey(screen, newRoute?.settings.name ?? undefinedScreenName);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    firebaseProvider.crashlytics?.setCustomKey(screen, previousRoute?.settings.name ?? undefinedScreenName);
  }
}
