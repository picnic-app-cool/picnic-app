import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/features/create_circle/create_circle/create_circle_initial_params.dart';
import 'package:picnic_app/features/posts/domain/model/sound.dart';
import 'package:picnic_app/features/posts/domain/model/text_post_color.dart';
import 'package:picnic_app/features/posts/sound_attachment/sound_attachment_initial_params.dart';
import 'package:picnic_app/features/posts/text_post_creation/text_post_creation_navigator.dart';
import 'package:picnic_app/features/posts/text_post_creation/text_post_creation_presentation_model.dart';

class TextPostCreationPresenter extends Cubit<TextPostCreationViewModel> {
  TextPostCreationPresenter(
    TextPostCreationPresentationModel model,
    this.navigator,
  ) : super(model);

  final TextPostCreationNavigator navigator;

  // ignore: unused_element
  TextPostCreationPresentationModel get _model => state as TextPostCreationPresentationModel;

  void onTapNewCircle() => navigator.openCreateCircle(const CreateCircleInitialParams());

  void onColorSelected(TextPostColor value) => tryEmit(_model.copyWith(selectedColor: value));

  void onTextChanged(String value) => tryEmit(_model.copyWith(text: value));

  Future<void> onTapMusic() async {
    final sound = await navigator.openSoundAttachment(const SoundAttachmentInitialParams());
    if (sound != null) {
      tryEmit(_model.copyWith(sound: sound));
    }
  }

  void onTapDeleteSoundAttachment() {
    tryEmit(_model.copyWith(sound: const Sound.empty()));
  }

  void onTapPost() => _model.onPostUpdatedCallback(_model.createPostInput);
}
