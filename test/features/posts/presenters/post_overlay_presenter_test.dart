import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/join_circle_failure.dart';
import 'package:picnic_app/core/domain/model/save_post_to_collection_failure.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/posts/domain/model/comments_mode.dart';
import 'package:picnic_app/features/posts/domain/model/like_unlike_post_failure.dart';
import 'package:picnic_app/features/posts/domain/model/post_details_mode.dart';
import 'package:picnic_app/features/posts/domain/model/post_overlay_size.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/domain/model/save_post_input.dart';
import 'package:picnic_app/features/posts/post_overlay/post_display_options.dart';
import 'package:picnic_app/features/posts/post_overlay/post_overlay_initial_params.dart';
import 'package:picnic_app/features/posts/post_overlay/post_overlay_mediator.dart';
import 'package:picnic_app/features/posts/post_overlay/post_overlay_presentation_model.dart';
import 'package:picnic_app/features/posts/post_overlay/post_overlay_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../mocks/posts_mock_definitions.dart';
import '../mocks/posts_mocks.dart';

void main() {
  late PostOverlayInitialParams initParams;
  late PostOverlayPresentationModel model;
  late PostOverlayPresenter presenter;
  late MockPostOverlayNavigator navigator;

  test(
    'liking post increments counter',
    () async {
      when(
        () => _likeUnlikeUseCaseExecuteMatch(),
      ).thenAnswer(
        (invocation) => successFuture(
          Stubs.imagePost.copyWith(
            iReacted: invocation.namedArguments[#like] as bool,
          ),
        ),
      );

      expect(presenter.state.post.likesCount, 0);
      await presenter.onTapHeart();
      expect(presenter.state.post.likesCount, 1);
      await presenter.onTapHeart();
      expect(presenter.state.post.likesCount, 0);
    },
  );

  test(
    'saved post increments counter',
    () async {
      when(
        () => _savedUnsavedUseCaseExecutionMatch(),
      ).thenAnswer(
        (invocation) => successFuture(
          Stubs.imagePost.copyWith(
            iSaved: (invocation.namedArguments[#input] as SavePostInput).save,
          ),
        ),
      );

      expect(presenter.state.post.savesCount, 0);
      await presenter.onTapBookmark();
      expect(presenter.state.post.savesCount, 1);
      await presenter.onTapBookmark();
      expect(presenter.state.post.savesCount, 0);
    },
  );

  test(
    'tapping report opens report post page',
    () async {
      when(() => navigator.openReportedContent(any())).thenAnswer((_) => Future.value());
      await presenter.onTapReportActions();
      verify(() => navigator.openReportedContent(any()));
    },
  );

  test(
    'liking should update UI instantly',
    () async {
      final completer = Completer<Either<LikeUnlikePostFailure, Post>>();
      when(() => _likeUnlikeUseCaseExecuteMatch()).thenAnswer((_) => completer.future);
      expect(presenter.state.post.iReacted, false);
      final future = presenter.onTapHeart();
      expect(presenter.state.post.iReacted, true);
      completer.complete(success(Stubs.imagePost.copyWith(iReacted: true)));
      await future;
      expect(presenter.state.post.iReacted, true);
    },
  );

  test(
    'joining should update UI instantly',
    () async {
      final completer = Completer<Either<JoinCircleFailure, Unit>>();
      when(() => _joinCircleUseCaseExecutionMatch()).thenAnswer((_) => completer.future);
      expect(presenter.state.post.circle.iJoined, false);
      final future = presenter.onJoinCircle();
      expect(presenter.state.post.circle.iJoined, true);
      completer.complete(success(unit));
      await future;
      expect(presenter.state.post.circle.iJoined, true);
    },
  );

  test(
    'failing to like should update UI with previous state',
    () async {
      final completer = Completer<Either<LikeUnlikePostFailure, Post>>();
      when(() => _likeUnlikeUseCaseExecuteMatch()).thenAnswer((_) => completer.future);
      expect(presenter.state.post.iReacted, false);
      final future = presenter.onTapHeart();
      expect(presenter.state.post.iReacted, true);
      completer.complete(failure(const LikeUnlikePostFailure.unknown()));
      await future;
      expect(presenter.state.post.iReacted, false);
      verifyNever(() => navigator.showError(any()));
    },
  );

  test(
    'should not call getPost in onInit',
    () async {
      // GIVEN

      // WHEN
      await presenter.onInit();

      verifyNever(() => PostsMocks.getPostUseCase.execute(postId: any(named: 'postId')));
    },
  );

  setUp(() {
    when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);
    when(() => PostsMocks.getCommentsPreviewUseCase.execute(postId: any(named: 'postId')))
        .thenSuccess((_) => Stubs.commentsPreview);
    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);
    initParams = PostOverlayInitialParams(
      circleId: Stubs.circle.id,
      displayOptions: const PostDisplayOptions(
        detailsMode: PostDetailsMode.feed,
        commentsMode: CommentsMode.overlay,
        showPostSummaryBar: true,
        overlaySize: PostOverlaySize.fullscreen,
        showPostCommentBar: true,
        showTimestamp: true,
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
    navigator = MockPostOverlayNavigator();
    presenter = PostOverlayPresenter(
      model,
      navigator,
      PostsMocks.likeUnlikePostUseCase,
      PostsMocks.likeUnlikeCommentUseCase,
      Mocks.savePostToCollectionUseCase,
      Mocks.followUserUseCase,
      Mocks.joinCircleUseCase,
      PostsMocks.getCommentsPreviewUseCase,
      PostsMocks.createCommentUseCase,
      PostsMocks.deleteCommentUseCase,
      PostsMocks.getPostUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
      Mocks.currentTimeProvider,
      Mocks.sharePostUseCase,
    );
  });
}

Future<Either<LikeUnlikePostFailure, Post>> _likeUnlikeUseCaseExecuteMatch() {
  return PostsMocks.likeUnlikePostUseCase.execute(
    id: any(named: 'id'),
    like: any(named: 'like'),
  );
}

Future<Either<SavePostToCollectionFailure, Post>> _savedUnsavedUseCaseExecutionMatch() {
  return Mocks.savePostToCollectionUseCase.execute(
    input: any(named: 'input'),
  );
}

Future<Either<JoinCircleFailure, Unit>> _joinCircleUseCaseExecutionMatch() {
  return Mocks.joinCircleUseCase.execute(
    circle: any(named: 'circle'),
  );
}
