import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/device_platform.dart';

class DeviceSystemInfo extends Equatable {
  const DeviceSystemInfo({
    required this.platform,
    required this.device,
    required this.osVersion,
    required this.androidSdk,
  });

  const DeviceSystemInfo.empty()
      : platform = DevicePlatform.other,
        device = '',
        osVersion = '',
        androidSdk = 0;

  final DevicePlatform platform;
  final String osVersion;
  final String device;
  final int androidSdk;

  bool get isAndroid => platform == DevicePlatform.android;

  String get operatingSystemString => '${platform.value} $osVersion';

  @override
  List<Object?> get props => [
        platform,
        device,
        isAndroid,
        androidSdk,
      ];

  DeviceSystemInfo copyWith({
    DevicePlatform? platform,
    String? device,
    String? osVersion,
    int? androidSdk,
  }) =>
      DeviceSystemInfo(
        platform: platform ?? this.platform,
        device: device ?? this.device,
        androidSdk: androidSdk ?? this.androidSdk,
        osVersion: osVersion ?? this.osVersion,
      );
}
