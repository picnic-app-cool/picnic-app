import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/analytics/domain/model/analytics_event.dart';
import 'package:picnic_app/features/analytics/domain/model/post_viewing_time/analytics_event_post_viewing_time.dart';
import 'package:picnic_app/features/analytics/domain/use_cases/log_analytics_event_use_case.dart';
import 'package:picnic_app/features/posts/domain/model/comments_mode.dart';
import 'package:picnic_app/features/posts/domain/model/post_details_mode.dart';
import 'package:picnic_app/features/posts/domain/model/post_overlay_size.dart';
import 'package:picnic_app/features/posts/post_overlay/post_display_options.dart';
import 'package:picnic_app/features/posts/post_overlay/post_overlay_initial_params.dart';
import 'package:picnic_app/features/posts/post_overlay/post_overlay_mediator.dart';
import 'package:picnic_app/features/posts/post_overlay/post_overlay_navigator.dart';
import 'package:picnic_app/features/posts/post_overlay/post_overlay_page.dart';
import 'package:picnic_app/features/posts/post_overlay/post_overlay_presentation_model.dart';
import 'package:picnic_app/features/posts/post_overlay/post_overlay_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_extensions/widget_tester_extensions.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../feed_tests_utils.dart';
import '../mocks/posts_mocks.dart';

Future<void> main() async {
  late PostOverlayPage page;
  late PostOverlayInitialParams initParams;
  late PostOverlayPresentationModel model;
  late PostOverlayPresenter presenter;
  late PostOverlayNavigator navigator;

  void initMvp({
    PostDetailsMode postMode = PostDetailsMode.feed,
    CommentsMode commentsMode = CommentsMode.overlay,
    PostOverlaySize overlaySize = PostOverlaySize.fullscreen,
    bool showTimestamp = true,
  }) {
    reRegister<LogAnalyticsEventUseCase>(AnalyticsMocks.logAnalyticsEventUseCase);
    reRegister<UserStore>(Mocks.userStore);
    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);
    when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);
    mockCommentsPreview();
    when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);
    initParams = PostOverlayInitialParams(
      circleId: Stubs.circle.id,
      displayOptions: PostDisplayOptions(
        detailsMode: postMode,
        commentsMode: commentsMode,
        showPostSummaryBar: true,
        showPostCommentBar: true,
        overlaySize: overlaySize,
        showTimestamp: showTimestamp,
        showPostSummaryBarAbovePost: false,
      ),
      post: Stubs.imagePost,
      messenger: PostOverlayMediator(
        reportActionTaken: (_) {},
        postUpdated: (_) {},
      ),
      maxCommentsCount: null,
      reportId: Stubs.id,
    );
    model = PostOverlayPresentationModel.initial(
      initParams,
      Mocks.featureFlagsStore,
      Mocks.userStore,
    );
    navigator = PostOverlayNavigator(
      Mocks.appNavigator,
      Mocks.userStore,
    );
    presenter = PostOverlayPresenter(
      model,
      navigator,
      PostsMocks.likeUnlikePostUseCase,
      PostsMocks.likeUnlikeCommentUseCase,
      Mocks.savePostToCollectionUseCase,
      Mocks.followUserUseCase,
      Mocks.joinCircleUseCase,
      PostsMocks.getCommentsPreviewUseCase,
      PostsMocks.deleteCommentUseCase,
      PostsMocks.getPostUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
      Mocks.currentTimeProvider,
      Mocks.sharePostUseCase,
      PostsMocks.unreactToPostUseCase,
    );
    page = PostOverlayPage(presenter: presenter);
  }

  await screenshotTest(
    'post_overlay_page',
    variantName: 'mode_normal',
    setUp: () async {
      initMvp();
    },
    pageBuilder: () => _OverlayContainer(
      child: page,
    ),
  );

  await screenshotTest(
    'post_overlay_page',
    variantName: 'hide_timestamp',
    setUp: () async {
      initMvp(showTimestamp: false);
    },
    pageBuilder: () => _OverlayContainer(
      child: page,
    ),
  );

  await screenshotTest(
    'post_overlay_page',
    variantName: 'mode_normal_list',
    setUp: () async {
      initMvp(
        commentsMode: CommentsMode.list,
      );
    },
    pageBuilder: () => _OverlayContainer(
      child: page,
    ),
  );

  await screenshotTest(
    'post_overlay_page',
    variantName: 'mode_report',
    setUp: () async {
      initMvp(postMode: PostDetailsMode.report);
    },
    pageBuilder: () => _OverlayContainer(
      child: page,
    ),
  );

  testWidgets(
    'should measure post time',
    (widgetTester) async {
      initMvp();
      await widgetTester.setupWidget(
        Material(child: _OverlayContainer(child: page)),
      );
      await widgetTester.pumpAndSettle(const Duration(seconds: 1));
      await widgetTester.setupWidget(Container());
      await widgetTester.pumpAndSettle(const Duration(seconds: 1));

      final analyticsEvent =
          verify(() => AnalyticsMocks.logAnalyticsEventUseCase.execute(captureAny())).captured.first as AnalyticsEvent;
      expect(analyticsEvent.name, AnalyticsEventPostViewingTime.eventName);
    },
  );

  test('getIt page resolves successfully', () async {
    initMvp();
    final page = getIt<PostOverlayPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}

class _OverlayContainer extends StatelessWidget {
  const _OverlayContainer({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue.shade900,
      child: child,
    );
  }
}
