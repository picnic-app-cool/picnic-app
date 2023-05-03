import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/posts/video_post_recording/video_post_recording_presentation_model.dart';
import 'package:picnic_app/features/posts/video_post_recording/video_post_recording_presenter.dart';
import 'package:picnic_app/features/posts/widgets/camera/picnic_camera_controller.dart';
import 'package:picnic_app/features/posts/widgets/camera/picnic_camera_primary_pause_button.dart';
import 'package:picnic_app/features/posts/widgets/camera/picnic_camera_primary_record_button.dart';
import 'package:picnic_app/features/posts/widgets/camera/picnic_camera_secondary_flash_button.dart';
import 'package:picnic_app/features/posts/widgets/camera/picnic_camera_secondary_send_button.dart';
import 'package:picnic_app/features/posts/widgets/camera/picnic_camera_secondary_switch_button.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class VideoPostRecordingPage extends StatefulWidget with HasPresenter<VideoPostRecordingPresenter> {
  const VideoPostRecordingPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final VideoPostRecordingPresenter presenter;

  @override
  State<VideoPostRecordingPage> createState() => _VideoPostRecordingPageState();
}

class _VideoPostRecordingPageState extends State<VideoPostRecordingPage>
    with PresenterStateMixin<VideoPostRecordingViewModel, VideoPostRecordingPresenter, VideoPostRecordingPage> {
  @override
  void initState() {
    super.initState();
    presenter.onInit();
    state.cameraController.addListener(_onCameraControllerChange);
  }

  @override
  void dispose() {
    state.cameraController.removeListener(_onCameraControllerChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final blackAndWhite = theme.colors.blackAndWhite;

    const progressBarHeight = 4.0;
    final progressBarColor = blackAndWhite.shade100.withOpacity(0.2);
    final progressBarBorderRadius = BorderRadius.circular(100);

    return Scaffold(
      backgroundColor: blackAndWhite.shade800,
      body: Stack(
        children: [
          stateObserver(
            buildWhen: (a, b) => a.cameraController != b.cameraController,
            builder: (context, state) => Center(
              child: state.cameraController.isReady
                  ? CameraPreview(
                      state.cameraController.internalController!,
                    )
                  : null,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PicnicAppBar(
                iconPathLeft: Assets.images.close.path,
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 24.0,
                    right: 24,
                    bottom: 30,
                  ),
                  child: stateObserver(
                    builder: (context, state) => Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            PicnicCameraSecondaryFlashButton(
                              onTap: presenter.onTapSwitchFlash,
                              enableFlash: !state.flashEnabled,
                            ),
                            if (state.recordingState == VideoRecordingState.notRecording || //
                                state.recordingState == VideoRecordingState.paused)
                              PicnicCameraPrimaryRecordButton(
                                onTap: presenter.onTapRecord,
                              )
                            else
                              PicnicCameraPrimaryPauseButton(
                                onTap: presenter.onTapPause,
                              ),
                            if (state.recordingState == VideoRecordingState.notRecording)
                              PicnicCameraSecondarySwitchButton(
                                onTap: presenter.onTapSwitchCameraDirection,
                              )
                            else
                              PicnicCameraSecondarySendButton(
                                onTap: presenter.onTapSend,
                              ),
                          ],
                        ),
                        const Gap(25),
                        // TODO: Move progress indicator to separate widget and draw it using custom painter
                        Container(
                          decoration: BoxDecoration(
                            color: progressBarColor,
                            borderRadius: progressBarBorderRadius,
                          ),
                          width: double.infinity,
                          height: progressBarHeight,
                          alignment: Alignment.centerLeft,
                          child: LayoutBuilder(
                            builder: (context, constraints) => stateObserver(
                              builder: (context, state) => Container(
                                decoration: BoxDecoration(
                                  color: blackAndWhite.shade100,
                                  borderRadius: progressBarBorderRadius,
                                ),
                                height: constraints.maxHeight,
                                width: constraints.maxWidth * state.recordingPercent,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
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
}
