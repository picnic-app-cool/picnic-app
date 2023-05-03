import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/features/circles/ban_user_list/ban_user_list_initial_params.dart';
import 'package:picnic_app/features/circles/ban_user_list/ban_user_list_presentation_model.dart';
import 'package:picnic_app/features/circles/ban_user_list/ban_user_list_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/circles_mock_definitions.dart';
import '../mocks/circles_mocks.dart';

void main() {
  late BanUserListPresentationModel model;
  late BanUserListPresenter presenter;
  late MockBanUserListNavigator navigator;

  test(
    'tapping on an user should open the profile',
    () {
      //GIVEN
      when(() => navigator.openProfile(userId: Stubs.publicProfile.id)).thenAnswer((_) => Future.value());

      //WHEN
      presenter.onTapUser(Stubs.publicProfile);

      //THEN
      verify(() => navigator.openProfile(userId: Stubs.publicProfile.id));
    },
  );

  setUp(() {
    model = BanUserListPresentationModel.initial(
      BanUserListInitialParams(circle: Stubs.circle),
    );
    navigator = MockBanUserListNavigator();
    presenter = BanUserListPresenter(
      model,
      navigator,
      CirclesMocks.banUserUseCase,
      Mocks.searchUsersUseCase,
      Mocks.debouncer,
    );

    when(
      () => navigator.openBanUser(any()),
    ).thenAnswer((invocation) => Future.value(true));

    when(
      () => Mocks.searchUsersUseCase.execute(
        query: any(named: 'query'),
        nextPageCursor: any(named: 'nextPageCursor'),
        ignoreMyself: any(named: 'ignoreMyself'),
      ),
    ).thenAnswer(
      (_) => successFuture(
        PaginatedList.singlePage(
          [
            Stubs.publicProfile,
            Stubs.publicProfile2,
          ],
        ),
      ),
    );

    when(
      () => CirclesMocks.banUserUseCase.execute(
        userId: Stubs.publicProfile.user.id,
        circleId: Stubs.circle.id,
      ),
    ).thenAnswer(
      (invocation) => successFuture(
        Stubs.publicProfile.user.id,
      ),
    );
  });

  test('on searching changed should fetch circle members from scratch', () async {
    const query = 'Test query';
    when(() => Mocks.debouncer.debounce(const LongDuration(), any())).thenAnswer((invocation) async {
      final callback = invocation.positionalArguments[1] as dynamic Function();
      await callback();
    });
    when(
      () => Mocks.searchUsersUseCase.execute(
        query: any(named: 'query'),
        nextPageCursor: any(named: 'nextPageCursor'),
        ignoreMyself: any(named: 'ignoreMyself'),
      ),
    ).thenAnswer(
      (_) => successFuture(
        PaginatedList.singlePage([
          Stubs.publicProfile,
          Stubs.publicProfile2,
        ]),
      ),
    );

    //WHEN
    presenter.onSearchTextChanged(query);

    //THEN
    verify(() => Mocks.debouncer.debounce(const LongDuration(), any()));

    verify(
      () => Mocks.searchUsersUseCase.execute(
        query: query,
        nextPageCursor: const Cursor.firstPage(),
        ignoreMyself: true,
      ),
    );
  });

  test('tapping close should close the navigator', () {
    //WHEN
    presenter.onTapClose();

    //THEN
    verify(() => navigator.close()).called(1);
  });

  test(
    'loading more should call non members use case and update the state by appending the new users list to the state ',
    () async {
      presenter.emit(model.copyWith(usersList: PaginatedList.singlePage([Stubs.publicProfile])));
      // GIVEN
      when(
        () => Mocks.searchUsersUseCase.execute(
          query: any(named: 'query'),
          nextPageCursor: any(named: 'nextPageCursor'),
          ignoreMyself: any(named: 'ignoreMyself'),
        ),
      ).thenAnswer(
        (_) => successFuture(
          PaginatedList.singlePage([
            Stubs.publicProfile,
            Stubs.publicProfile2,
          ]),
        ),
      );

      // WHEN
      await presenter.loadMore();

      // THEN
      verify(
        () => Mocks.searchUsersUseCase.execute(
          query: any(named: 'query'),
          nextPageCursor: any(named: 'nextPageCursor'),
          ignoreMyself: any(named: 'ignoreMyself'),
        ),
      );

      expect(presenter.state.usersList.items.length, 3);
      expect(presenter.state.usersList.items[1], Stubs.publicProfile);
      expect(presenter.state.usersList.items[2], Stubs.publicProfile2);
    },
  );

  test('tapping to ban a user should  call the ban use case and remove the user from the list', () async {
    await presenter.onTapBan(Stubs.publicProfile);
    verify(
      () => CirclesMocks.banUserUseCase.execute(circleId: Stubs.circle.id, userId: Stubs.publicProfile.user.id),
    );
    expect(presenter.state.usersList.items.length, 0);
  });
}
