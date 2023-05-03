import 'package:dartz/dartz.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/circles/members/members_initial_params.dart';
import 'package:picnic_app/features/circles/members/members_presentation_model.dart';
import 'package:picnic_app/features/circles/members/members_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/circles_mock_definitions.dart';
import '../mocks/circles_mocks.dart';

void main() {
  late MembersPresentationModel model;
  late MembersPresenter presenter;
  late MockMembersNavigator navigator;

  test(
    "onLoad should call get members by role useCase",
    () async {
      // WHEN
      await presenter.onLoadMoreMembers();

      // THEN
      verify(
        () => CirclesMocks.getCircleMembersByRoleUseCase.execute(
          circleId: any(named: 'circleId'),
          cursor: any(named: 'cursor'),
          roles: any(named: 'roles'),
          searchQuery: model.searchQuery,
        ),
      );
    },
  );

  test(
    'tapping on follow should call followUnfollowUseCase',
    () async {
      await presenter.onLoadMoreMembers();
      // WHEN
      presenter.onTapToggleFollow(Stubs.circleMemberDirector);

      // THEN
      verify(() => Mocks.followUserUseCase.execute(userId: any(named: 'userId'), follow: true));
    },
  );

  test(
    'tapping on user profile should open ProfilePage',
    () async {
      fakeAsync((async) {
        when(() => navigator.openProfile(userId: Stubs.user.id)).thenAnswer((invocation) {
          return Future.value();
        });
        presenter.onTapViewUserProfile(
          Stubs.circleMemberDirector.copyWith(user: Stubs.publicProfile.copyWith(user: Stubs.user)),
        );

        // THEN
        verify(() => navigator.openProfile(userId: Stubs.user.id));
      });

      // WHEN
    },
  );

  test(
    'tapping on add should open CircleRolePage',
    () {
      //GIVEN
      when(() => navigator.openCircleRole(any())).thenAnswer((_) {
        return Future.value();
      });
      // WHEN
      presenter.onTapAddRole();

      // THEN
      verify(
        () => navigator.openCircleRole(any()),
      );
    },
  );

  setUp(() {
    when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);
    when(
      () => CirclesMocks.getCircleMembersByRoleUseCase.execute(
        circleId: any(named: 'circleId'),
        cursor: any(named: 'cursor'),
        roles: any(named: 'roles'),
      ),
    ).thenAnswer(
      (_) => successFuture(PaginatedList.singlePage([Stubs.circleMemberDirector, Stubs.circleMemberDirector])),
    );

    when(
      () => Mocks.followUserUseCase.execute(
        userId: any(named: 'userId'),
        follow: true,
      ),
    ).thenAnswer((_) => successFuture(unit));
    when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);
    when(() => Mocks.featureFlagsStore.featureFlags).thenReturn(Stubs.featureFlags);
    model = MembersPresentationModel.initial(const MembersInitialParams(), Mocks.userStore, Mocks.featureFlagsStore);
    navigator = MockMembersNavigator();
    presenter = MembersPresenter(
      model,
      navigator,
      Mocks.followUserUseCase,
      CirclesMocks.getCircleMembersByRoleUseCase,
      Mocks.clipboardManager,
      Mocks.debouncer,
    );
  });
}
