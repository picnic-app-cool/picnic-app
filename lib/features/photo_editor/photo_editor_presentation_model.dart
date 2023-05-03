import 'package:picnic_app/features/photo_editor/photo_editor_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class PhotoEditorPresentationModel implements PhotoEditorViewModel {
  /// Creates the initial state
  PhotoEditorPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    PhotoEditorInitialParams initialParams,
  );

  /// Used for the copyWith method
  PhotoEditorPresentationModel._();

  PhotoEditorPresentationModel copyWith() {
    return PhotoEditorPresentationModel._();
  }
}

/// Interface to expose fields used by the view (page).
abstract class PhotoEditorViewModel {}
