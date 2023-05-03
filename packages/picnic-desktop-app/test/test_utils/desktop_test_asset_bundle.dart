// ignore_for_file: unused-code, unused-files
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:picnic_desktop_app/picnic_desktop_app.dart';

class DesktopTestAssetBundle extends CachingAssetBundle {
  final _desktopAssetBundle = PicnicAppAssetBundle();

  // This method is overridden to avoid the inherent limit of 50KB per asset.
  @override
  Future<String> loadString(String key, {bool cache = true}) async {
    final data = await load(key);
    return utf8.decode(data.buffer.asUint8List());
  }

  @override
  Future<ByteData> load(String key) async => _desktopAssetBundle.load(key);
}
