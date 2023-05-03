//ignore_for_file: forbidden_import_in_presentation
import 'package:bloc/bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/image_picker/utils/image_source_type.dart';
import 'package:picnic_app/features/posts/choose_media/choose_media_initial_params.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/image_post_content_input.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/video_post_content_input.dart';
import 'package:picnic_app/features/posts/domain/model/post_type.dart';
import 'package:picnic_app/features/posts/domain/use_cases/create_post_use_case.dart';
import 'package:picnic_app/features/posts/select_circle/select_circle_initial_params.dart';
import 'package:picnic_app/features/posts/upload_media/upload_media_navigator.dart';
import 'package:picnic_app/features/posts/upload_media/upload_media_presentation_model.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/navigation/confirmation_bottom_sheet_route.dart';

class UploadMediaPresenter extends Cubit<UploadMediaViewModel> {
  UploadMediaPresenter(
    super.model,
    this.navigator,
    this._createPostUseCase,
  );

  final UploadMediaNavigator navigator;
  final CreatePostUseCase _createPostUseCase;

  UploadMediaPresentationModel get _model => state as UploadMediaPresentationModel;

  Future<void> onTapPost() async {
    if (_model.createPostInput.circleId == const Id.empty()) {
      await navigator.openSelectCircle(
        SelectCircleInitialParams(
          createPostInput: _model.createPostInput,
        ),
      );
    } else {
      await _createPostUseCase.execute(
        createPostInput: _model.createPostInput,
      );
      navigator.closeUntilMain();
    }
  }

  Future<void> onTapSwitchMedia() async {
    switch (_model.createPostInput.content.type) {
      case PostType.image:
        return _updateImageFile();
      case PostType.video:
        return _updateVideoFile();
      case PostType.link:
      case PostType.poll:
      case PostType.text:
      case PostType.unknown:
        break;
    }
  }

  void onTapBack() {
    navigator.showConfirmationBottomSheet(
      title: appLocalizations.uploadMediaDiscardTitle,
      message: appLocalizations.uploadMediaDiscardDescription,
      primaryAction: ConfirmationAction(
        roundedButton: true,
        title: appLocalizations.uploadMediaConfirmationAction,
        action: () {
          navigator.close();
          navigator.close();
        },
      ),
      secondaryAction: ConfirmationAction.negative(
        action: () => navigator.close(),
      ),
    );
  }

  void onChangedText(String value) {
    tryEmit(_model.byUpdatingContentText(value));
  }

  Future<void> _updateVideoFile() async {
    final file = await navigator.getVideo(ImageSourceType.gallery);
    final content = _model.createPostInput.content as VideoPostContentInput;
    if (file != null) {
      tryEmit(_model.byUpdatingContent(content.copyWith(videoFilePath: file.path)));
    }
  }

  Future<void> _updateImageFile() async {
    final file = await navigator.openChooseMedia(const ChooseMediaInitialParams(assetType: AssetType.image));
    if (file != null) {
      final content = _model.createPostInput.content as ImagePostContentInput;
      tryEmit(_model.byUpdatingContent(content.copyWith(imageFilePath: file.path)));
    }
  }
}
