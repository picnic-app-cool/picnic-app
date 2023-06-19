import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/join_circle_failure.dart';
import 'package:picnic_app/core/domain/model/save_post_to_collection_failure.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/posts/domain/model/comments_mode.dart';
import 'package:picnic_app/features/posts/domain/model/like_dislike_reaction.dart';
import 'package:picnic_app/features/posts/domain/model/like_unlike_post_failure.dart';
import 'package:picnic_app/features/posts/domain/model/post_details_mode.dart';
import 'package:picnic_app/features/posts/domain/model/post_overlay_size.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/domain/model/save_post_input.dart';
import 'package:picnic_app/features/posts/domain/model/unreact_to_post_failure.dart';
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
        () => _likeDislikeUseCaseExecuteMatch(),
      ).thenAnswer(
        (invocation) {
          final reaction = invocation.namedArguments[#likeDislikeReaction] as LikeDislikeReaction;
          return successFuture(
            Stubs.imagePost.copyWith(
              context: Stubs.imagePost.context.copyWith(
                reaction: reaction,
              ),
            ),
          );
        },
      );

      when(
        () => _unReactToPostUseCaseMatch(),
      ).thenAnswer(
        (invocation) {
          return successFuture(
            Stubs.imagePost.copyWith(
              context: Stubs.imagePost.context.copyWith(
                reaction: LikeDislikeReaction.noReaction,
              ),
            ),
          );
        },
      );

      expect(presenter.state.post.contentStats.likes, 0);
      await presenter.onTapLikePost();
      expect(presenter.state.post.contentStats.likes, 1);
      await presenter.onTapLikePost();
      expect(presenter.state.post.contentStats.likes, 0);
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
            context: Stubs.imagePost.context.copyWith(saved: (invocation.namedArguments[#input] as SavePostInput).save),
          ),
        ),
      );

      expect(presenter.state.post.contentStats.saves, 0);
      await presenter.onTapBookmark();
      expect(presenter.state.post.contentStats.saves, 1);
      await presenter.onTapBookmark();
      expect(presenter.state.post.contentStats.saves, 0);
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
      final unReactCompleter = Completer<Either<UnreactToPostFailure, Post>>();
      when(() => _likeDislikeUseCaseExecuteMatch()).thenAnswer((_) => completer.future);
      when(() => _unReactToPostUseCaseMatch()).thenAnswer((_) => unReactCompleter.future);

      expect(presenter.state.post.context.reaction, LikeDislikeReaction.noReaction);
      final future = presenter.onTapLikePost();
      expect(presenter.state.post.context.reaction, LikeDislikeReaction.like);
      completer.complete(
        success(
          Stubs.imagePost.copyWith(context: Stubs.imagePost.context.copyWith(reaction: LikeDislikeReaction.like)),
        ),
      );
      await future;
      expect(presenter.state.post.context.reaction, LikeDislikeReaction.like);
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
      final unReactCompleter = Completer<Either<UnreactToPostFailure, Post>>();
      when(() => _likeDislikeUseCaseExecuteMatch()).thenAnswer((_) => completer.future);
      when(() => _unReactToPostUseCaseMatch()).thenAnswer((_) => unReactCompleter.future);
      expect(presenter.state.post.context.reaction, LikeDislikeReaction.noReaction);
      final future = presenter.onTapLikePost();
      expect(presenter.state.post.context.reaction, LikeDislikeReaction.like);
      completer.complete(failure(const LikeUnlikePostFailure.unknown()));
      await future;
      expect(presenter.state.post.context.reaction, LikeDislikeReaction.noReaction);
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
    registerFallbackValue(LikeDislikeReaction.like);
    registerFallbackValue(LikeDislikeReaction.dislike);
    registerFallbackValue(LikeDislikeReaction.noReaction);
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
      PostsMocks.deleteCommentUseCase,
      PostsMocks.getPostUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
      Mocks.currentTimeProvider,
      Mocks.sharePostUseCase,
      PostsMocks.unreactToPostUseCase,
      PostsMocks.unreactToCommentUseCase,
    );
  });
}

Future<Either<LikeUnlikePostFailure, Post>> _likeDislikeUseCaseExecuteMatch() {
  return PostsMocks.likeUnlikePostUseCase.execute(
    id: any(named: 'id'),
    likeDislikeReaction: any(named: 'likeDislikeReaction'),
  );
}

Future<Either<UnreactToPostFailure, Post>> _unReactToPostUseCaseMatch() {
  return PostsMocks.unreactToPostUseCase.execute(
    postId: any(named: 'postId'),
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
