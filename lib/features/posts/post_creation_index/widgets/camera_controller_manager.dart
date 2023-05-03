import 'package:flutter/material.dart';
import 'package:picnic_app/features/posts/domain/model/camera_permission_info.dart';
import 'package:picnic_app/features/posts/domain/post_creation_preview_type.dart';
import 'package:picnic_app/features/posts/widgets/camera/picnic_camera_controller.dart';
import 'package:picnic_app/main.dart';

class CameraControllerManager extends StatefulWidget {
  const CameraControllerManager({
    Key? key,
    required this.permissionInfo,
    required this.type,
    required this.builder,
    required this.controller,
  }) : super(key: key);

  final CameraPermissionInfo permissionInfo;
  final PostCreationPreviewType type;
  final Widget Function(BuildContext context, PicnicCameraController controller) builder;
  final PicnicCameraController controller;

  @override
  State<CameraControllerManager> createState() => _CameraControllerManagerState();
}

class _CameraControllerManagerState extends State<CameraControllerManager> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState lifecycleState) {
    if (![
      PostCreationPreviewType.video,
      PostCreationPreviewType.image,
    ].contains(widget.type)) {
      return;
    }
    if (lifecycleState == AppLifecycleState.inactive) {
      widget.controller.disable();
    } else if (lifecycleState == AppLifecycleState.resumed) {
      _enableCamera();
    }
  }

  @override
  void dispose() {
    if (!isUnitTests) {
      widget.controller.dispose();
    }
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant CameraControllerManager oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.type != widget.type) {
      onPostTypeChange(widget.type);
    }
    if (oldWidget.permissionInfo != widget.permissionInfo) {
      _enableCamera();
    }
  }

  void onPostTypeChange(PostCreationPreviewType type) {
    if (type == PostCreationPreviewType.image || type == PostCreationPreviewType.video) {
      widget.controller.enable();
    } else {
      widget.controller.disable();
    }
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, widget.controller);

  void _enableCamera() {
    if (!widget.permissionInfo.isCameraLoading &&
        !widget.permissionInfo.isCameraPermissionError &&
        !widget.permissionInfo.isMicrophonePermissionError) {
      widget.controller.enable();
    }
  }
}
