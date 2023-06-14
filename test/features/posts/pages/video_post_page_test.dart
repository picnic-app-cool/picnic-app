import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/stores/feature_flags_store.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/analytics/domain/use_cases/log_analytics_event_use_case.dart';
import 'package:picnic_app/features/posts/domain/use_cases/get_comments_preview_use_case.dart';
import 'package:picnic_app/features/posts/video_post/video_post_initial_params.dart';
import 'package:picnic_app/features/posts/video_post/video_post_navigator.dart';
import 'package:picnic_app/features/posts/video_post/video_post_page.dart';
import 'package:picnic_app/features/posts/video_post/video_post_presentation_model.dart';
import 'package:picnic_app/features/posts/video_post/video_post_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../mocks/posts_mocks.dart';

Future<void> main() async {
  late VideoPostPage page;
  late VideoPostInitialParams initParams;
  late VideoPostPresentationModel model;
  late VideoPostPresenter presenter;
  late VideoPostNavigator navigator;

  Future<void> _initMvp() async {
    reRegister<FeatureFlagsStore>(Mocks.featureFlagsStore);
    reRegister<LogAnalyticsEventUseCase>(AnalyticsMocks.logAnalyticsEventUseCase);
    reRegister<UserStore>(Mocks.userStore);
    when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);
    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);
    when(() => Mocks.videoMuteStore.muted).thenReturn(false);
    getIt.registerFactory<GetCommentsPreviewUseCase>(() => PostsMocks.getCommentsPreviewUseCase);
    when(
      () => PostsMocks.getCommentsPreviewUseCase.execute(
        postId: any(named: 'postId'),
        count: any(named: 'count'),
      ),
    ).thenAnswer((_) => successFuture([]));

    whenListen(
      Mocks.videoMuteStore,
      Stream.fromIterable([false]),
    );

    initParams = VideoPostInitialParams(
      post: Stubs.videoPost,
      reportId: Stubs.id,
    );
    model = VideoPostPresentationModel.initial(
      initParams,
    );
    navigator = VideoPostNavigator(Mocks.appNavigator);
    presenter = VideoPostPresenter(
      model,
      navigator,
      Mocks.videoMuteStore,
      Mocks.currentTimeProvider,
    );

    getIt.registerFactoryParam<VideoPostPresenter, VideoPostInitialParams, dynamic>(
      (initialParams, _) => presenter,
    );
    page = VideoPostPage(initialParams: initParams);
  }

  await screenshotTest(
    "video_post_page",
    setUp: () async {
      await _initMvp();
    },
    pageBuilder: () => page,
  );
}
