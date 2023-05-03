import 'package:picnic_app/features/video_editor/video_editor_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class VideoEditorPresentationModel implements VideoEditorViewModel {
  /// Creates the initial state
  VideoEditorPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    VideoEditorInitialParams initialParams,
  );

  /// Used for the copyWith method
  VideoEditorPresentationModel._();

  VideoEditorPresentationModel copyWith() {
    return VideoEditorPresentationModel._();
  }
}

/// Interface to expose fields used by the view (page).
abstract class VideoEditorViewModel {}
