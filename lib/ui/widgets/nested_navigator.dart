import 'package:flutter/material.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/analytics/analytics_observer.dart';

class NestedNavigator extends StatefulWidget {
  const NestedNavigator({
    required this.navigatorKey,
    required this.initialRoute,
    this.onDidPop,
    this.onDidPush,
    this.onDidReplace,
    this.onDidRemove,
  }) : super();

  final GlobalKey<NavigatorState> navigatorKey;
  final Widget initialRoute;
  final VoidCallback? onDidPop;
  final VoidCallback? onDidPush;
  final VoidCallback? onDidReplace;
  final VoidCallback? onDidRemove;

  @override
  State<NestedNavigator> createState() => NestedNavigatorState();
}

class NestedNavigatorState extends State<NestedNavigator> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: HeroControllerScope(
        controller: MaterialApp.createMaterialHeroController(),
        child: Navigator(
          observers: [
            getIt<AnalyticsObserver>(),
            _NavigatorObserver(
              onDidPop: widget.onDidPop,
              onDidPush: widget.onDidPush,
              onDidReplace: widget.onDidReplace,
              onDidRemove: widget.onDidRemove,
            ),
          ],
          key: widget.navigatorKey,
          onGenerateRoute: (_) => PageRouteBuilder(
            opaque: false,
            // ignore: prefer-trailing-comma
            pageBuilder: (_, __, ___) => widget.initialRoute,
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    final navigatorState = widget.navigatorKey.currentState;
    if (!(navigatorState?.canPop() ?? false)) {
      return true;
    }
    return !(navigatorState?.userGestureInProgress ?? false);
  }
}

class _NavigatorObserver extends NavigatorObserver {
  _NavigatorObserver({
    this.onDidPop,
    this.onDidPush,
    this.onDidReplace,
    this.onDidRemove,
  });

  final VoidCallback? onDidPop;
  final VoidCallback? onDidPush;
  final VoidCallback? onDidReplace;
  final VoidCallback? onDidRemove;

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) => onDidRemove?.call();

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) => onDidReplace?.call();

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) => onDidPop?.call();

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) => onDidPush?.call();
}
