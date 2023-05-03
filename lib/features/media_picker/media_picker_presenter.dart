import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/model/runtime_permission.dart';
import 'package:picnic_app/core/domain/model/runtime_permission_status.dart';
import 'package:picnic_app/core/domain/stores/app_info_store.dart';
import 'package:picnic_app/core/domain/use_cases/get_attachments_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/open_native_app_settings_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/request_runtime_permission_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/video_thumbnail_use_case.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/attachment.dart';
import 'package:picnic_app/features/chat/domain/use_cases/get_upload_chat_attachment_use_case.dart';
import 'package:picnic_app/features/media_picker/domain/model/media_picker_file_type.dart';
import 'package:picnic_app/features/media_picker/media_picker_navigator.dart';
import 'package:picnic_app/features/media_picker/media_picker_presentation_model.dart';
import 'package:picnic_app/features/media_picker/utils/media_source_type.dart';
import 'package:picnic_app/utils/extensions/iterable_extensions.dart';
import 'package:picnic_app/utils/media_source_type_to_permission.dart';

class MediaPickerPresenter extends Cubit<MediaPickerViewModel> {
  MediaPickerPresenter(
    MediaPickerPresentationModel model,
    this.navigator,
    this._requestRuntimePermissionUseCase,
    this._videoThumbnailUseCase,
    this._getAttachmentsUseCase,
    this._getUploadChatAttachmentUseCase,
    this._openNativeAppSettingsUseCase,
    this._appInfoStore,
  ) : super(model);

  late final MediaPickerMediator mediator;
  final MediaPickerNavigator navigator;
  final RequestRuntimePermissionUseCase _requestRuntimePermissionUseCase;
  final VideoThumbnailUseCase _videoThumbnailUseCase;
  final GetAttachmentsUseCase _getAttachmentsUseCase;
  final GetUploadChatAttachmentUseCase _getUploadChatAttachmentUseCase;
  final OpenNativeAppSettingsUseCase _openNativeAppSettingsUseCase;
  final AppInfoStore _appInfoStore;

  // ignore: unused_element
  MediaPickerPresentationModel get _model => state as MediaPickerPresentationModel;

  void onTapOpenSettings() => _openNativeAppSettingsUseCase.execute();

  void setMediator(MediaPickerMediator mediator) => this.mediator = mediator;

  void onOpenAttachments() {
    _handlePermissionFromSettings().observeStatusChanges((result) {
      tryEmit(_model.copyWith(permisionRequested: result));
    });
  }

  void clearSelectedAttachments() {
    tryEmit(_model.copyWith(selectedAttachments: List.empty()));
  }

  Future<void> loadMoreAttachments() {
    return _getAttachmentsUseCase
        .execute(nextPageCursor: _model.cursor) //
        .mapSuccessAsync(
          (attachments) => attachments.mapItemsAsync(
            (a) async => a.isVideo ? a.copyWith(thumbUrl: await _getThumbUrl(File(a.url))) : a,
          ),
        )
        .doOn(
          success: (attachments) => tryEmit(_model.copyWith(attachments: _model.attachments.byAppending(attachments))),
        );
  }

  Future<void> onTapMenuItem(int index) async {
    tryEmit(_model.copyWith(currentIndex: index));

    final sourceType = MediaSourceType.from(index);
    await _handlePermissionFromSettings();
    if (state.allNecessaryPermissionsGranted) {
      await _onSuccessPermission(sourceType);
    }
  }

  Future<void> onTapAttachment(Attachment attachment) async {
    final newSelectedAttachments = [..._model.selectedAttachments];
    if (newSelectedAttachments.contains(attachment)) {
      newSelectedAttachments.remove(attachment);
    } else {
      final uploadAttachmentEither = await _getUploadChatAttachmentUseCase.execute(attachment: attachment);
      if (uploadAttachmentEither.isFailure) {
        await navigator.showError(uploadAttachmentEither.getFailure()!.displayableFailure());
        return;
      }
      final uploadAttachment = uploadAttachmentEither.getSuccess()!;
      if (!uploadAttachment.isAttachmentSizeAllowed) {
        await navigator.showFileSizeTooBigError(
          maxAllowedSize: uploadAttachment.maximumAllowedFileSize.sizeInMegabytes,
        );
        return;
      }
      newSelectedAttachments.add(attachment);
    }

    tryEmit(_model.copyWith(selectedAttachments: newSelectedAttachments));
    mediator.onSelectedAttachmentsChanged(attachments: newSelectedAttachments);
  }

  void onTapDeleteAttachment(Attachment attachment) {
    final newSelectedAttachments = [..._model.selectedAttachments];
    if (newSelectedAttachments.contains(attachment)) {
      newSelectedAttachments.remove(attachment);
      tryEmit(
        _model.copyWith(
          selectedAttachments: newSelectedAttachments,
        ),
      );
      mediator.onSelectedAttachmentsChanged(attachments: newSelectedAttachments);
    }
  }

