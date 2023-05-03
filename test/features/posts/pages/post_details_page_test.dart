import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/stores/feature_flags_store.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/analytics/domain/use_cases/log_analytics_event_use_case.dart';
import 'package:picnic_app/features/posts/post_details/post_details_initial_params.dart';
import 'package:picnic_app/features/posts/post_details/post_details_navigator.dart';
import 'package:picnic_app/features/posts/post_details/post_details_page.dart';
import 'package:picnic_app/features/posts/post_details/post_details_presentation_model.dart';
import 'package:picnic_app/features/posts/post_details/post_details_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../feed_tests_utils.dart';
import '../mocks/posts_mocks.dart';

Future<void> main() async {
  late PostDetailsPage page;
  late PostDetailsInitialParams initParams;
  late PostDetailsPresentationModel model;
  late PostDetailsPresenter presenter;
  late PostDetailsNavigator navigator;

  void _initMvp() {
    reRegister<LogAnalyticsEventUseCase>(AnalyticsMocks.logAnalyticsEventUseCase);
    reRegister<UserStore>(Mocks.userStore);
    when(() => PostsMocks.postsRepository.viewPost(postId: any(named: 'postId')))
        .thenAnswer((_) => successFuture(unit));
    when(() => Mocks.viewPostUseCase.execute(postId: any(named: 'postId'))).thenAnswer((_) => successFuture(unit));
    reRegister<FeatureFlagsStore>(Mocks.featureFlagsStore);
    mockCommentsPreview();
    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);
    when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);
    whenListen(
      Mocks.userStore,
      Stream.fromIterable([Stubs.privateProfile]),
    );
    initParams = PostDetailsInitialParams(post: Stubs.imagePost);
    model = PostDetailsPresentationModel.initial(
      initParams,
      Mocks.userStore,
    );

    navigator = PostDetailsNavigator(Mocks.appNavigator);
    presenter = PostDetailsPresenter(
      model,
      navigator,
      Mocks.deletePostsUseCase,
      Mocks.viewPostUseCase,
      Mocks.userStore,
      PostsMocks.getPostUseCase,
    );

    page = PostDetailsPage(presenter: presenter);
  }

  await screenshotTest(
    "post_details_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<PostDetailsPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
