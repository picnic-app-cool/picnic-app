import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/stores/feature_flags_store.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/analytics/domain/use_cases/log_analytics_event_use_case.dart';
import 'package:picnic_app/features/posts/image_post/image_post_initial_params.dart';
import 'package:picnic_app/features/posts/image_post/image_post_navigator.dart';
import 'package:picnic_app/features/posts/image_post/image_post_page.dart';
import 'package:picnic_app/features/posts/image_post/image_post_presentation_model.dart';
import 'package:picnic_app/features/posts/image_post/image_post_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../feed_tests_utils.dart';

Future<void> main() async {
  late ImagePostPage page;
  late ImagePostInitialParams initParams;
  late ImagePostPresentationModel model;
  late ImagePostPresenter presenter;
  late ImagePostNavigator navigator;

  Future<void> _initMvp() async {
    reRegister<LogAnalyticsEventUseCase>(AnalyticsMocks.logAnalyticsEventUseCase);
    reRegister<UserStore>(Mocks.userStore);
    when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);
    reRegister<FeatureFlagsStore>(Mocks.featureFlagsStore);
    mockCommentsPreview();
    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);
    initParams = ImagePostInitialParams(
      post: Stubs.imagePost,
      reportId: Stubs.id,
      showPostSummaryBarAbovePost: false,
    );
    model = ImagePostPresentationModel.initial(
      initParams,
    );
    navigator = ImagePostNavigator(Mocks.appNavigator);
    presenter = ImagePostPresenter(
      model,
      navigator,
    );
    page = ImagePostPage(presenter: presenter);
  }

  await screenshotTest(
    "image_post_page",
    setUp: () async {
      await _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    await configureDependenciesForTests();
    await _initMvp();
    final page = getIt<ImagePostPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
