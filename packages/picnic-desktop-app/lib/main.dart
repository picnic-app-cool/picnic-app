import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:picnic_app/core/utils/logging.dart';
import 'package:picnic_app/firebase_options.dart';
import 'package:picnic_desktop_app/picnic_desktop_app.dart';
import 'package:picnic_desktop_app/resources/assets.gen.dart';
import 'package:picnic_desktop_app/resources/fonts.gen.dart';
import 'package:window_size/window_size.dart';

const _desktopMinWindowSize = Size(375, 667);

void main() {
  _ignoreUnusedCodeWarning(AssetGenImage);
  _ignoreUnusedCodeWarning(Assets);
  _ignoreUnusedCodeWarning(FontFamily);
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    logError(details.exception, stack: details.stack);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    logError(error, stack: stack);
    return false;
  };

  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await _initializeFirebase();
      setWindowMinSize(_desktopMinWindowSize);
      setWindowMaxSize(Size.infinite);
      runApp(
        Phoenix(
          child: const PicnicDesktopApp(),
        ),
      );
    },
    (error, stack) => logError(error, stack: stack),
  );
}

Future<void> _initializeFirebase() async {
  /// Firebase does not support Windows or linux now.
  final unsupportedPlatforms = [TargetPlatform.windows, TargetPlatform.linux];
  final currentPlatform = defaultTargetPlatform;

  if (!unsupportedPlatforms.contains(currentPlatform)) {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  }
}

// quick hack to silence unused code warning, should be removed as soon as we add first
// fonts and images to assets
bool _ignoreUnusedCodeWarning(dynamic something) {
  return something != null;
}