  Future<void> onTapNativePicker() async {
    const mediaSource = MediaSourceType.gallery;
    final file = await navigator.getImageVideo(mediaSource);
    if (file != null) {
      var attachment = const Attachment.empty().copyWith(
        url: file.path,
        size: await file.length(),
        fileType: mediaSource.mediaPickerFileType.mimeType,
      );

      if (mediaSource.mediaPickerFileType == MediaPickerFileType.video) {
        attachment = attachment.copyWith(thumbUrl: await _getThumbUrl(file));
      }
      await onTapAttachment(attachment);
    }
  }

  //ignore: long-method
  Future<void> _handlePermissionFromSettings() async {
    final mediaType = MediaSourceType.from(state.currentIndex);
    if (mediaType == MediaSourceType.cameraVideo) {
      await _handleMicrophonePermission();
    }
    await _requestRuntimePermissionUseCase
        .execute(
      permission: permissionByMediaSourceType(
        mediaType,
        info: _appInfoStore.appInfo.deviceInfo,
      ),
    )
        .doOn(
      fail: (fail) {
        switch (mediaType) {
          case MediaSourceType.gallery:
            tryEmit(_model.copyWith(galleryPermissionGranted: false));
            break;
          case MediaSourceType.file:
            tryEmit(_model.copyWith(filePermissionGranted: false));
            break;
          case MediaSourceType.cameraImage:
          case MediaSourceType.cameraVideo:
            tryEmit(_model.copyWith(cameraPermissionGranted: false));
            break;
        }
      },
      success: (status) {
        final allowedStatus = status == RuntimePermissionStatus.granted || status == RuntimePermissionStatus.limited;
        switch (mediaType) {
          case MediaSourceType.gallery:
            tryEmit(_model.copyWith(galleryPermissionGranted: allowedStatus));
            break;
          case MediaSourceType.file:
            tryEmit(_model.copyWith(filePermissionGranted: allowedStatus));
            break;
          case MediaSourceType.cameraImage:
          case MediaSourceType.cameraVideo:
            tryEmit(_model.copyWith(cameraPermissionGranted: allowedStatus));
            break;
        }
      },
    );
  }

  Future<void> _handleMicrophonePermission() {
    return _requestRuntimePermissionUseCase.execute(permission: RuntimePermission.microphone).doOn(
          fail: (fail) => tryEmit(_model.copyWith(microphonePermissionGranted: false)),
          success: (status) => tryEmit(
            _model.copyWith(
              microphonePermissionGranted:
                  status == RuntimePermissionStatus.granted || status == RuntimePermissionStatus.limited,
            ),
          ),
        );
  }

  Future<void> _onSuccessPermission(MediaSourceType sourceType) async {
    if (sourceType == MediaSourceType.file) {
      final documents = await _getDocuments();
      if (documents.isNotEmpty) {
        mediator.onDocumentsPicked(documents: documents);
      }
      return;
    }

    final attachment = await _getAttachment(sourceType);
    if (attachment != null) {
      await onTapAttachment(attachment);
    }
    tryEmit(_model.copyWith(currentIndex: 0));
  }

  Future<List<Attachment>> _getDocuments() async {
    final files = await navigator.getPdfFiles();
    return (await files.mapAsync(
      (f) async => const Attachment.empty().copyWith(
        url: f.path,
        size: await f.length(),
        fileType: MediaSourceType.file.mediaPickerFileType.mimeType,
      ),
    ))
        .toList();
  }

  Future<Attachment?> _getAttachment(MediaSourceType sourceType) async {
    Attachment? attachment;
    final file = await navigator.getImageVideo(sourceType);
    if (file != null) {
      attachment = const Attachment.empty().copyWith(
        url: file.path,
        size: await file.length(),
        fileType: sourceType.mediaPickerFileType.mimeType,
      );

      if (sourceType.mediaPickerFileType == MediaPickerFileType.video) {
        attachment = attachment.copyWith(thumbUrl: await _getThumbUrl(file));
      }
    }
    return attachment;
  }

  Future<String?> _getThumbUrl(File file) async {
    const maxHeight = 180;
    return (await _videoThumbnailUseCase.execute(video: file, maxHeight: maxHeight)).getSuccess();
  }
}

abstract class MediaPickerMediator {
  void onSelectedAttachmentsChanged({required List<Attachment> attachments});

  void onDocumentsPicked({required List<Attachment> documents});
}

extension MediaPickerFileTypeMapper on MediaSourceType {
  MediaPickerFileType get mediaPickerFileType {
    switch (this) {
      case MediaSourceType.file:
        return MediaPickerFileType.document;
      case MediaSourceType.cameraImage:
        return MediaPickerFileType.image;
      case MediaSourceType.cameraVideo:
        return MediaPickerFileType.video;
      case MediaSourceType.gallery:
        return MediaPickerFileType.image;
    }
  }
}
