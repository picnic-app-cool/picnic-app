import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/stores/feature_flags_store.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/analytics/domain/use_cases/log_analytics_event_use_case.dart';
import 'package:picnic_app/features/posts/domain/model/comment_preview.dart';
import 'package:picnic_app/features/posts/poll_post/poll_post_initial_params.dart';
import 'package:picnic_app/features/posts/poll_post/poll_post_navigator.dart';
import 'package:picnic_app/features/posts/poll_post/poll_post_page.dart';
import 'package:picnic_app/features/posts/poll_post/poll_post_presentation_model.dart';
import 'package:picnic_app/features/posts/poll_post/poll_post_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../feed_tests_utils.dart';
import '../mocks/posts_mocks.dart';

Future<void> main() async {
  late PollPostPage page;
  late PollPostInitialParams initParams;
  late PollPostPresentationModel model;
  late PollPostPresenter presenter;
  late PollPostNavigator navigator;

  Future<void> _initMvp({List<CommentPreview>? comments}) async {
    reRegister<LogAnalyticsEventUseCase>(AnalyticsMocks.logAnalyticsEventUseCase);
    reRegister<UserStore>(Mocks.userStore);
    reRegister<FeatureFlagsStore>(Mocks.featureFlagsStore);
    mockCommentsPreview();
    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);
    when(() => Mocks.userStore.privateProfile).thenAnswer((_) => Stubs.privateProfile);
    when(() => PostsMocks.getCommentsPreviewUseCase.execute(postId: any(named: 'postId')))
        .thenAnswer((_) => successFuture(comments ?? Stubs.commentsPreview));
    initParams = PollPostInitialParams(
      reportId: Stubs.id,
      post: Stubs.pollPost,
      onPostUpdated: (_) {},
    );
    model = PollPostPresentationModel.initial(
      initParams,
    );
    navigator = PollPostNavigator(Mocks.appNavigator);
    presenter = PollPostPresenter(
      model,
      navigator,
      PostsMocks.voteInPollUseCase,
      Mocks.userStore,
    );
    page = PollPostPage(presenter: presenter);
  }

  await screenshotTest(
    "poll_post_page",
    setUp: () async {
      await _initMvp();
    },
    pageBuilder: () => page,
  );

  await screenshotTest(
    "poll_post_page",
    variantName: '0_comments',
    setUp: () async {
      await _initMvp(comments: []);
    },
    pageBuilder: () => page,
  );

  await screenshotTest(
    "poll_post_page",
    variantName: '6_comments',
    setUp: () async {
      await _initMvp(comments: Stubs.sixCommentsPreview);
    },
    pageBuilder: () => page,
  );

  await screenshotTest(
    "poll_post_page",
    variantName: '10_comments',
    setUp: () async {
      await _initMvp(comments: Stubs.tenCommentsPreview);
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    await _initMvp();
    final page = getIt<PollPostPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
