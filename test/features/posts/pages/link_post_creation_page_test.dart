import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/posts/link_post_creation/link_post_creation_initial_params.dart';
import 'package:picnic_app/features/posts/link_post_creation/link_post_creation_navigator.dart';
import 'package:picnic_app/features/posts/link_post_creation/link_post_creation_page.dart';
import 'package:picnic_app/features/posts/link_post_creation/link_post_creation_presentation_model.dart';
import 'package:picnic_app/features/posts/link_post_creation/link_post_creation_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../mocks/posts_mocks.dart';

Future<void> main() async {
  late LinkPostCreationPage page;
  late LinkPostCreationInitialParams initParams;
  late LinkPostCreationPresentationModel model;
  late LinkPostCreationPresenter presenter;
  late LinkPostCreationNavigator navigator;

  void _initMvp() {
    initParams = LinkPostCreationInitialParams(onTapPost: (_) {});
    model = LinkPostCreationPresentationModel.initial(
      initParams,
    );
    navigator = LinkPostCreationNavigator(Mocks.appNavigator);
    presenter = LinkPostCreationPresenter(
      model,
      navigator,
      Mocks.clipboardManager,
      PostsMocks.getLinkMetadataUseCase,
    );
    page = LinkPostCreationPage(presenter: presenter);
  }

  await screenshotTest(
    "link_post_creation_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<LinkPostCreationPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
