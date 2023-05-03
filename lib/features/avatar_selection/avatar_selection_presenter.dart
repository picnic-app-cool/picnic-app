import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/features/avatar_selection/avatar_selection_navigator.dart';
import 'package:picnic_app/features/avatar_selection/avatar_selection_presentation_model.dart';

class AvatarSelectionPresenter extends Cubit<AvatarSelectionViewModel> {
  AvatarSelectionPresenter(
    AvatarSelectionPresentationModel model,
    this.navigator,
  ) : super(model);

  final AvatarSelectionNavigator navigator;

  // ignore: unused_element
  AvatarSelectionPresentationModel get _model => state as AvatarSelectionPresentationModel;

  void onEmojiSelected(String emoji) => tryEmit(
        _model.copyWith(selectedEmoji: emoji),
      );

  void onTapConfirm() => navigator.closeWithResult(_model.selectedEmoji);
}
