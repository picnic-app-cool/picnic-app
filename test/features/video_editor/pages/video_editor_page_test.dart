import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/video_editor/video_editor_initial_params.dart';
import 'package:picnic_app/features/video_editor/video_editor_navigator.dart';
import 'package:picnic_app/features/video_editor/video_editor_page.dart';
import 'package:picnic_app/features/video_editor/video_editor_presentation_model.dart';
import 'package:picnic_app/features/video_editor/video_editor_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/golden_tests_utils.dart';

Future<void> main() async {
  late VideoEditorPage page;
  late VideoEditorInitialParams initParams;
  late VideoEditorPresentationModel model;
  late VideoEditorPresenter presenter;
  late VideoEditorNavigator navigator;

  void _initMvp() {
    initParams = const VideoEditorInitialParams();
    model = VideoEditorPresentationModel.initial(
      initParams,
    );
    navigator = VideoEditorNavigator(Mocks.appNavigator);
    presenter = VideoEditorPresenter(
      model,
      navigator,
    );
    page = VideoEditorPage(presenter: presenter);
  }

  await screenshotTest(
    "video_editor_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<VideoEditorPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
