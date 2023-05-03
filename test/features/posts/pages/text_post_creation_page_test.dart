import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/posts/text_post_creation/text_post_creation_initial_params.dart';
import 'package:picnic_app/features/posts/text_post_creation/text_post_creation_navigator.dart';
import 'package:picnic_app/features/posts/text_post_creation/text_post_creation_page.dart';
import 'package:picnic_app/features/posts/text_post_creation/text_post_creation_presentation_model.dart';
import 'package:picnic_app/features/posts/text_post_creation/text_post_creation_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';

Future<void> main() async {
  late TextPostCreationPage page;
  late TextPostCreationInitialParams initParams;
  late TextPostCreationPresentationModel model;
  late TextPostCreationPresenter presenter;
  late TextPostCreationNavigator navigator;

  void _initMvp() {
    initParams = TextPostCreationInitialParams(onTapPost: (_) {});
    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);
    model = TextPostCreationPresentationModel.initial(
      initParams,
      Mocks.featureFlagsStore,
    );
    navigator = TextPostCreationNavigator(Mocks.appNavigator);
    presenter = TextPostCreationPresenter(
      model,
      navigator,
    );
    page = TextPostCreationPage(presenter: presenter);
  }

  await screenshotTest(
    "text_post_creation_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<TextPostCreationPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
