import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/current_time_provider.dart';
import 'package:picnic_app/features/posts/widgets/camera/picnic_camera_controller.dart';
import 'package:picnic_app/features/posts/widgets/camera/picnic_camera_overlay_view.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PicnicCameraView extends StatefulWidget {
  const PicnicCameraView.photo({
    Key? key,
    required this.onPhotoTaken,
    required this.controller,
    this.currentTimeProvider,
    required this.onGalleryTap,
  })  : assert(controller != null || currentTimeProvider != null),
        onAction = null,
        super(key: key);
  const PicnicCameraView.other({
    Key? key,
    required this.onAction,
    required this.controller,
    this.currentTimeProvider,
    required this.onGalleryTap,
  })  : assert(controller != null || currentTimeProvider != null),
        onPhotoTaken = null,
        super(key: key);

  final void Function()? onAction;
  final void Function(String)? onPhotoTaken;
  final void Function()? onGalleryTap;
  final PicnicCameraController? controller;
  final CurrentTimeProvider? currentTimeProvider;

  @override
  State<PicnicCameraView> createState() => _PicnicCameraViewState();
}

/// This class needs a lof of refactoring. I have just put up the code from the package directly to make the camera
/// work
class _PicnicCameraViewState extends State<PicnicCameraView> with WidgetsBindingObserver, TickerProviderStateMixin {
  PicnicCameraController? _internalCameraController;

  PicnicCameraController get cameraController =>
      _externalControllerUsed ? widget.controller! : _internalCameraController!;

  bool get _externalControllerUsed => widget.controller != null;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    cameraController.addListener(_onCameraControllerChange);
    if (widget.controller == null) {
      _internalCameraController = PicnicCameraController(widget.currentTimeProvider!);
      _internalCameraController!.enable();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_externalControllerUsed) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.disable();
    } else if (state == AppLifecycleState.resumed) {
      cameraController.enable();
    }
  }

  @override
  void dispose() {
    if (_externalControllerUsed) {
      cameraController.removeListener(_onCameraControllerChange);
    } else {
      _internalCameraController?.dispose();
    }
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final blackAndWhite = PicnicTheme.of(context).colors.blackAndWhite;
    return ColoredBox(
      color: blackAndWhite.shade800,
      child: Stack(
        children: [
          if (cameraController.isReady)
            Center(
              child: CameraPreview(
                cameraController.internalController!,
              ),
            ),
          PicnicCameraOverlayView(
            onTapRecord: _onTapRecord,
            onTapCameraSwitch: _onSwitchCameraDirectionTap,
            onTapFlashSwitch: _onTapFlashSwitch,
            onTapOpenGallery: widget.onGalleryTap,
          ),
        ],
      ),
    );
  }

  void _onCameraControllerChange() {
    if (mounted) {
      // ignore: no-empty-block
      setState(() {});
    }
  }

  Future<void> _onSwitchCameraDirectionTap() async {
    await cameraController.switchCameraDirection();
  }

  Future<void> _onTapFlashSwitch() async {
    await cameraController.switchFlashMode();
  }

  Future<void> _onTapRecord() async {
    if (widget.onAction != null) {
      widget.onAction!.call();
    }

    if (widget.onPhotoTaken != null) {
      final filePath = await cameraController.takePhoto();
      if (mounted && filePath != null) {
        widget.onPhotoTaken!(filePath);
      }
    }
  }
}
