// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/posts/link_post_creation/link_post_creation_initial_params.dart';
import 'package:picnic_app/features/posts/link_post_creation/link_post_creation_page.dart';
import 'package:picnic_app/features/posts/photo_post_creation/photo_post_creation_initial_params.dart';
import 'package:picnic_app/features/posts/photo_post_creation/photo_post_creation_page.dart';
import 'package:picnic_app/features/posts/poll_post_creation/poll_post_creation_initial_params.dart';
import 'package:picnic_app/features/posts/poll_post_creation/poll_post_creation_page.dart';
import 'package:picnic_app/features/posts/post_creation_index/post_creation_index_presentation_model.dart';
import 'package:picnic_app/features/posts/post_creation_index/post_creation_index_presenter.dart';
import 'package:picnic_app/features/posts/post_creation_index/widgets/camera_controller_manager.dart';
import 'package:picnic_app/features/posts/text_post_creation/text_post_creation_initial_params.dart';
import 'package:picnic_app/features/posts/text_post_creation/text_post_creation_page.dart';
import 'package:picnic_app/features/posts/video_post_creation/video_post_creation_initial_params.dart';
import 'package:picnic_app/features/posts/video_post_creation/video_post_creation_page.dart';
import 'package:picnic_app/features/posts/widgets/post_creation_preview.dart';
import 'package:picnic_app/features/posts/widgets/post_creation_tab_bar.dart';
import 'package:picnic_app/ui/widgets/status_bars/dark_status_bar.dart';
import 'package:picnic_app/ui/widgets/status_bars/light_status_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PostCreationIndexPage extends StatefulWidget with HasPresenter<PostCreationIndexPresenter> {
  const PostCreationIndexPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final PostCreationIndexPresenter presenter;

  @override
  State<PostCreationIndexPage> createState() => _PostCreationIndexPageState();
}

class _PostCreationIndexPageState extends State<PostCreationIndexPage>
    with PresenterStateMixin<PostCreationIndexViewModel, PostCreationIndexPresenter, PostCreationIndexPage> {
  /// the key for post creation preview. its needed so that the widget don't get disposed when
  /// switching between fullscreen and non-fullscreen tabs (since those changes change the
  /// layout structure, the widget would get disposed without setting this key)
  late TextPostCreationPage textPostCreationPage;
  late LinkPostCreationPage linkPostCreationPage;
  late PollPostCreationPage pollPostCreationPage;
  late PhotoPostCreationPage photoPostCreationPage;
  late VideoPostCreationPage videoPostCreationPage;
  late GlobalKey _previewKey;

  @override
  void initState() {
    super.initState();
    _previewKey = GlobalKey();
    presenter.onInit();
    _initCamera();
    _initTextPostCreationPage();
    _initLinkPostCreationPage();
    _initPollPostCreationPage();
    _initPhotoPostCreationPage();
    _initVideoPostCreationPage();
  }

  @override
  Widget build(BuildContext context) {
    return stateObserver(
      builder: (context, state) {
        return CameraControllerManager(
          permissionInfo: state.cameraPermissionInfo,
          controller: state.cameraController,
          type: state.selectedType,
          builder: (context, controller) {
            final postCreationPreview = PostCreationPreview(
              ///don't remove this key, otherwise post creation pages will get disposed when switching selectedType
              ///between fullscreen and non-fullscreen
              key: _previewKey,
              selectedType: state.selectedType,
              linkPostCreationPage: linkPostCreationPage,
              textPostCreationPage: textPostCreationPage,
              pollPostCreationPage: pollPostCreationPage,
              videoPostCreationPage: videoPostCreationPage,
              imagePostCreationPage: photoPostCreationPage,
              types: state.types,
              cameraPermissionInfo: state.cameraPermissionInfo,
              onTapGoToSettings: presenter.onTapGoToSettings,
            );
            final postCreationTabBar = PostCreationTabBar(
              selectedType: state.selectedType,
              types: state.types,
              brightness: state.getPostCreationBarBrightness,
              onTap: presenter.onTabChanged,
            );
            return MediaQuery.removeViewInsets(
              context: context,
              removeBottom: true,
              child: Material(
                color: PicnicTheme.of(context).colors.blackAndWhite.shade100,
                child: state.isFullScreen
                    ? LightStatusBar(
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: postCreationPreview,
                            ),
                            Positioned(
                              bottom: MediaQuery.of(context).viewPadding.bottom,
                              left: 0,
                              right: 0,
                              child: SizedBox(
                                width: double.infinity,
                                child: postCreationTabBar,
                              ),
                            ),
                          ],
                        ),
                      )
                    : DarkStatusBar(
                        child: SafeArea(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: postCreationPreview,
                              ),
                              postCreationTabBar,
                            ],
                          ),
                        ),
                      ),
              ),
            );
          },
        );
      },
    );
  }

  void _initPhotoPostCreationPage() {
    photoPostCreationPage = getIt<PhotoPostCreationPage>(
      param1: PhotoPostCreationInitialParams(
        cameraController: state.cameraController,
        onTapPost: presenter.onTapPost,
        nativeMediaPickerPostCreationEnabled: state.nativeMediaPickerInPostCreationEnabled,
        circle: state.circle,
      ),
    );
  }

  void _initVideoPostCreationPage() {
    videoPostCreationPage = getIt<VideoPostCreationPage>(
      param1: VideoPostCreationInitialParams(
        cameraController: state.cameraController,
        onTapPost: presenter.onTapPost,
        nativeMediaPickerPostCreationEnabled: state.nativeMediaPickerInPostCreationEnabled,
        circle: state.circle,
      ),
    );
  }

  void _initPollPostCreationPage() {
    pollPostCreationPage = getIt<PollPostCreationPage>(
      param1: PollPostCreationInitialParams(
        onTapPost: presenter.onTapPost,
        circle: state.circle,
      ),
    );
  }

  void _initLinkPostCreationPage() {
    linkPostCreationPage = getIt<LinkPostCreationPage>(
      param1: LinkPostCreationInitialParams(
        onTapPost: presenter.onTapPost,
        circle: state.circle,
      ),
    );
  }

  void _initTextPostCreationPage() {
    textPostCreationPage = getIt<TextPostCreationPage>(
      param1: TextPostCreationInitialParams(
        onTapPost: presenter.onTapPost,
        circle: state.circle,
      ),
    );
  }

  void _initCamera() {
    if (!state.cameraPermissionInfo.isCameraLoading &&
        !state.cameraPermissionInfo.isCameraPermissionError &&
        !state.cameraPermissionInfo.isMicrophonePermissionError) {
      state.cameraController.enable();
    }
  }
}
