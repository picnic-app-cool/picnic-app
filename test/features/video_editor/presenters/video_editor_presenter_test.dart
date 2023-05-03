import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/features/video_editor/video_editor_initial_params.dart';
import 'package:picnic_app/features/video_editor/video_editor_presentation_model.dart';
import 'package:picnic_app/features/video_editor/video_editor_presenter.dart';

import '../mocks/video_editor_mock_definitions.dart';

void main() {
  late VideoEditorPresentationModel model;
  late VideoEditorPresenter presenter;
  late MockVideoEditorNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  setUp(() {
    model = VideoEditorPresentationModel.initial(const VideoEditorInitialParams());
    navigator = MockVideoEditorNavigator();
    presenter = VideoEditorPresenter(
      model,
      navigator,
    );
  });
}
