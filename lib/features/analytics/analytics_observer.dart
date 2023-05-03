import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/core/data/firebase/crashlytics_screens_observer.dart';
import 'package:picnic_app/core/data/firebase/firebase_provider.dart';

class AnalyticsObserver extends NavigatorObserver {
  AnalyticsObserver(this.firebaseProvider);

  final FirebaseProvider firebaseProvider;

  late final _observers = [
    if (firebaseProvider.analytics != null) FirebaseAnalyticsObserver(analytics: firebaseProvider.analytics!),
    CrashlyticsScreensObserver(firebaseProvider),
  ];

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    for (final observer in _observers) {
      observer.didPush(route, previousRoute);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    for (final observer in _observers) {
      observer.didPop(route, previousRoute);
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    for (final observer in _observers) {
      observer.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    }
  }
}
