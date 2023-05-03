import 'package:flutter/material.dart';

/// helper implementation of NavigatorObserver that allows you to specify all callbacks without
/// the need to extend [NavigatorObserver]]
class SimpleNavigatorObserver extends NavigatorObserver {
  SimpleNavigatorObserver({
    this.onDidPush,
    this.onDidPop,
    this.onDidRemove,
    this.onDidReplace,
    this.onDidStartUserGesture,
    this.onDidStopUserGesture,
  });

  final Function(Route<dynamic> route, Route<dynamic>? previousRoute)? onDidPush;
  final Function(Route<dynamic> route, Route<dynamic>? previousRoute)? onDidPop;
  final Function(Route<dynamic> route, Route<dynamic>? previousRoute)? onDidRemove;
  final Function({Route<dynamic>? newRoute, Route<dynamic>? oldRoute})? onDidReplace;
  final Function(Route<dynamic> route, Route<dynamic>? previousRoute)? onDidStartUserGesture;
  final Function()? onDidStopUserGesture;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    onDidPush?.call(route, previousRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    onDidPop?.call(route, previousRoute);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    onDidRemove?.call(route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    onDidReplace?.call(newRoute: newRoute, oldRoute: oldRoute);
  }

  @override
  void didStartUserGesture(Route<dynamic> route, Route<dynamic>? previousRoute) {
    onDidStartUserGesture?.call(route, previousRoute);
  }

  @override
  void didStopUserGesture() {
    onDidStopUserGesture?.call();
  }
}
