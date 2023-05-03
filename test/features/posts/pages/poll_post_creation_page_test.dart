import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/posts/poll_post_creation/poll_post_creation_initial_params.dart';
import 'package:picnic_app/features/posts/poll_post_creation/poll_post_creation_navigator.dart';
import 'package:picnic_app/features/posts/poll_post_creation/poll_post_creation_page.dart';
import 'package:picnic_app/features/posts/poll_post_creation/poll_post_creation_presentation_model.dart';
import 'package:picnic_app/features/posts/poll_post_creation/poll_post_creation_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';

Future<void> main() async {
  late PollPostCreationPage page;
  late PollPostCreationInitialParams initParams;
  late PollPostCreationPresentationModel model;
  late PollPostCreationPresenter presenter;
  late PollPostCreationNavigator navigator;

  void _initMvp() {
    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);
    initParams = PollPostCreationInitialParams(onTapPost: (_) {});
    model = PollPostCreationPresentationModel.initial(
      initParams,
      Mocks.featureFlagsStore,
    );
    navigator = PollPostCreationNavigator(Mocks.appNavigator);
    presenter = PollPostCreationPresenter(
      model,
      navigator,
      Mocks.mentionUserUseCase,
    );
    page = PollPostCreationPage(presenter: presenter);
  }

  await screenshotTest(
    "poll_post_creation_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<PollPostCreationPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
