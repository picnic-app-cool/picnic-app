import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/posts/domain/model/create_post_input.dart';
import 'package:picnic_app/features/posts/upload_media/upload_media_initial_params.dart';
import 'package:picnic_app/features/posts/upload_media/upload_media_navigator.dart';
import 'package:picnic_app/features/posts/upload_media/upload_media_page.dart';
import 'package:picnic_app/features/posts/upload_media/upload_media_presentation_model.dart';
import 'package:picnic_app/features/posts/upload_media/upload_media_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../mocks/posts_mocks.dart';

Future<void> main() async {
  late UploadMediaPage page;
  late UploadMediaInitialParams initParams;
  late UploadMediaPresentationModel model;
  late UploadMediaPresenter presenter;
  late UploadMediaNavigator navigator;

  void initMvp() {
    const createPostInput = CreatePostInput.empty();
    initParams = const UploadMediaInitialParams(createPostInput: createPostInput);
    model = UploadMediaPresentationModel.initial(
      initParams,
    );
    navigator = UploadMediaNavigator(Mocks.appNavigator);
    presenter = UploadMediaPresenter(
      model,
      navigator,
      PostsMocks.createPostUseCase,
    );
    page = UploadMediaPage(presenter: presenter);
  }

  await screenshotTest(
    "upload_media_page",
    setUp: () async {
      initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    initMvp();
    final page = getIt<UploadMediaPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
