import 'package:dartz/dartz.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/follow_unfollow_user_failure.dart';
import 'package:picnic_app/core/domain/model/page_info.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/profile/followers/followers_initial_params.dart';
import 'package:picnic_app/features/profile/followers/followers_presentation_model.dart';
import 'package:picnic_app/features/profile/followers/followers_presenter.dart';

import '../../../mocks/mock_definitions.dart';
import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/profile_mock_definitions.dart';
import '../mocks/profile_mocks.dart';

void main() {
  late FollowersPresentationModel model;
  late FollowersPresenter presenter;
  late MockFollowersNavigator navigator;
  late MockFollowUserUseCase useCase;

  test(
    'verify that a tap on a follower opens the profile',
    () {
      //GIVEN
      when(() => navigator.openProfile(userId: Stubs.publicProfile.id)).thenAnswer((_) => Future.value());

      //WHEN
      presenter.onTapViewUserProfile(Stubs.publicProfile.id);

      //THEN
      verify(() => navigator.openProfile(userId: Stubs.publicProfile.id));
    },
  );

  test(
    'tapping on follow toggle should follow a user',
    () async {
      fakeAsync((async) {
        // GIVEN
        final user = Stubs.publicProfile.copyWith(iFollow: false);
        when(() => presenter.onTapToggleFollow(user)).thenAnswer(
          (_) => successFuture(unit),
        );
        when(() => useCase.execute(userId: user.id, follow: true)).thenAnswer(
          (_) => successFuture(unit),
        );

        // WHEN
        presenter.onTapToggleFollow(user);
        async.flushMicrotasks();

        // THEN
        verify(() => useCase.execute(userId: user.id, follow: true)).called(1);
        expect(presenter.state.followers.items.firstWhere((element) => element.id == user.id).iFollow, true);
      });
    },
  );

  test(
    'tapping on follow toggle should fail to follow a user',
    () async {
      fakeAsync((async) {
        // GIVEN
        final user = Stubs.publicProfile.copyWith(iFollow: false);
        when(() => presenter.onTapToggleFollow(user)).thenAnswer(
          (_) => failFuture(navigator.showError(any())),
        );
        when(() => navigator.showError(any())).thenAnswer((_) => Future.value());
        when(() => useCase.execute(userId: user.id, follow: true)).thenAnswer(
          (_) => failFuture(const FollowUnfollowUserFailure.unknown()),
        );

        // WHEN
        presenter.onTapToggleFollow(user);
        async.flushMicrotasks();

        // THEN
        verify(() => useCase.execute(userId: user.id, follow: true)).called(1);
        verify(() => navigator.showError(any())).called(1);
        expect(presenter.state.followers.items.firstWhere((element) => element.id == user.id).iFollow, false);
      });
    },
  );

  test(
    'tapping on follow toggle should unfollow a user',
    () async {
      fakeAsync((async) {
        // GIVEN
        final user = Stubs.publicProfile2.copyWith(iFollow: true);
        when(() => presenter.onTapToggleFollow(user)).thenAnswer(
          (_) => successFuture(unit),
        );
        when(() => useCase.execute(userId: user.id, follow: false)).thenAnswer(
          (_) => successFuture(unit),
        );

        // WHEN
        presenter.onTapToggleFollow(user);
        async.flushMicrotasks();

        // THEN
        verify(() => useCase.execute(userId: user.id, follow: false)).called(1);
        expect(presenter.state.followers.items.firstWhere((element) => element.id == user.id).iFollow, false);
      });
    },
  );

  test(
    'tapping on follow toggle should fail to unfollow a user',
    () async {
      fakeAsync((async) {
        // GIVEN
        final user = Stubs.publicProfile2.copyWith(iFollow: true);
        when(() => presenter.onTapToggleFollow(user)).thenAnswer(
          (_) => failFuture(navigator.showError(any())),
        );
        when(() => navigator.showError(any())).thenAnswer((_) => Future.value());
        when(() => useCase.execute(userId: user.id, follow: false)).thenAnswer(
          (_) => failFuture(const FollowUnfollowUserFailure.unknown()),
        );

        // WHEN
        presenter.onTapToggleFollow(user);
        async.flushMicrotasks();

        // THEN
        verify(() => useCase.execute(userId: user.id, follow: false)).called(1);
        verify(() => navigator.showError(any())).called(1);
        expect(presenter.state.followers.items.firstWhere((element) => element.id == user.id).iFollow, true);
      });
    },
  );

  setUp(() {
    when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);

    model = FollowersPresentationModel.initial(
      const FollowersInitialParams(),
      Mocks.userStore,
    ).copyWith(
      followers: PaginatedList(
        pageInfo: const PageInfo.empty(),
        items: [
          Stubs.publicProfile,
          Stubs.publicProfile.copyWith(user: Stubs.user2, iFollow: true),
        ],
      ),
    );
    navigator = MockFollowersNavigator();
    useCase = Mocks.followUserUseCase;
    presenter = FollowersPresenter(
      model,
      navigator,
      ProfileMocks.getFollowersUseCase,
      useCase,
      Mocks.debouncer,
    );
  });
}
