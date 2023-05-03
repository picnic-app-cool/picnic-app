import 'package:bloc/bloc.dart';
import 'package:picnic_app/features/image_picker/image_picker_initial_params.dart';
import 'package:picnic_app/features/photo_editor/photo_editor_navigator.dart';
import 'package:picnic_app/features/photo_editor/photo_editor_presentation_model.dart';

class PhotoEditorPresenter extends Cubit<PhotoEditorViewModel> {
  PhotoEditorPresenter(
    PhotoEditorPresentationModel model,
    this.navigator,
  ) : super(model);

  final PhotoEditorNavigator navigator;

  // ignore: unused_element
  PhotoEditorPresentationModel get _model => state as PhotoEditorPresentationModel;

  Future<void> onTapPickImage() async {
    final file = await navigator.openImagePicker(const ImagePickerInitialParams());
    if (file != null) {
      await navigator.showImageEditor(filePath: file.path);
    }
  }
}
