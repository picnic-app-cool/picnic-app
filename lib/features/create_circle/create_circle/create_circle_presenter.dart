import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/features/avatar_selection/avatar_selection_initial_params.dart';
import 'package:picnic_app/features/circles/circle_config/circle_config_initial_params.dart';
import 'package:picnic_app/features/circles/circle_groups_selection/circle_groups_selection_initial_params.dart';
import 'package:picnic_app/features/circles/domain/model/circle_visibility.dart';
import 'package:picnic_app/features/create_circle/create_circle/create_circle_navigator.dart';
import 'package:picnic_app/features/create_circle/create_circle/create_circle_presentation_model.dart';
import 'package:picnic_app/features/image_picker/image_picker_initial_params.dart';
import 'package:picnic_app/features/main/languages_list/languages_list_initial_params.dart';

class CreateCirclePresenter extends Cubit<CreateCircleViewModel> {
  CreateCirclePresenter(
    CreateCirclePresentationModel model,
    this.navigator,
  ) : super(model);

  final CreateCircleNavigator navigator;

  // ignore: unused_element
  CreateCirclePresentationModel get _model => state as CreateCirclePresentationModel;

  void onTapCreateCircle() => navigator.openCircleConfig(
        CircleConfigInitialParams(
          createCircleInput: _model.createCircleInput,
          createCircleWithoutPost: _model.createCircleWithoutPost,
          createPostInput: _model.createPostInput,
          isNewCircle: true,
        ),
      );

  void onTapAvatarEdit() {
    navigator.showCircleAvatarBottomSheet(
      onTapUploadPicture: onTapUploadImage,
      onTapSelectEmoji: onTapUploadEmoji,
    );
  }

  Future<void> onTapCoverEdit() async {
    final cover = await navigator.openImagePicker(const ImagePickerInitialParams());
    if (cover == null) {
      return;
    }
    final coverPath = await navigator.showImageEditor(
      filePath: cover.path,
    );
    if (coverPath == null) {
      return;
    }
    tryEmit(
      _model.byUpdatingForm(
        (form) => form.copyWith(
          coverImage: coverPath,
          userSelectedNewCover: true,
        ),
      ),
    );
  }

  Future<void> onTapUploadImage() async {
    final image = await navigator.openImagePicker(const ImagePickerInitialParams());
    if (image == null) {
      return;
    }
    final imagePath = await navigator.showImageEditor(filePath: image.path, forceCrop: true);
    if (imagePath == null) {
      return;
    }

    tryEmit(
      _model.byUpdatingForm(
        (form) => form.copyWith(
          image: imagePath,
          emoji: '',
          userSelectedNewImage: true,
        ),
      ),
    );
  }

  Future<void> onTapUploadEmoji() async {
    final emoji =
        await navigator.openAvatarSelection(AvatarSelectionInitialParams(emoji: _model.createCircleForm.emoji));
    if (emoji != null) {
      tryEmit(
        _model.byUpdatingForm(
          (form) => form.copyWith(
            emoji: emoji,
            image: '',
            userSelectedNewImage: false,
          ),
        ),
      );
    }
  }

  Future<void> onTapPickGroup() async {
    final selectedGroup = await navigator.openCircleGroupsSelection(const CircleGroupsSelectionInitialParams());
    if (selectedGroup != null) {
      tryEmit(_model.byUpdatingForm((form) => form.copyWith(group: selectedGroup.toCircleGroup())));
    }
  }

  Future<void> onTapPickLanguage() async {
    final language = await navigator.openLanguagesList(
      LanguagesListInitialParams(selectedLanguage: _model.createCircleForm.language),
    );

    if (language != null) {
      tryEmit(
        _model.byUpdatingForm(
          (input) => input.copyWith(language: language),
        ),
      );
    }
  }

  void onChangedName(String value) => tryEmit(
        _model.byUpdatingForm(
          (input) => input.copyWith(name: value),
        ),
      );

  void onChangedDescription(String value) => tryEmit(
        _model.byUpdatingForm(
          (input) => input.copyWith(description: value),
        ),
      );

  void onChangedCircleVisibility(CircleVisibility value) => tryEmit(
        _model.byUpdatingForm(
          (input) => input.copyWith(visibility: value),
        ),
      );
}
