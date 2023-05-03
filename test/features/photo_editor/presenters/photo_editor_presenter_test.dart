import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/features/photo_editor/photo_editor_initial_params.dart';
import 'package:picnic_app/features/photo_editor/photo_editor_presentation_model.dart';
import 'package:picnic_app/features/photo_editor/photo_editor_presenter.dart';

import '../mocks/photo_editor_mock_definitions.dart';

void main() {
  late PhotoEditorPresentationModel model;
  late PhotoEditorPresenter presenter;
  late MockPhotoEditorNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  setUp(() {
    model = PhotoEditorPresentationModel.initial(const PhotoEditorInitialParams());
    navigator = MockPhotoEditorNavigator();
    presenter = PhotoEditorPresenter(
      model,
      navigator,
    );
  });
}
