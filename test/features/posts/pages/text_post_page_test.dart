import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/stores/feature_flags_store.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/analytics/domain/use_cases/log_analytics_event_use_case.dart';
import 'package:picnic_app/features/posts/domain/model/comment_preview.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/text_post_content.dart';
import 'package:picnic_app/features/posts/domain/model/text_post_color.dart';
import 'package:picnic_app/features/posts/text_post/text_post_initial_params.dart';
import 'package:picnic_app/features/posts/text_post/text_post_navigator.dart';
import 'package:picnic_app/features/posts/text_post/text_post_page.dart';
import 'package:picnic_app/features/posts/text_post/text_post_presentation_model.dart';
import 'package:picnic_app/features/posts/text_post/text_post_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../feed_tests_utils.dart';
import '../mocks/posts_mocks.dart';

TextPostContent get stubContent => Stubs.textPost.content as TextPostContent;

Future<void> main() async {
  late TextPostPage page;
  late TextPostInitialParams initParams;
  late TextPostPresentationModel model;
  late TextPostPresenter presenter;
  late TextPostNavigator navigator;

  Future<void> _initMvp({TextPostContent? content, List<CommentPreview>? comments}) async {
    reRegister<FeatureFlagsStore>(Mocks.featureFlagsStore);
    mockCommentsPreview();
    reRegister<LogAnalyticsEventUseCase>(AnalyticsMocks.logAnalyticsEventUseCase);
    reRegister<UserStore>(Mocks.userStore);
    when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);

    when(
      () => PostsMocks.getCommentsPreviewUseCase.execute(
        postId: any(named: 'postId'),
        count: any(named: 'count'),
      ),
    ).thenAnswer((_) => successFuture(comments ?? Stubs.commentsPreview));

    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);
    initParams = TextPostInitialParams(
      post: Stubs.textPost.copyWith(content: content),
      reportId: Stubs.id,
    );
    model = TextPostPresentationModel.initial(
      initParams,
    );
    navigator = TextPostNavigator(Mocks.appNavigator);
    presenter = TextPostPresenter(
      model,
      navigator,
    );
    page = TextPostPage(presenter: presenter);
  }

  await screenshotTest(
    "text_post_page",
    setUp: () async {
      await _initMvp();
    },
    pageBuilder: () => page,
  );

  await screenshotTest(
    "text_post_page",
    variantName: "red",
    setUp: () async {
      await _initMvp(
        content: stubContent.copyWith(
          color: TextPostColor.red,
        ),
      );
    },
    pageBuilder: () => page,
  );

  await screenshotTest(
    "text_post_page",
    variantName: "green",
    setUp: () async {
      await _initMvp(
        content: stubContent.copyWith(
          color: TextPostColor.green,
        ),
      );
    },
    pageBuilder: () => page,
  );

  await screenshotTest(
    "text_post_page",
    variantName: '0_comments',
    setUp: () async {
      await _initMvp(comments: []);
    },
    pageBuilder: () => page,
  );

  await screenshotTest(
    "text_post_page",
    variantName: '6_comments',
    setUp: () async {
      await _initMvp(comments: Stubs.sixCommentsPreview);
    },
    pageBuilder: () => page,
  );

  await screenshotTest(
    "text_post_page",
    variantName: '10_comments',
    setUp: () async {
      await _initMvp(comments: Stubs.tenCommentsPreview);
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    await _initMvp();
    final page = getIt<TextPostPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
