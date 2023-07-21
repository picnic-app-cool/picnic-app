import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/use_cases/update_circle_use_case.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/avatar_selection/avatar_selection_initial_params.dart';
import 'package:picnic_app/features/circles/domain/model/circle_visibility.dart';
import 'package:picnic_app/features/circles/edit_circle/edit_circle_navigator.dart';
import 'package:picnic_app/features/circles/edit_circle/edit_circle_presentation_model.dart';
import 'package:picnic_app/features/image_picker/image_picker_initial_params.dart';

class EditCirclePresenter extends Cubit<EditCircleViewModel> {
  EditCirclePresenter(
    super.model,
    this.navigator,
    this._updateCircleUseCase,
  );

  final EditCircleNavigator navigator;
  final UpdateCircleUseCase _updateCircleUseCase;

  // ignore: unused_element
  EditCirclePresentationModel get _model => state as EditCirclePresentationModel;

  void onTapSaveCircle() => _updateCircleUseCase
      .execute(input: _model.updateCircleInput)
      .doOn(
        success: (resultedCircle) => navigator.closeWithResult(resultedCircle),
        fail: (fail) => navigator.showError(fail.displayableFailure()),
      )
      .observeStatusChanges(
        (result) => tryEmit(_model.copyWith(saveResult: result)),
      );

  void onTapBack() {
    if (_model.circleInfoChanged) {
      onTapShowConfirm();
    } else {
      navigator.close();
    }
  }

  void onTapShowConfirm() => navigator.showDiscardCircleInfoChangesRoute(
        onTapSave: state.saveEnabled
            ? () {
                navigator.close();
                onTapSaveCircle();
              }
            : null,
      );

  void onPrivateStatusChanged({required bool newValue}) => notImplemented();

  void onDiscoverableStatusChanged({required bool newValue}) => notImplemented();

  void onTapAvatarEdit() {
    navigator.showCircleAvatarBottomSheet(
      onTapUploadPicture: onTapUploadImage,
      onTapSelectEmoji: onTapUploadEmoji,
    );
  }

  Future<void> onTapUploadImage() async {
    final image = await navigator.openImagePicker(const ImagePickerInitialParams());
    if (image == null) {
      return;
    }
    tryEmit(_model.byUpdatingImage(image.path));
  }

  Future<void> onTapCoverEdit() async {
    final cover = await navigator.openImagePicker(const ImagePickerInitialParams());
    if (cover == null) {
      return;
    }
    tryEmit(_model.byUpdatingCover(cover.path));
  }

  Future<void> onTapUploadEmoji() async {
    final emoji = await navigator.openAvatarSelection(AvatarSelectionInitialParams(emoji: _model.emoji));
    if (emoji != null) {
      tryEmit(_model.byUpdatingEmoji(emoji));
    }
  }

  void onChangedCircleName(String value) => tryEmit(_model.byUpdatingName(value));

  void onChangedCircleDescription(String value) => tryEmit(_model.byUpdatingDescription(value));

  void onChangedCircleVisibility(CircleVisibility value) => tryEmit(
        _model.byUpdatingVisibility(value),
      );
}
