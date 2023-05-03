import 'package:flutter/widgets.dart';
import 'package:picnic_app/navigation/app_navigator.dart';

/// the only purpose of this class is to wrap the root bundle
/// interaction in an object that can be easly mocked in testing
class AssetsLoader {
  Future<String> loadString(
    String key, {
    bool cache = true,
  }) =>
      DefaultAssetBundle.of(AppNavigator.currentContext).loadString(key, cache: cache);
}
