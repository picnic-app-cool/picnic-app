import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/posts/photo_post_creation/photo_post_creation_initial_params.dart';
import 'package:picnic_app/features/posts/photo_post_creation/photo_post_creation_navigator.dart';
import 'package:picnic_app/features/posts/photo_post_creation/photo_post_creation_page.dart';
import 'package:picnic_app/features/posts/photo_post_creation/photo_post_creation_presentation_model.dart';
import 'package:picnic_app/features/posts/photo_post_creation/photo_post_creation_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/golden_tests_utils.dart';

Future<void> main() async {
  late PhotoPostCreationPage page;
  late PhotoPostCreationInitialParams initParams;
  late PhotoPostCreationPresentationModel model;
  late PhotoPostCreationPresenter presenter;
  late PhotoPostCreationNavigator navigator;

  void _initMvp() {
    initParams = PhotoPostCreationInitialParams(
      onTapPost: (_) {},
      nativeMediaPickerPostCreationEnabled: false,
    );
    model = PhotoPostCreationPresentationModel.initial(
      initParams,
    );
    navigator = PhotoPostCreationNavigator(Mocks.appNavigator);
    presenter = PhotoPostCreationPresenter(
      model,
      navigator,
      Mocks.savePhotoToGalleryUseCase,
      Mocks.imageWatermarkUseCase,
      Mocks.userStore,
      Mocks.requestRuntimePermissionUseCase,
      Mocks.appInfoStore,
    );
    page = PhotoPostCreationPage(
      presenter: presenter,
    );
  }

  await screenshotTest(
    "photo_post_creation_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<PhotoPostCreationPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
