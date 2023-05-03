import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:share_plus/share_plus.dart';

mixin ShareRoute {
  Future<void> shareText({
    required String text,
  }) async {
    return Share.share(
      text,
    );
  }

  Future<void> shareFiles({
    required List<String> files,
  }) async {
    return Share.shareFiles(
      files,
    );
  }

  AppNavigator get appNavigator;
}
