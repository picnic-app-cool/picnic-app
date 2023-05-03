// ignore_for_file: unused-code, unused-files

import 'package:flutter/material.dart';

import 'package:alchemist/alchemist.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

/// Wrapper for testing widgets (primarily screens) with device constraints
class GoldenTestDeviceScenario extends StatelessWidget {
  final Device device;
  final ValueGetter<Widget> builder;

  const GoldenTestDeviceScenario({
    required this.builder,
    required this.device,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GoldenTestScenario(
      name: device.name,
      child: ClipRect(
        child: MediaQuery(
          data: MediaQuery.of(context).copyWith(
            size: device.size,
            padding: device.safeArea,
            platformBrightness: device.brightness,
            devicePixelRatio: device.devicePixelRatio,
            textScaleFactor: device.textScale,
          ),
          child: SizedBox(
            height: device.size.height,
            width: device.size.width,
            child: builder(),
          ),
        ),
      ),
    );
  }
}
