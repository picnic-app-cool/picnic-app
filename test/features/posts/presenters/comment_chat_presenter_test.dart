import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/posts/comment_chat/comment_chat_initial_params.dart';
import 'package:picnic_app/features/posts/comment_chat/comment_chat_presentation_model.dart';
import 'package:picnic_app/features/posts/comment_chat/comment_chat_presenter.dart';
import 'package:picnic_app/features/posts/domain/model/get_comments_failure.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/domain/model/save_post_input.dart';
import 'package:picnic_app/features/posts/domain/model/tree_comment.dart';
import 'package:picnic_app/utils/extensions/tree_extension.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../mocks/posts_mock_definitions.dart';
import '../mocks/posts_mocks.dart';

void main() {
  late CommentChatPresentationModel model;
  late CommentChatPresenter presenter;
  late MockCommentChatNavigator navigator;

  test(
    'should call getCommentsUseCase with correct postId on start',
    () async {
      // GIVEN
      final post = model.feedPost;
      when(() => PostsMocks.getCommentsUseCase.execute(post: post))
          .thenAnswer((_) => successFuture(const TreeComment.root(children: PaginatedList.empty())));
      when(() => PostsMocks.getPinnedCommentsUseCase.execute(post: post)).thenAnswer((_) => successFuture([]));
      expect(presenter, isNotNull);

      // WHEN
      await presenter.onInit();

      // THEN
      verify(() => PostsMocks.getCommentsUseCase.execute(post: post));
    },
  );

  test(
    'should call savePostToCollectionUseCase with correct input on onTapBookmark',
    () async {
      // GIVEN
      final postId = model.feedPost.id;
      final input = SavePostInput(
        postId: postId,
        save: true,
      );
      when(() => Mocks.savePostToCollectionUseCase.execute(input: input))
          .thenAnswer((_) => successFuture(Stubs.textPost));
      expect(presenter, isNotNull);

      // WHEN
      presenter.onTapBookmark();

      // THEN
      verify(() => Mocks.savePostToCollectionUseCase.execute(input: input));
    },
  );

  test(
    'should show error when getCommentsUseCase fails',
    () async {
      // GIVEN
      final post = model.feedPost;
      when(() => PostsMocks.getCommentsUseCase.execute(post: post))
          .thenAnswer((_) => failFuture(const GetCommentsFailure.unknown()));
      when(() => PostsMocks.getPinnedCommentsUseCase.execute(post: post)).thenAnswer((_) => successFuture([]));
      when(() => navigator.showError(any())).thenAnswer((_) => Future.value());

      // WHEN
      await presenter.onInit();

      // THEN
      verify(() => navigator.showError(any()));
    },
  );

  test(
    'long press should show action bottom sheet',
    () async {
      // GIVEN
      final comment = Stubs.comments;

      // WHEN
      presenter.onLongPress(Stubs.comments);

      // THEN
      verify(
        () => navigator.showCommentActionBottomSheet(
          comment: comment,
          onTapClose: any(named: 'onTapClose'),
          onTapReport: any(named: 'onTapReport'),
          onTapLike: any(named: 'onTapLike'),
          onTapReply: any(named: 'onTapReply'),
          onTapDelete: any(named: 'onTapDelete'),
          onTapPin: any(named: 'onTapPin'),
          onTapUnpin: any(named: 'onTapUnpin'),
          onTapShare: any(named: 'onTapShare'),
        ),
      );
    },
  );

  test('onPinComment should call pinCommentUseCase', () async {
    // GIVEN
    final comment = Stubs.comments;
    final commentToBePinned = comment.children[1];
    when(() => PostsMocks.pinCommentUseCase.execute(commentId: commentToBePinned.id))
        .thenAnswer((_) => successFuture(unit));

    // WHEN
    await presenter.onPinComment(commentToBePinned);

    // THEN
    verify(() => PostsMocks.pinCommentUseCase.execute(commentId: commentToBePinned.id));
    expect(presenter.state.rootComment.children[0].id, commentToBePinned.id);
  });

  test('onUnpinComment should call unpinCommentUseCase', () async {
    // GIVEN
    final comment = Stubs.comments;
    final commentToBeUnpinned = Stubs.pinnedComment;
    when(() => PostsMocks.getPinnedCommentsUseCase.execute(post: any(named: 'post')))
        .thenAnswer((_) => successFuture([]));
    when(() => PostsMocks.unpinCommentUseCase.execute(commentId: commentToBeUnpinned.id))
        .thenAnswer((_) => successFuture(unit));
    when(() => PostsMocks.getCommentsUseCase.execute(post: any(named: 'post')))
        .thenAnswer((_) => successFuture(Stubs.comments.normalizeConnections()));

    // WHEN
    presenter.emit(
      model.copyWith(
        commentsRoot: comment,
        pinnedComments: [commentToBeUnpinned],
      ),
    );

    expect(presenter.state.rootComment.children[0].isPinned, true);
    expect(presenter.state.rootComment.children[0].id, commentToBeUnpinned.id);

    await presenter.onUnpinComment(commentToBeUnpinned);

    // THEN
    verify(() => PostsMocks.unpinCommentUseCase.execute(commentId: commentToBeUnpinned.id));
    expect(presenter.state.rootComment.children.items.none((item) => item.isPinned), true);
  });

  test(
    'like and unlike should refresh comments tree',
    () async {
      // GIVEN
      when(
        () => PostsMocks.likeUnlikeCommentUseCase.execute(
          commentId: any(named: 'commentId'),
          like: any(named: 'like'),
        ),
      ).thenAnswer((_) => successFuture(unit));

      when(() => PostsMocks.getCommentsUseCase.execute(post: any(named: 'post')))
          .thenAnswer((_) => successFuture(Stubs.comments.normalizeConnections()));

      await presenter.onInit();

      expect(presenter.state.rootComment, Stubs.comments.normalizeConnections());

      presenter.onTapLikeUnlike(presenter.state.rootComment.children[0].children[0]);
      await untilCalled(
        () => PostsMocks.likeUnlikeCommentUseCase.execute(
          commentId: any(named: 'commentId'),
          like: true,
        ),
      );

      presenter.onTapLikeUnlike(presenter.state.rootComment.children[0].children[0].children[0]);
      await untilCalled(
        () => PostsMocks.likeUnlikeCommentUseCase.execute(
          commentId: any(named: 'commentId'),
          like: false,
        ),
      );
    },
  );

  test(
    'tapping on + should call followUserUseCase and iFollow should be set to true',
    () async {
      // GIVEN
      when(() => Mocks.followUserUseCase.execute(userId: any(named: 'userId'), follow: true)).thenAnswer((_) {
        return successFuture(unit);
      });

      // WHEN
      presenter.onTapFollow();

      // THEN
      verify(
        () => Mocks.followUserUseCase.execute(userId: any(named: 'userId'), follow: true),
      ).called(1);
      expect(presenter.state.feedPost.author.iFollow, true);
    },
  );

  setUp(() {
    when(() => Mocks.userStore.privateProfile).thenAnswer((_) => Stubs.privateProfile);
    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);
    model = CommentChatPresentationModel.initial(
      CommentChatInitialParams(
        post: Stubs.textPost,
      ),
      Mocks.featureFlagsStore,
      Mocks.userStore,
    );
    navigator = MockCommentChatNavigator();
    presenter = CommentChatPresenter(
      model,
      navigator,
      PostsMocks.likeUnlikeCommentUseCase,
      PostsMocks.getCommentsUseCase,
      PostsMocks.createCommentUseCase,
      PostsMocks.deleteCommentUseCase,
      PostsMocks.getPinnedCommentsUseCase,
      PostsMocks.pinCommentUseCase,
      PostsMocks.unpinCommentUseCase,
      Mocks.joinCircleUseCase,
      Mocks.savePostToCollectionUseCase,
      PostsMocks.voteInPollUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
      Mocks.followUserUseCase,
      Mocks.userStore,
    );
    registerFallbackValue(const Post.empty());
  });
}
