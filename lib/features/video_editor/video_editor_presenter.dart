import 'package:bloc/bloc.dart';
import 'package:picnic_app/features/video_editor/video_editor_navigator.dart';
import 'package:picnic_app/features/video_editor/video_editor_presentation_model.dart';
import 'package:picnic_app/resources/assets.gen.dart';

class VideoEditorPresenter extends Cubit<VideoEditorViewModel> {
  VideoEditorPresenter(
    VideoEditorPresentationModel model,
    this.navigator,
  ) : super(model);

  final VideoEditorNavigator navigator;

  // ignore: unused_element
  VideoEditorPresentationModel get _model => state as VideoEditorPresentationModel;

  // TODO: remove asset in GS-2556
  void onTapEditVideo() => navigator.editVideo(Assets.sampleVideo);
}
