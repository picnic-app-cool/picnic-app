// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/posts/domain/model/post_type.dart';
import 'package:picnic_app/features/posts/posts_list/widgets/posting_disabled_card.dart';
import 'package:picnic_app/features/posts/video_post_creation/video_post_creation_presentation_model.dart';
import 'package:picnic_app/features/posts/video_post_creation/video_post_creation_presenter.dart';
import 'package:picnic_app/features/posts/widgets/camera/picnic_camera_controller.dart';
import 'package:picnic_app/features/posts/widgets/camera/picnic_camera_view.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/main.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class VideoPostCreationPage extends StatefulWidget with HasPresenter<VideoPostCreationPresenter> {
  const VideoPostCreationPage({
    required this.presenter,
    this.cameraController,
    Key? key,
  }) : super(key: key);

  @override
  final VideoPostCreationPresenter presenter;

  final PicnicCameraController? cameraController;

  @override
  State<VideoPostCreationPage> createState() => _VideoPostCreationPageState();
}

class _VideoPostCreationPageState extends State<VideoPostCreationPage>
    with PresenterStateMixin<VideoPostCreationViewModel, VideoPostCreationPresenter, VideoPostCreationPage> {
  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    return isUnitTests
        ? Scaffold(
            backgroundColor: theme.colors.blackAndWhite.shade900,
            body: const Center(
              child: Text(
                "PhotoPostCreationPage\n(NOT IMPLEMENTED YET)",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        : state.postingEnabled
            ? PicnicCameraView.other(
                onAction: presenter.onVideoRecordTap,
                controller: widget.cameraController,
                onGalleryTap: state.nativeMediaPickerPostCreationEnabled ? presenter.onSelectVideoFromGalleryTap : null,
              )
            : Scaffold(
                appBar: PicnicAppBar(
                  iconPathLeft: Assets.images.arrowlefttwo.path,
                  child: Text(
                    appLocalizations.postVideoTitle,
                    style: theme.styles.subtitle30,
                  ),
                ),
                body: Center(child: PostingDisabledCard(postingType: PostType.video, circleName: state.circleName)),
              );
  }
}
