import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/features/posts/video_post_creation/video_post_creation_initial_params.dart';
import 'package:picnic_app/features/posts/video_post_creation/video_post_creation_presentation_model.dart';
import 'package:picnic_app/features/posts/video_post_creation/video_post_creation_presenter.dart';

import '../../../mocks/mocks.dart';
import '../mocks/posts_mock_definitions.dart';

void main() {
  late VideoPostCreationPresentationModel model;
  late VideoPostCreationPresenter presenter;
  late MockVideoPostCreationNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  setUp(() {
    model = VideoPostCreationPresentationModel.initial(
      VideoPostCreationInitialParams(
        cameraController: Mocks.cameraController,
        onTapPost: (_) {},
        nativeMediaPickerPostCreationEnabled: false,
      ),
    );
    navigator = MockVideoPostCreationNavigator();
    presenter = VideoPostCreationPresenter(
      model,
      navigator,
      Mocks.requestRuntimePermissionUseCase,
      Mocks.appInfoStore,
    );
  });
}
