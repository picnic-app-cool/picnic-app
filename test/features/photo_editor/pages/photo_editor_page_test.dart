import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/photo_editor/photo_editor_initial_params.dart';
import 'package:picnic_app/features/photo_editor/photo_editor_navigator.dart';
import 'package:picnic_app/features/photo_editor/photo_editor_page.dart';
import 'package:picnic_app/features/photo_editor/photo_editor_presentation_model.dart';
import 'package:picnic_app/features/photo_editor/photo_editor_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/golden_tests_utils.dart';

Future<void> main() async {
  late PhotoEditorPage page;
  late PhotoEditorInitialParams initParams;
  late PhotoEditorPresentationModel model;
  late PhotoEditorPresenter presenter;
  late PhotoEditorNavigator navigator;

  void _initMvp() {
    initParams = const PhotoEditorInitialParams();
    model = PhotoEditorPresentationModel.initial(
      initParams,
    );
    navigator = PhotoEditorNavigator(Mocks.appNavigator);
    presenter = PhotoEditorPresenter(
      model,
      navigator,
    );
    page = PhotoEditorPage(presenter: presenter);
  }

  await screenshotTest(
    "photo_editor_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<PhotoEditorPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
