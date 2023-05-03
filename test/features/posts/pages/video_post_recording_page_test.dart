import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/posts/video_post_recording/video_post_recording_initial_params.dart';
import 'package:picnic_app/features/posts/video_post_recording/video_post_recording_navigator.dart';
import 'package:picnic_app/features/posts/video_post_recording/video_post_recording_page.dart';
import 'package:picnic_app/features/posts/video_post_recording/video_post_recording_presentation_model.dart';
import 'package:picnic_app/features/posts/video_post_recording/video_post_recording_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../feed_tests_utils.dart';

Future<void> main() async {
  late VideoPostRecordingPage page;
  late VideoPostRecordingInitialParams initParams;
  late VideoPostRecordingPresentationModel model;
  late VideoPostRecordingPresenter presenter;
  late VideoPostRecordingNavigator navigator;

  void _initMvp() {
    mockCameraController();
    initParams = VideoPostRecordingInitialParams(Mocks.cameraController);
    model = VideoPostRecordingPresentationModel.initial(
      initParams,
    );
    navigator = VideoPostRecordingNavigator(Mocks.appNavigator);
    presenter = VideoPostRecordingPresenter(
      model,
      navigator,
      // Without this line we'll get `A Timer is still pending even after the widget tree was disposed.`
      avoidTimers: true,
    );
    page = VideoPostRecordingPage(presenter: presenter);
  }

  await screenshotTest(
    "video_post_recording_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<VideoPostRecordingPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
