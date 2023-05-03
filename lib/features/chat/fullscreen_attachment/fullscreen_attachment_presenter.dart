import 'package:bloc/bloc.dart';
import 'package:picnic_app/features/chat/fullscreen_attachment/fullscreen_attachment_navigator.dart';
import 'package:picnic_app/features/chat/fullscreen_attachment/fullscreen_attachment_presentation_model.dart';

class FullscreenAttachmentPresenter extends Cubit<FullscreenAttachmentViewModel> {
  FullscreenAttachmentPresenter(
    super.model,
    this.navigator,
  );

  final FullscreenAttachmentNavigator navigator;

  void onTapBack() {
    navigator.close();
  }
}
