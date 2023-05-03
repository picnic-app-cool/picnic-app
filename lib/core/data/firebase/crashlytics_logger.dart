import 'package:collection/collection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:picnic_app/core/data/firebase/filter/error_filter.dart';
import 'package:picnic_app/core/data/firebase/firebase_provider.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';

class CrashlyticsLogger {
  static final List<ErrorFilter> _errorFiltersList = [];

  static void setFilters(List<ErrorFilter> errorFilters) {
    _errorFiltersList.addAll(errorFilters);
  }

  //ignore: long-parameter-list
  static void logError(
    dynamic error, {
    StackTrace? stack,
    String? reason,
    bool fatal = false,
  }) {
    final shouldBeLogged = _errorFiltersList.none((it) => it.suppress(error));
    if (kDebugMode || Firebase.apps.isEmpty || !shouldBeLogged) {
      return;
    }
    getIt<FirebaseProvider>().crashlytics?.recordError(
          error,
          stack,
          fatal: fatal,
        );
  }

  static void logFlutterFatalError(
    FlutterErrorDetails errorDetails,
  ) {
    final shouldBeLogged = _errorFiltersList.none((it) => it.suppress(errorDetails));
    if (kDebugMode || Firebase.apps.isEmpty || !shouldBeLogged) {
      return;
    }
    getIt<FirebaseProvider>().crashlytics?.recordFlutterFatalError(errorDetails);
  }
}
