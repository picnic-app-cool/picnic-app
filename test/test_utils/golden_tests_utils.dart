import 'dart:async';

import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:meta/meta.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

import 'golden_test_app_widget.dart';

//428px × 926px - iphone 13 pro max
//390px × 844px - iphone 13 pro
//375px x 667px - iphone 8
final testDevices = [
  const Device(
    name: "iphone SE",
    size: Size(375, 667),
  ),
  const Device(
    name: "iphone pro",
    size: Size(390, 844),
    safeArea: EdgeInsets.only(top: 47, bottom: 34),
  ),
  const Device(
    name: "iphone pro max",
    size: Size(428, 926),
    safeArea: EdgeInsets.only(top: 47, bottom: 34),
  ),
];

@isTest
Future<void> screenshotTest(
  String description, {
  String variantName = '',
  bool skip = false,
  FutureOr<void> Function()? setUp,
  required Widget Function() pageBuilder,
  List<String> tags = const ['golden'],
  List<Device>? devices,
  Duration timeout = const Duration(seconds: 5),
}) async {
  final descriptionWithVariant = "$description${variantName.trim().isEmpty ? '' : '_$variantName'}";
  return goldenTest(
    descriptionWithVariant,
    fileName: descriptionWithVariant,
    builder: () {
      setUp?.call();

      return GoldenTestGroup(
        columns: 3,
        children: (devices ?? testDevices) //
            .map(
              (it) => GoldenTestWidgetApp(
                device: it,
                builder: pageBuilder,
              ),
            )
            .toList(),
      );
    },
    tags: tags,
    skip: skip,
    pumpBeforeTest: (tester) async {
      //first round of precaching for images that are available immediately
      await mockNetworkImages(() => precacheImages(tester));
      //this will allow all the UI to properly settle before caching images
      await tester.pump(const LongDuration());
      //second round of precaching for images that are available a bit later, after first frame
      return mockNetworkImages(() => precacheImages(tester)).timeout(timeout);
    },
    pumpWidget: (tester, widget) => mockNetworkImages(() => tester.pumpWidget(widget)).timeout(timeout),
  ).timeout(timeout);
}

@isTest
Future<void> widgetScreenshotTest(
  String description, {
  String variantName = '',
  bool skip = false,
  FutureOr<void> Function()? setUp,
  required WidgetBuilder widgetBuilder,
  List<String> tags = const ['golden'],
  Duration timeout = const Duration(seconds: 5),
}) async {
  return goldenTest(
    description,
    fileName: "$description${variantName.trim().isEmpty ? '' : '_$variantName'}",
    builder: () {
      setUp?.call();

      return PicnicTheme(
        phoneSizeOverride: Device.phone.size,
        child: DefaultAssetBundle(
          bundle: TestAssetBundle(),
          child: Builder(builder: widgetBuilder),
        ),
      );
    },
    tags: tags,
    skip: skip,
    pumpBeforeTest: (tester) async {
      //first round of precaching for images that are available immediately
      await mockNetworkImages(() => precacheImages(tester));
      //this will allow all the UI to properly settle before caching images
      await tester.pump(const LongDuration());
      //second round of precaching for images that are available a bit later, after first frame
      return mockNetworkImages(() => precacheImages(tester)).timeout(timeout);
    },
    pumpWidget: (tester, widget) => mockNetworkImages(() => tester.pumpWidget(widget)).timeout(timeout),
  ).timeout(timeout);
}

/// small helper to add container around widget with some background in order to better understand widget's bounds
class TestWidgetContainer extends StatelessWidget {
  const TestWidgetContainer({
    super.key,
    this.backgroundColor = Colors.white70,
    required this.child,
  });

  final Widget child;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: Colors.red),
      ),
      child: child,
    );
  }
}
