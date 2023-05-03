import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/data/graphql/model/create_post_graphql_background_call.dart';
import 'package:picnic_app/core/utils/background_call.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/feed/post_uploading_progress/post_uploading_progress_initial_params.dart';
import 'package:picnic_app/features/feed/post_uploading_progress/post_uploading_progress_navigator.dart';
import 'package:picnic_app/features/feed/post_uploading_progress/post_uploading_progress_page.dart';
import 'package:picnic_app/features/feed/post_uploading_progress/post_uploading_progress_presentation_model.dart';
import 'package:picnic_app/features/feed/post_uploading_progress/post_uploading_progress_presenter.dart';
import 'package:picnic_app/features/posts/domain/model/create_post_failure.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';

Future<void> main() async {
  late PostUploadingProgressPage page;
  late PostUploadingProgressInitialParams initParams;
  late PostUploadingProgressPresentationModel model;
  late PostUploadingProgressPresenter presenter;
  late PostUploadingProgressNavigator navigator;

  void initMvp() {
    initParams = PostUploadingProgressInitialParams(
      onPostToBeShown: (_) {},
    );
    model = PostUploadingProgressPresentationModel.initial(
      initParams,
      Mocks.currentTimeProvider,
    );
    navigator = PostUploadingProgressNavigator(Mocks.appNavigator);
    presenter = PostUploadingProgressPresenter(
      model,
      navigator,
      Mocks.backgroundApiRepository,
      avoidTimers: true,
    );
    getIt.registerFactoryParam<PostUploadingProgressPresenter, PostUploadingProgressInitialParams, dynamic>(
      (initialParams, _) => presenter,
    );
    page = PostUploadingProgressPage(initialParams: initParams);
  }

  await screenshotTest(
    "post_uploading_progress_page",
    variantName: 'in_progress',
    setUp: () async {
      when(() => Mocks.backgroundApiRepository.getProgressStream<Post, CreatePostFailure, Post>()).thenAnswer(
        (_) => Stream<List<CreatePostBackgroundCallStatus>>.value(
          [
            BackgroundCallStatusInProgress(
              id: const Id.empty(),
              entity: Stubs.textPost,
              percentage: 50,
            ),
          ],
        ),
      );
      initMvp();
    },
    pageBuilder: () => page,
  );

  await screenshotTest(
    "post_uploading_progress_page",
    variantName: 'successful',
    setUp: () async {
      when(() => Mocks.backgroundApiRepository.getProgressStream<Post, CreatePostFailure, Post>()).thenAnswer(
        (_) => Stream<List<CreatePostBackgroundCallStatus>>.value(
          [
            BackgroundCallStatusSuccess(
              id: const Id.empty(),
              entity: Stubs.textPost,
              result: Stubs.textPost,
            ),
          ],
        ),
      );
      initMvp();
    },
    pageBuilder: () => page,
  );

  await screenshotTest(
    "post_uploading_progress_page",
    variantName: 'failed',
    setUp: () async {
      when(() => Mocks.backgroundApiRepository.getProgressStream<Post, CreatePostFailure, Post>()).thenAnswer(
        (_) => Stream<List<CreatePostBackgroundCallStatus>>.value(
          [
            BackgroundCallStatusFailed(
              id: const Id.empty(),
              entity: Stubs.textPost,
              failure: const CreatePostFailure.unknown(),
            ),
          ],
        ),
      );
      initMvp();
    },
    pageBuilder: () => page,
  );
}
