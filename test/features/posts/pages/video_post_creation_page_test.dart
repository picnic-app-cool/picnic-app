import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/posts/video_post_creation/video_post_creation_initial_params.dart';
import 'package:picnic_app/features/posts/video_post_creation/video_post_creation_navigator.dart';
import 'package:picnic_app/features/posts/video_post_creation/video_post_creation_page.dart';
import 'package:picnic_app/features/posts/video_post_creation/video_post_creation_presentation_model.dart';
import 'package:picnic_app/features/posts/video_post_creation/video_post_creation_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/golden_tests_utils.dart';

Future<void> main() async {
  late VideoPostCreationPage page;
  late VideoPostCreationInitialParams initParams;
  late VideoPostCreationPresentationModel model;
  late VideoPostCreationPresenter presenter;
  late VideoPostCreationNavigator navigator;

  void _initMvp() {
    initParams = VideoPostCreationInitialParams(
      cameraController: Mocks.cameraController,
      onTapPost: (_) {},
      nativeMediaPickerPostCreationEnabled: false,
    );
    model = VideoPostCreationPresentationModel.initial(
      initParams,
    );
    navigator = VideoPostCreationNavigator(Mocks.appNavigator);
    presenter = VideoPostCreationPresenter(
      model,
      navigator,
      Mocks.requestRuntimePermissionUseCase,
      Mocks.appInfoStore,
    );
    page = VideoPostCreationPage(presenter: presenter);
  }

  await screenshotTest(
    "video_post_creation_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<VideoPostCreationPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
