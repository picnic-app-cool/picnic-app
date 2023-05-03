import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:picnic_app/core/utils/device_platform_provider.dart';
import 'package:picnic_app/picnic_app.dart';
import 'package:picnic_app/picnic_app_init_params.dart';
import 'package:picnic_desktop_app/dependency_injection/app_component.dart';
import 'package:picnic_desktop_app/features/app_init/app_init_initial_params.dart';
import 'package:picnic_desktop_app/features/app_init/app_init_page.dart';

class PicnicDesktopApp extends StatefulWidget {
  const PicnicDesktopApp({
    super.key,
  });

  @override
  State<PicnicDesktopApp> createState() => _PicnicDesktopAppState();
}

class _PicnicDesktopAppState extends State<PicnicDesktopApp> {
  @override
  Widget build(BuildContext context) {
    return DefaultAssetBundle(
      bundle: PicnicAppAssetBundle(),
      child: PicnicApp(
        overrideDependencies: configureDependencies,
        homePageProvider: () => getIt<AppInitPage>(param1: const AppInitInitialParams()),
        initParams: PicnicAppInitParams.desktop(DevicePlatformProvider()),
      ),
    );
  }
}

/// Asset bundle that falls back to loading assets from `picnic_app` package if it cannot find it in this project's package
/// helpful, because most of the code inside picnic_app don't expect to be run as dependency to another project
class PicnicAppAssetBundle extends AssetBundle {
  @override
  Future<ByteData> load(String key) async {
    try {
      return await rootBundle.load(key);
    } catch (_) {
      return rootBundle.load('packages/picnic_app/$key');
    }
  }

  @override
  Future<T> loadStructuredData<T>(
    String key,
    Future<T> Function(String value) parser,
  ) async {
    try {
      return await rootBundle.loadStructuredData(key, parser);
    } catch (_) {
      return rootBundle.loadStructuredData('packages/picnic_app/$key', parser);
    }
  }
}
