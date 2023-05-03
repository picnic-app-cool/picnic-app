import 'package:flutter/material.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/navigation/transitions/fade_in_page_transition.dart';
import 'package:picnic_app/navigation/transitions/fade_in_with_delay_page_transition.dart';
import 'package:picnic_app/navigation/transitions/slide_bottom_page_transition.dart';
import 'package:picnic_app/ui/widgets/picnic_blurred_page.dart';

class AppNavigator {
  AppNavigator() {
    suppressUnusedCodeWarning([fadeInRoute, slideBottomRoute]);
  }

  @protected
  //should be modified ONLY by tests, debug page and setting it in MaterialApp
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey(debugLabel: 'AppNavigator Key');

  static GlobalKey<NavigatorState>? nestedNavigatorKey;

  static BuildContext get currentContext => nestedNavigatorKey?.currentContext ?? navigatorKey.currentContext!;

  static BuildContext get rootNavigatorContext => navigatorKey.currentContext!;

  Future<R?> push<R>(
    Route<R> route, {
    BuildContext? context,
    bool useRoot = false,
  }) async {
    return _navigator(context, useRoot: useRoot).push(route);
  }

  Future<R?> pushReplacement<R>(
    Route<R> route, {
    BuildContext? context,
    bool useRoot = false,
  }) async {
    return _navigator(context, useRoot: useRoot).pushReplacement(route);
  }

  Future<R?> pushAndRemoveUntilRoot<R>(
    Route<R> route, {
    BuildContext? context,
    bool useRoot = false,
  }) async {
    return _navigator(context, useRoot: useRoot).pushAndRemoveUntil(route, (route) => false);
  }

  void close({
    BuildContext? context,
  }) =>
      closeWithResult(null, context: context);

  void closeWithResult<T>(
    T result, {
    BuildContext? context,
  }) =>
      _navigator(context).canPop() ? _navigator(context).pop(result) : result;

  void popUntilRoot([BuildContext? context]) => _navigator(context).popUntil((route) => false);

  void popUntilPageWithName(
    String title, {
    BuildContext? context,
  }) =>
      _navigator(context).popUntil(ModalRoute.withName(title));
}

Route<T> noTransitionRoute<T>(
  Widget page, {
  int? durationMillis,
  String? pageName,
  bool opaque = true,
}) =>
    PageRouteBuilder<T>(
      opaque: opaque,
      transitionDuration: Duration.zero,
      settings: RouteSettings(name: pageName ?? page.runtimeType.toString()),
      pageBuilder: _pageBuilder(page),
    );

Route<T> picnicModalRoute<T>(
  Widget page, {
  int? durationMillis,
  bool dismissible = true,
  String? pageName,
}) =>
    fadeInRoute(
      PicnicBlurredPage(page: page, isDismissible: dismissible),
      durationMillis: durationMillis,
      opaque: false,
      fullScreenDialog: true,
    );

//ignore: long-parameter-list
Route<T> fadeInRoute<T>(
  Widget page, {
  int? durationMillis,
  String? pageName,
  bool opaque = true,
  bool fadeOut = true,
  bool fullScreenDialog = false,
}) =>
    PageRouteBuilder<T>(
      opaque: opaque,
      transitionDuration: Duration(
        milliseconds: durationMillis ?? Durations.medium,
      ),
      settings: RouteSettings(name: pageName ?? page.runtimeType.toString()),
      pageBuilder: _pageBuilder(page),
      transitionsBuilder: fadeInPageTransition(fadeOut: fadeOut),
      fullscreenDialog: fullScreenDialog,
    );

//ignore: long-parameter-list
Route<T> fadeInWithDelayRoute<T>(
  Widget page, {
  int? durationMillis,
  String? pageName,
  //ignore: no-magic-number
  double animationDelayPercent = 0.5,
  bool opaque = true,
  bool fadeOut = true,
  bool fullScreenDialog = false,
}) =>
    PageRouteBuilder<T>(
      opaque: opaque,
      transitionDuration: Duration(
        milliseconds: durationMillis ?? Durations.long,
      ),
      settings: RouteSettings(name: pageName ?? page.runtimeType.toString()),
      pageBuilder: _pageBuilder(page),
      transitionsBuilder: fadeInWithDelayPageTransition(
        fadeOut: fadeOut,
        animationDelayPercent: animationDelayPercent,
      ),
      fullscreenDialog: fullScreenDialog,
    );

Route<T> materialRoute<T>(
  Widget page, {
  bool fullScreenDialog = false,
  String? pageName,
}) =>
    MaterialPageRoute(
      builder: (context) => page,
      settings: RouteSettings(name: pageName ?? page.runtimeType.toString()),
      fullscreenDialog: fullScreenDialog,
    );

//ignore: long-parameter-list
Route<T> slideBottomRoute<T>(
  Widget page, {
  int? durationMillis,
  bool fullScreenDialog = false,
  String? pageName,
  bool opaque = true,
}) =>
    _transitionRoute(
      page,
      durationMillis: durationMillis,
      fullScreenDialog: fullScreenDialog,
      pageName: pageName,
      opaque: opaque,
      transitionsBuilder: slideBottomPageTransition(),
    );

RoutePageBuilder _pageBuilder(Widget page) => (
      context,
      animation,
      secondaryAnimation,
    ) =>
        page;

NavigatorState _navigator(BuildContext? context, {bool useRoot = false}) {
  assert(!(useRoot && (context != null)), "only (useRoot = true) or (context != null) can be specified, not both");
  final rootState = AppNavigator.navigatorKey.currentState;
  if (useRoot) {
    return rootState!;
  }
  return context != null //
      ? Navigator.of(context)
      : (AppNavigator.nestedNavigatorKey?.currentState ?? rootState!);
}

//ignore: long-parameter-list
Route<T> _transitionRoute<T>(
  Widget page, {
  int? durationMillis,
  bool fullScreenDialog = false,
  String? pageName,
  bool opaque = true,
  required RouteTransitionsBuilder transitionsBuilder,
}) =>
    PageRouteBuilder<T>(
      opaque: opaque,
      transitionDuration: Duration(
        milliseconds: durationMillis ?? Durations.medium,
      ),
      fullscreenDialog: fullScreenDialog,
      settings: RouteSettings(name: pageName ?? page.runtimeType.toString()),
      pageBuilder: _pageBuilder(page),
      transitionsBuilder: transitionsBuilder,
    );
