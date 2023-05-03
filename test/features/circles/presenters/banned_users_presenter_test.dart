import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/circles/banned_users/banned_users_initial_params.dart';
import 'package:picnic_app/features/circles/banned_users/banned_users_presentation_model.dart';
import 'package:picnic_app/features/circles/banned_users/banned_users_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/circles_mock_definitions.dart';
import '../mocks/circles_mocks.dart';

void main() {
  late BannedUsersPresentationModel model;
  late BannedUsersPresenter presenter;
  late MockBannedUsersNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  test(
    'tapping unban should call the unban use case and remove the user from the banned list',
    () async {
      //GIVEN
      presenter.emit(
        model.copyWith(
          bannedUsers: PaginatedList.singlePage(
            [
              Stubs.temporaryBannedUser,
              Stubs.permanentBannedUser,
              Stubs.temporaryBannedUser2,
            ],
          ),
        ),
      );
      when(
        () => CirclesMocks.unbanUserUseCase.execute(
          circleId: Stubs.circle.id,
          userId: Stubs.temporaryBannedUser.userId,
        ),
      ).thenAnswer((_) => successFuture(Stubs.temporaryBannedUser.userId));

      //WHEN
      await presenter.onTapUnban(Stubs.temporaryBannedUser);

      //THEN
      verify(
        () => CirclesMocks.unbanUserUseCase.execute(
          circleId: Stubs.circle.id,
          userId: Stubs.temporaryBannedUser.userId,
        ),
      );
      expect(presenter.state.bannedUsers.items.length, 2);
      expect(presenter.state.bannedUsers.items[0], Stubs.permanentBannedUser);
      expect(presenter.state.bannedUsers.items[1], Stubs.temporaryBannedUser2);
    },
  );

  test(
    'tapping on a banned user should open their profile',
    () {
      //GIVEN
      when(() => navigator.openProfile(userId: Stubs.permanentBannedUser.userId)).thenAnswer((_) => Future.value());

      //WHEN
      presenter.onTapBannedUser(Stubs.permanentBannedUser);

      //THEN
      verify(() => navigator.openProfile(userId: Stubs.permanentBannedUser.userId));
    },
  );

  test(
    'loading more banned users should update the state by appending the new banned users list to existing',
    () async {
      //GIVEN
      presenter.emit(model.copyWith(bannedUsers: PaginatedList.singlePage([Stubs.temporaryBannedUser])));
      when(
        () => CirclesMocks.getBannedUsersUseCase.execute(
          circleId: Stubs.circle.id,
          cursor: const Cursor.firstPage(),
        ),
      ).thenAnswer(
        (invocation) => successFuture(
          PaginatedList.singlePage(
            [
              Stubs.permanentBannedUser,
              Stubs.temporaryBannedUser2,
            ],
          ),
        ),
      );

      //WHEN
      await presenter.onLoadMoreBannedUsers();

      //THEN
      expect(presenter.state.bannedUsers.items.length, 3);
      expect(presenter.state.bannedUsers.items[0], Stubs.temporaryBannedUser);
      expect(presenter.state.bannedUsers.items[1], Stubs.permanentBannedUser);
      expect(presenter.state.bannedUsers.items[2], Stubs.temporaryBannedUser2);
    },
  );

  setUp(() {
    model = BannedUsersPresentationModel.initial(
      BannedUsersInitialParams(circle: Stubs.circle),
      Mocks.currentTimeProvider,
    );
    navigator = MockBannedUsersNavigator();
    presenter = BannedUsersPresenter(
      model,
      navigator,
      CirclesMocks.unbanUserUseCase,
      CirclesMocks.getBannedUsersUseCase,
    );
  });
}
