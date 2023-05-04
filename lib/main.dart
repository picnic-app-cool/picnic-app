import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:picnic_app/core/data/firebase/crashlytics_logger.dart';
import 'package:picnic_app/core/data/firebase/filter/image_load_error_filter.dart';
import 'package:picnic_app/core/utils/device_platform_provider.dart';
import 'package:picnic_app/core/utils/logging.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/app_init/app_init_initial_params.dart';
import 'package:picnic_app/features/app_init/app_init_page.dart';
import 'package:picnic_app/firebase_options.dart';
import 'package:picnic_app/picnic_app.dart';
import 'package:picnic_app/picnic_app_init_params.dart';
import 'package:picnic_ui_components/utils.dart' as ui_components;

/// flag modified by unit tests so that app's code can adapt to unit tests
/// (i.e: disable animations in progress bars etc.)
bool _isUnitTests = false;

bool get isUnitTests => _isUnitTests;

// ignore: avoid_positional_boolean_parameters
set isUnitTests(bool value) {
  _isUnitTests = value;
  ui_components.isUnitTests = value;
}

//ignore: long-method
void main() async {
  await dotenv.load();
  CrashlyticsLogger.setFilters([ImageLoadErrorFilter()]);

  FlutterError.onError = (details) {
    logError(
      details.exception,
      stack: details.stack,
    );

    CrashlyticsLogger.logFlutterFatalError(details);
    FlutterError.presentError(details);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    logError(
      error,
      stack: stack,
      fatal: true,
    );
    return false;
  };
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await _initFirebase();
      _runPicnicApp();
    },
    (error, stack) {
      logError(
        error,
        stack: stack,
        fatal: true,
      );
    },
  );
}

Future<void> _initFirebase() async {
  // we initialize firebase here and not in AppInitUseCase, because we want crashlytics
  // to be set up as soon as possible and cover potential failures on app start
  await Firebase.initializeApp(
    name: 'picnic_app',
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

void _runPicnicApp() {
  runApp(
    Phoenix(
      child: PicnicApp(
        initParams: PicnicAppInitParams.mobile(DevicePlatformProvider()),
        homePageProvider: () => getIt<AppInitPage>(param1: const AppInitInitialParams()),
      ),
    ),
  );
}
