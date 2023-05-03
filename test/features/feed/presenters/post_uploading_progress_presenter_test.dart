import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/data/graphql/model/create_post_graphql_background_call.dart';
import 'package:picnic_app/core/utils/background_call.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/feed/post_uploading_progress/post_uploading_progress_initial_params.dart';
import 'package:picnic_app/features/feed/post_uploading_progress/post_uploading_progress_presentation_model.dart';
import 'package:picnic_app/features/feed/post_uploading_progress/post_uploading_progress_presenter.dart';
import 'package:picnic_app/features/posts/domain/model/create_post_failure.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../posts/mocks/posts_mock_definitions.dart';

void main() {
  late PostUploadingProgressInitialParams initParams;
  late PostUploadingProgressPresentationModel model;
  late MockPostUploadingProgressNavigator navigator;

  final statusInProgress = BackgroundCallStatusInProgress<Post, CreatePostFailure, Post>(
    id: const Id('statusInProgress'),
    entity: Stubs.textPost,
    percentage: 50,
  );

  final statusSuccess = BackgroundCallStatusSuccess<Post, CreatePostFailure, Post>(
    id: const Id('statusSuccess'),
    entity: Stubs.textPost,
    result: Stubs.textPost,
  );

  final statusFailed = BackgroundCallStatusFailed<Post, CreatePostFailure, Post>(
    id: const Id('statusFailed'),
    entity: Stubs.textPost,
    failure: const CreatePostFailure.unknown(),
  );

  PostUploadingProgressPresenter getPresenterWithInitialStream(
    BackgroundCallStatus<Post, CreatePostFailure, Post> status,
  ) {
    when(() => Mocks.backgroundApiRepository.getProgressStream<Post, CreatePostFailure, Post>()).thenAnswer(
      (_) => Stream<List<CreatePostBackgroundCallStatus>>.value([status]),
    );
    return PostUploadingProgressPresenter(
      model,
      navigator,
      Mocks.backgroundApiRepository,
      avoidTimers: true,
    );
  }

  test(
    'onTapItem for "in progress" item should do nothing',
    () {
      fakeAsync((async) {
        // GIVEN
        final presenter = getPresenterWithInitialStream(statusInProgress);
        async.flushMicrotasks();

        // WHEN
        presenter.onTapItem(statusInProgress);

        // THEN
        verifyNever(() => Mocks.backgroundApiRepository.restartBackgroundCall(id: any(named: 'id')));
        verifyNever(() => navigator.openAfterPostModal(any()));
        expect(presenter.state.statuses.length, 1);
      });
    },
  );

  test(
    'onTapItem for success item should open share screen and remove status from the list',
    () {
      fakeAsync((async) {
        // GIVEN
        when(() => navigator.openAfterPostModal(any())).thenAnswer((_) => Future.value());
        final presenter = getPresenterWithInitialStream(statusSuccess);
        async.flushMicrotasks();

        // WHEN
        presenter.onTapItem(statusSuccess);

        // THEN
        verify(() => navigator.openAfterPostModal(any()));
        expect(presenter.state.statuses.length, 0);
      });
    },
  );

  test(
    'onTapItem for failed item should restart background call',
    () {
      fakeAsync((async) {
        // GIVEN
        when(() => Mocks.backgroundApiRepository.restartBackgroundCall(id: any(named: 'id')))
            .thenAnswer((_) => Future.value());
        final presenter = getPresenterWithInitialStream(statusFailed);
        async.flushMicrotasks();

        // WHEN
        presenter.onTapItem(statusFailed);

        // THEN
        verify(
          () => Mocks.backgroundApiRepository.restartBackgroundCall(id: any(named: 'id')),
        );
        expect(presenter.state.statuses.length, 1);
      });
    },
  );

  test(
    'onTapClose for "in progress" item should do nothing',
    () {
      fakeAsync((async) {
        // GIVEN
        final presenter = getPresenterWithInitialStream(statusInProgress);
        async.flushMicrotasks();

        // WHEN
        presenter.onTapClose(statusInProgress);

        // THEN
        verifyNever(() => Mocks.backgroundApiRepository.removeBackgroundCall(id: any(named: 'id')));
        verifyNever(() => navigator.openAfterPostModal(any()));
        expect(presenter.state.statuses.length, 1);
      });
    },
  );

  test(
    'onTapClose for success item should hide call status',
    () {
      fakeAsync((async) {
        // GIVEN
        final presenter = getPresenterWithInitialStream(statusSuccess);
        async.flushMicrotasks();

        // WHEN
        presenter.onTapClose(statusSuccess);

        // THEN
        expect(presenter.state.statuses.length, 0);
      });
    },
  );

  test(
    'onTapClose for failed item should remove background call',
    () {
      fakeAsync((async) {
        // GIVEN
        when(() => Mocks.backgroundApiRepository.removeBackgroundCall(id: any(named: 'id')))
            .thenAnswer((_) => Future.value());
        final presenter = getPresenterWithInitialStream(statusFailed);
        async.flushMicrotasks();

        // WHEN
        presenter.onTapClose(statusFailed);

        // THEN
        verify(
          () => Mocks.backgroundApiRepository.removeBackgroundCall(id: any(named: 'id')),
        );
      });
    },
  );

  setUp(() {
    when(() => Mocks.backgroundApiRepository.getProgressStream<Post, CreatePostFailure, Post>()).thenAnswer(
      (_) => const Stream<List<CreatePostBackgroundCallStatus>>.empty(),
    );
    initParams = PostUploadingProgressInitialParams(
      onPostToBeShown: (_) {},
    );
    model = PostUploadingProgressPresentationModel.initial(
      initParams,
      Mocks.currentTimeProvider,
    );
    navigator = MockPostUploadingProgressNavigator();
  });
}
