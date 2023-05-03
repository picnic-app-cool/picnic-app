import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/device_system_info.dart';
import 'package:picnic_app/core/domain/model/version_control_info.dart';

class AppInfo extends Equatable {
  const AppInfo({
    required this.buildSource,
    required this.buildNumber,
    required this.appVersion,
    required this.deviceInfo,
    required this.versionControlInfo,
    required this.packageName,
    required this.appName,
  });

  const AppInfo.empty()
      : buildSource = '',
        buildNumber = '',
        appVersion = '',
        packageName = '',
        appName = '',
        deviceInfo = const DeviceSystemInfo.empty(),
        versionControlInfo = const VersionControlInfo.empty();

  final String buildSource;
  final String buildNumber;
  final String appVersion;
  final DeviceSystemInfo deviceInfo;
  final String packageName;
  final String appName;
  final VersionControlInfo versionControlInfo;

  String get copiedInfo =>
      "Picnic $appVersion ($buildNumber) - $buildSource\nsystem: ${deviceInfo.platform}\ndevice: ${deviceInfo.device}$copiedVersionControlInfo";

  String get copiedVersionControlInfo => versionControlInfo.copiedInfo;

  @override
  List<Object?> get props => [
        buildSource,
        buildNumber,
        appVersion,
        deviceInfo,
        packageName,
        appName,
        versionControlInfo,
      ];

  AppInfo copyWith({
    String? buildSource,
    String? buildNumber,
    String? appVersion,
    String? packageName,
    String? appName,
    DeviceSystemInfo? deviceInfo,
    VersionControlInfo? versionControlInfo,
  }) =>
      AppInfo(
        buildSource: buildSource ?? this.buildSource,
        buildNumber: buildNumber ?? this.buildNumber,
        appVersion: appVersion ?? this.appVersion,
        deviceInfo: deviceInfo ?? this.deviceInfo,
        packageName: packageName ?? this.packageName,
        appName: appName ?? this.appName,
        versionControlInfo: versionControlInfo ?? this.versionControlInfo,
      );
}
