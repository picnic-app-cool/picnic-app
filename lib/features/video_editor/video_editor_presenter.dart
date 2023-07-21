import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/features/video_editor/video_editor_navigator.dart';
import 'package:picnic_app/features/video_editor/video_editor_presentation_model.dart';

class VideoEditorPresenter extends Cubit<VideoEditorViewModel> {
  VideoEditorPresenter(
    VideoEditorPresentationModel model,
    this.navigator,
  ) : super(model);

  final VideoEditorNavigator navigator;

  // ignore: unused_element
  VideoEditorPresentationModel get _model => state as VideoEditorPresentationModel;

  void onTapEditVideo() => notImplemented();
}
