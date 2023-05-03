import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/domain/model/view_post_failure.dart';
import 'package:picnic_app/features/posts/single_feed/single_feed_initial_params.dart';
import 'package:picnic_app/features/posts/single_feed/single_feed_presentation_model.dart';
import 'package:picnic_app/features/posts/single_feed/single_feed_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/posts_mock_definitions.dart';

void main() {
  late SingleFeedPresenter presenter;
  late MockSingleFeedNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  void _initPresenter({
    PaginatedList<Post>? posts,
  }) {
    presenter = SingleFeedPresenter(
      SingleFeedPresentationModel.initial(
        SingleFeedInitialParams(
          initialIndex: 0,
          loadMore: () => successFuture(const PaginatedList.singlePage()),
          refresh: () => successFuture(const PaginatedList.singlePage()),
          onPostsListUpdated: (_) {},
          preloadedPosts: posts ?? Stubs.posts,
        ),
        Mocks.userStore,
      ),
      navigator,
      Mocks.deletePostsUseCase,
      Mocks.viewPostUseCase,
      Mocks.throttler,
    );
  }

  setUp(() {
    when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);

    navigator = MockSingleFeedNavigator();
    _initPresenter();
  });

  test('verify that view post is called when postDidAppear', () async {
    // GIVEN
    when(() => Mocks.viewPostUseCase.execute(postId: Stubs.imagePost.id)).thenAnswer((_) => successFuture(unit));

    // WHEN
    presenter.postDidAppear(Stubs.imagePost);

    // THEN
    verify(() => Mocks.viewPostUseCase.execute(postId: Stubs.imagePost.id));
  });

  test(
    'failing viewPostUseCase should not show error to the user',
    () async {
      // GIVEN
      when(() => Mocks.viewPostUseCase.execute(postId: Stubs.imagePost.id))
          .thenFailure((_) => const ViewPostFailure.unknown());

      // WHEN
      presenter.postDidAppear(Stubs.imagePost);

      // THEN
      verify(() => Mocks.viewPostUseCase.execute(postId: Stubs.imagePost.id));
      verifyNoMoreInteractions(navigator);
    },
  );

  test(
    'joining circle on 1 post should update cirlce joined status for all posts in this circle',
    () async {
      // GIVEN

      final circleA = Stubs.basicCircle.copyWith(
        id: const Id('cirlce-that-will-be-changed'),
        iJoined: false,
      );

      final circleB = Stubs.basicCircle.copyWith(
        id: const Id('cirlce-that-will-not-be-changed'),
        iJoined: false,
      );

      final postCircleA1 = Stubs.imagePost.copyWith(circle: circleA, id: const Id('postCircleA1'));
      final postCircleA2 = Stubs.imagePost.copyWith(circle: circleA, id: const Id('postCircleA2'));
      final postCircleB = Stubs.imagePost.copyWith(circle: circleB, id: const Id('postCircleB'));

      _initPresenter(posts: PaginatedList.singlePage([postCircleA1, postCircleA2, postCircleB]));

      final sourceCircleAJoinedStatus = circleA.iJoined;
      final sourceCircleBJoinedStatus = circleB.iJoined;
      final targetCircleAJoinedStatus = !sourceCircleAJoinedStatus;

      // WHEN
      presenter.onPostUpdated(
        postCircleA1.copyWith(
          circle: postCircleA1.circle.copyWith(
            iJoined: targetCircleAJoinedStatus,
          ),
        ),
      );

      // THEN
      expect(
        presenter.state.posts.firstWhere((p) => p.id == postCircleA1.id).circle.iJoined,
        targetCircleAJoinedStatus,
      );

      expect(
        presenter.state.posts.firstWhere((p) => p.id == postCircleA2.id).circle.iJoined,
        targetCircleAJoinedStatus,
      );

      expect(
        presenter.state.posts.firstWhere((p) => p.id == postCircleB.id).circle.iJoined,
        sourceCircleBJoinedStatus,
      );
    },
  );

  test(
    'following author on 1 post should update following author status for all posts from this author',
    () async {
      // GIVEN

      final authorA = Stubs.postAuthor.copyWith(
        id: const Id('cirlce-that-will-be-changed'),
        iFollow: false,
      );

      final authorB = Stubs.postAuthor.copyWith(
        id: const Id('cirlce-that-will-not-be-changed'),
        iFollow: false,
      );

      final postAuthorA1 = Stubs.imagePost.copyWith(author: authorA, id: const Id('postAuthorA1'));
      final postAuthorA2 = Stubs.imagePost.copyWith(author: authorA, id: const Id('postAuthorA2'));
      final postAuthorB = Stubs.imagePost.copyWith(author: authorB, id: const Id('postAuthorB'));

      _initPresenter(posts: PaginatedList.singlePage([postAuthorA1, postAuthorA2, postAuthorB]));

      final sourceAuthorAFollowStatus = authorA.iFollow;
      final sourceAuthorBFollowStatus = authorB.iFollow;
      final targetAuthorAFollowStatus = !sourceAuthorAFollowStatus;

      // WHEN
      presenter.onPostUpdated(
        postAuthorA1.copyWith(
          author: postAuthorA1.author.copyWith(
            iFollow: targetAuthorAFollowStatus,
          ),
        ),
      );
      // THEN
      expect(
        presenter.state.posts.firstWhere((p) => p.id == postAuthorA1.id).author.iFollow,
        targetAuthorAFollowStatus,
      );

      expect(
        presenter.state.posts.firstWhere((p) => p.id == postAuthorA2.id).author.iFollow,
        targetAuthorAFollowStatus,
      );

      expect(
        presenter.state.posts.firstWhere((p) => p.id == postAuthorB.id).author.iFollow,
        sourceAuthorBFollowStatus,
      );
    },
  );
}
