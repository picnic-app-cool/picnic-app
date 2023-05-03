//ignore_for_file: forbidden_import_in_presentation
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:picnic_app/core/domain/use_cases/get_attachments_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/video_thumbnail_use_case.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/attachment.dart';
import 'package:picnic_app/features/posts/choose_media/choose_media_navigator.dart';
import 'package:picnic_app/features/posts/choose_media/choose_media_presentation_model.dart';

class ChooseMediaPresenter extends Cubit<ChooseMediaViewModel> {
  ChooseMediaPresenter(
    ChooseMediaPresentationModel model,
    this.navigator,
    this._getAttachmentsUseCase,
    this._videoThumbnailUseCase,
  ) : super(model);

  final ChooseMediaNavigator navigator;
  final GetAttachmentsUseCase _getAttachmentsUseCase;
  final VideoThumbnailUseCase _videoThumbnailUseCase;

  ChooseMediaPresentationModel get _model => state as ChooseMediaPresentationModel;

  void onTapAttachment(Attachment attachment) => navigator.closeWithResult(File(attachment.url));

  Future<void> loadMoreAttachments() {
    return _getAttachmentsUseCase
        .execute(nextPageCursor: _model.cursor, type: AssetType.image) //
        .mapSuccessAsync(
          (attachments) => attachments.mapItemsAsync(
            (attachment) async => attachment.isVideo
                ? attachment.copyWith(thumbUrl: await _getThumbUrl(File(attachment.url)))
                : attachment,
          ),
        )
        .doOn(
          success: (attachments) => tryEmit(_model.copyWith(attachments: _model.attachments.byAppending(attachments))),
        );
  }

  Future<String?> _getThumbUrl(File file) async {
    const maxHeight = 180;
    return (await _videoThumbnailUseCase.execute(video: file, maxHeight: maxHeight)).getSuccess();
  }
}
