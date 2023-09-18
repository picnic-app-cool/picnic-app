import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/model/runtime_permission.dart';
import 'package:picnic_app/core/domain/model/runtime_permission_status.dart';
import 'package:picnic_app/core/domain/use_cases/open_native_app_settings_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/request_runtime_permission_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/upload_contacts_use_case.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/circle_details/circle_details_initial_params.dart';
import 'package:picnic_app/features/posts/domain/model/create_post_input.dart';
import 'package:picnic_app/features/posts/domain/post_creation_preview_type.dart';
import 'package:picnic_app/features/posts/domain/use_cases/create_post_use_case.dart';
import 'package:picnic_app/features/posts/post_creation_index/post_creation_index_navigator.dart';
import 'package:picnic_app/features/posts/post_creation_index/post_creation_index_presentation_model.dart';
import 'package:picnic_app/features/posts/select_circle/select_circle_initial_params.dart';
import 'package:picnic_app/features/posts/upload_media/upload_media_initial_params.dart';

class PostCreationIndexPresenter extends Cubit<PostCreationIndexViewModel> {
  PostCreationIndexPresenter(
    PostCreationIndexPresentationModel model,
    this.navigator,
    this._requestRuntimePermissionUseCase,
    this._openNativeAppSettingsUseCase,
    this._uploadContactsUseCase,
    this._createPostUseCase,
  ) : super(model);

  final PostCreationIndexNavigator navigator;
  final RequestRuntimePermissionUseCase _requestRuntimePermissionUseCase;
  final OpenNativeAppSettingsUseCase _openNativeAppSettingsUseCase;
  final UploadContactsUseCase _uploadContactsUseCase;
  final CreatePostUseCase _createPostUseCase;

  // ignore: unused_element
  PostCreationIndexPresentationModel get _model => state as PostCreationIndexPresentationModel;

  void onTabChanged(PostCreationPreviewType type) => tryEmit(_model.copyWith(type: type));

  Future<void> onTapPost(CreatePostInput postInput) async => postInput.withCaption
      ? _openUploadMedia(postInput.copyWith(circleId: _model.preselectedCircleId))
      : _model.preselectedCircleId == const Id.empty()
          ? _openSelectCircle(postInput)
          : _createPost(postInput.copyWith(circleId: _model.preselectedCircleId));

  Future<void> onInit() async {
    await _requestContactsPermissions();
    await _requestCameraPermission();
    await _requestMicrophonePermissions();
  }

  void onTapGoToSettings() => _openNativeAppSettingsUseCase.execute();

  Future<void> _requestCameraPermission() => _requestRuntimePermissionUseCase
      .execute(permission: RuntimePermission.camera) //
      .doOn(
        fail: (fail) => navigator.showError(fail.displayableFailure()),
        success: (status) {
          tryEmit(
            _model.copyWith(
              cameraPermissionInfo: _model.cameraPermissionInfo.copyWith(cameraPermission: status),
            ),
          );
        },
      );

  Future<void> _requestMicrophonePermissions() => _requestRuntimePermissionUseCase
      .execute(permission: RuntimePermission.microphone) //
      .doOn(
        fail: (fail) => navigator.showError(fail.displayableFailure()),
        success: (status) {
          tryEmit(
            _model.copyWith(
              cameraPermissionInfo: _model.cameraPermissionInfo.copyWith(microphonePermission: status),
            ),
          );
        },
      );

  Future<void> _requestContactsPermissions() => _requestRuntimePermissionUseCase
      .execute(permission: RuntimePermission.contacts) //
      .doOn(
        fail: (fail) => navigator.showError(fail.displayableFailure()),
        success: (status) {
          tryEmit(
            _model.copyWith(
              contactsPermission: status,
            ),
          );
          _uploadContacts();
        },
      );

  Future<void> _uploadContacts() async {
    if (_model.contactsPermission == RuntimePermissionStatus.granted) {
      await _uploadContactsUseCase.execute();
    }
  }

  Future<void> _openSelectCircle(CreatePostInput postInput) async => navigator.openSelectCircle(
        SelectCircleInitialParams(
          createPostInput: postInput,
        ),
      );

  Future<void> _createPost(CreatePostInput postInput) async {
    await _createPostUseCase.execute(
      createPostInput: postInput,
    );

    navigator.closeUntilMain();
    await navigator.openCircleDetails(
      CircleDetailsInitialParams(circleId: postInput.circleId),
    );
  }

  Future<void> _openUploadMedia(CreatePostInput postInput) async => navigator.openUploadMedia(
        UploadMediaInitialParams(
          createPostInput: postInput,
        ),
      );
}
