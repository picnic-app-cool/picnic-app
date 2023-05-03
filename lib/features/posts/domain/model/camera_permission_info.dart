import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/runtime_permission_status.dart';

class CameraPermissionInfo extends Equatable {
  const CameraPermissionInfo({
    required this.cameraPermission,
    required this.microphonePermission,
  });

  const CameraPermissionInfo.empty()
      : cameraPermission = RuntimePermissionStatus.unknown,
        microphonePermission = RuntimePermissionStatus.unknown;

  final RuntimePermissionStatus cameraPermission;
  final RuntimePermissionStatus microphonePermission;

  bool get showCameraPermissionInfo =>
      RuntimePermissionStatus.isDenied(cameraPermission) || RuntimePermissionStatus.isDenied(microphonePermission);

  bool get isCameraPermissionError => RuntimePermissionStatus.isDenied(cameraPermission);

  bool get isMicrophonePermissionError => RuntimePermissionStatus.isDenied(microphonePermission);

  bool get isCameraLoading =>
      [cameraPermission, microphonePermission].any((it) => it == RuntimePermissionStatus.unknown);

  @override
  List<Object?> get props => [
        cameraPermission,
        microphonePermission,
      ];

  CameraPermissionInfo copyWith({
    RuntimePermissionStatus? cameraPermission,
    RuntimePermissionStatus? microphonePermission,
  }) {
    return CameraPermissionInfo(
      cameraPermission: cameraPermission ?? this.cameraPermission,
      microphonePermission: microphonePermission ?? this.microphonePermission,
    );
  }
}
