import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/model/runtime_permission_status.dart';
import 'package:picnic_app/core/domain/stores/app_info_store.dart';
import 'package:picnic_app/core/domain/use_cases/request_runtime_permission_use_case.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/create_circle/create_circle/create_circle_initial_params.dart';
import 'package:picnic_app/features/image_picker/utils/image_source_type.dart';
import 'package:picnic_app/features/posts/video_post_creation/video_post_creation_navigator.dart';
import 'package:picnic_app/features/posts/video_post_creation/video_post_creation_presentation_model.dart';
import 'package:picnic_app/features/posts/video_post_recording/video_post_recording_initial_params.dart';
import 'package:picnic_app/utils/image_type_to_permission.dart';

class VideoPostCreationPresenter extends Cubit<VideoPostCreationViewModel> {
  VideoPostCreationPresenter(
    VideoPostCreationPresentationModel model,
    this.navigator,
    this._requestRuntimePermissionUseCase,
    this._appInfoStore,
  ) : super(model);

  final VideoPostCreationNavigator navigator;
  final RequestRuntimePermissionUseCase _requestRuntimePermissionUseCase;
  final AppInfoStore _appInfoStore;

  // ignore: unused_element
  VideoPostCreationPresentationModel get _model => state as VideoPostCreationPresentationModel;

  Future<void> onVideoRecordTap() async {
    final path = await navigator.openVideoPostRecording(VideoPostRecordingInitialParams(_model.cameraController));

    return _editVideo(path);
  }

  Future<void> onSelectVideoFromGalleryTap() => _requestRuntimePermissionUseCase
      .execute(
        permission: permissionByImageSourceType(
          ImageSourceType.gallery,
          info: _appInfoStore.appInfo.deviceInfo,
        ),
      )
      .doOn(
        fail: (fail) => navigator.showError(fail.displayableFailure()),
        success: (status) async {
          if (status == RuntimePermissionStatus.granted) {
            final file = await navigator.getVideo(ImageSourceType.gallery);
            return _editVideo(file?.path);
          }

          return navigator.showNoGalleryAccess();
        },
      );

  void onTapCreateNewCircle() => navigator.openCreateCircle(const CreateCircleInitialParams());

  Future<void> _editVideo(String? path) async {
    if (isClosed || path == null) {
      return;
    }
    final editedVideoPath = await navigator.editVideo(path);
    if (isClosed || editedVideoPath == null) {
      return;
    }
    final model = _model.createPostInput(editedVideoPath);
    _model.onPostUpdatedCallback(model);
  }
}
