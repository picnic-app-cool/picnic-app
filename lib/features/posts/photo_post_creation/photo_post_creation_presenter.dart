//ignore_for_file: forbidden_import_in_presentation
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:picnic_app/core/domain/model/runtime_permission_status.dart';
import 'package:picnic_app/core/domain/stores/app_info_store.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/domain/use_cases/image_watermark_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/request_runtime_permission_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/save_photo_to_gallery_use_case.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/image_picker/utils/image_source_type.dart';
import 'package:picnic_app/features/posts/choose_media/choose_media_initial_params.dart';
import 'package:picnic_app/features/posts/photo_post_creation/photo_post_creation_navigator.dart';
import 'package:picnic_app/features/posts/photo_post_creation/photo_post_creation_presentation_model.dart';
import 'package:picnic_app/utils/extensions/string_formatting.dart';
import 'package:picnic_app/utils/image_type_to_permission.dart';

class PhotoPostCreationPresenter extends Cubit<PhotoPostCreationViewModel> {
  PhotoPostCreationPresenter(
    PhotoPostCreationPresentationModel model,
    this.navigator,
    this._savePhotoToGalleryUseCase,
    this._imageWatermarkUseCase,
    this._userStore,
    this._requestRuntimePermissionUseCase,
    this._appInfoStore,
  ) : super(model);

  final PhotoPostCreationNavigator navigator;
  final SavePhotoToGalleryUseCase _savePhotoToGalleryUseCase;
  final ImageWatermarkUseCase _imageWatermarkUseCase;
  final UserStore _userStore;
  final RequestRuntimePermissionUseCase _requestRuntimePermissionUseCase;
  final AppInfoStore _appInfoStore;

  PhotoPostCreationPresentationModel get _model => state as PhotoPostCreationPresentationModel;

  Future<void> onPhotoTaken(String imagePath) => _editPhoto(imagePath);

  Future<void> onSelectPhotoFromGalleryTap() => _requestRuntimePermissionUseCase
      .execute(
        permission: permissionByImageSourceType(
          ImageSourceType.gallery,
          info: _appInfoStore.appInfo.deviceInfo,
        ),
      ) //
      .doOn(
        fail: (fail) => navigator.showError(fail.displayableFailure()),
        success: (status) async {
          if (status == RuntimePermissionStatus.granted) {
            final file = await navigator.openChooseMedia(const ChooseMediaInitialParams(assetType: AssetType.image));

            return _editPhoto(file?.path);
          }

          return navigator.showNoGalleryAccess();
        },
      );

  Future<void> saveWatermarkPhoto(String imagePath) async {
    await _imageWatermarkUseCase
        .execute(
          path: imagePath,
          username: _userStore.privateProfile.username.formattedUsername,
        )
        .mapSuccessAsync(
          (imagePath) => _savePhotoToGalleryUseCase.execute(path: imagePath),
        );
  }

  void onTapCreateNewCircle() => notImplemented();

  Future<void> _editPhoto(String? path) async {
    if (path == null) {
      return;
    }

    final newPath = await navigator.showImageEditor(filePath: path);

    if (newPath != null) {
      final model = _model.createPostInput(newPath);
      _model.onPostUpdatedCallback(model);
      await saveWatermarkPhoto(newPath);
    }
  }
}
