import 'package:flutter/material.dart';

/// allows for registering/unregistering to/from root navigator's events
class RootNavigatorObserver extends NavigatorObserver {
  final List<NavigatorObserver> _observers = [];

  void registerObserver(NavigatorObserver observer) => _observers.add(observer);

  void removeObserver(NavigatorObserver observer) => _observers.remove(observer);

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
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    for (final observer in _observers) {
      observer.didRemove(route, previousRoute);
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    for (final observer in _observers) {
      observer.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    }
  }

  @override
  void didStartUserGesture(Route<dynamic> route, Route<dynamic>? previousRoute) {
    for (final observer in _observers) {
      observer.didStartUserGesture(route, previousRoute);
    }
  }

  @override
  void didStopUserGesture() {
    for (final observer in _observers) {
      observer.didStopUserGesture();
    }
  }
}
