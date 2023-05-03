import 'package:picnic_app/core/domain/model/app_info.dart';

class AppVersion {
  final String minAppVersion;
  final AppInfo appInfo;

  AppVersion({required this.minAppVersion, required this.appInfo});
}
