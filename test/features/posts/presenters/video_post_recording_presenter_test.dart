import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/features/posts/video_post_recording/video_post_recording_initial_params.dart';
import 'package:picnic_app/features/posts/video_post_recording/video_post_recording_presentation_model.dart';
import 'package:picnic_app/features/posts/video_post_recording/video_post_recording_presenter.dart';

import '../../../mocks/mocks.dart';
import '../mocks/posts_mock_definitions.dart';

void main() {
  late VideoPostRecordingPresentationModel model;
  late VideoPostRecordingPresenter presenter;
  late MockVideoPostRecordingNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  setUp(() {
    model = VideoPostRecordingPresentationModel.initial(
      VideoPostRecordingInitialParams(
        Mocks.cameraController,
      ),
    );
    navigator = MockVideoPostRecordingNavigator();
    presenter = VideoPostRecordingPresenter(
      model,
      navigator,
    );
  });
}
