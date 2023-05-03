import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/features/chat/add_members_list/add_members_list_initial_params.dart';
import 'package:picnic_app/features/chat/add_members_list/add_members_list_presentation_model.dart';
import 'package:picnic_app/features/chat/add_members_list/add_members_list_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/chat_mock_definitions.dart';

void main() {
  late AddMembersListPresentationModel model;
  late AddMembersListPresenter presenter;
  late MockAddMembersListNavigator navigator;

  setUp(() {
    model = AddMembersListPresentationModel.initial(
      AddMembersListInitialParams(
        onAddUser: (_) async {
          return true;
        },
      ),
    );
    navigator = MockAddMembersListNavigator();
    presenter = AddMembersListPresenter(
      model,
      navigator,
      Mocks.searchUsersUseCase,
      Mocks.debouncer,
    );
  });

  test(
    'tapping close should call close() from navigator',
    () {
      //GIVEN
      when(() => navigator.close()).thenAnswer((_) => unit);

      //WHEN
      presenter.onTapClose();

      //THEN
      verify(() => navigator.close()).called(1);
    },
  );

  test(
    'changing search text should call debouncer',
    () {
      //GIVEN
      const someUserSearchText = 'some user';
      when(
        () => Mocks.debouncer.debounce(
          const LongDuration(),
          any(),
        ),
      ).thenAnswer(
        (_) => unit,
      );

      //WHEN
      presenter.onSearchTextChanged(someUserSearchText);

      //THEN
      verify(
        () => Mocks.debouncer.debounce(
          const LongDuration(),
          any(),
        ),
      ).called(1);
    },
  );

  test(
    'loading more should call searchUsersUseCase execution',
    () async {
      //GIVEN
      when(
        () => Mocks.searchUsersUseCase.execute(
          query: any(named: 'query'),
          nextPageCursor: any(named: 'nextPageCursor'),
        ),
      ).thenAnswer(
        (_) => successFuture(PaginatedList.singlePage([Stubs.publicProfile])),
      );

      //WHEN
      await presenter.loadMore();

      //THEN
      verify(
        () => Mocks.searchUsersUseCase.execute(
          query: any(named: 'query'),
          nextPageCursor: any(named: 'nextPageCursor'),
        ),
      ).called(1);
    },
  );

  test(
    'onTapAdd should invert selectable user state',
    () async {
      //GIVEN
      when(
        () => Mocks.searchUsersUseCase.execute(
          query: any(named: 'query'),
          nextPageCursor: any(named: 'nextPageCursor'),
        ),
      ).thenAnswer(
        (_) => successFuture(PaginatedList.singlePage([Stubs.publicProfile])),
      );

      //WHEN
      await presenter.loadMore();
      await presenter.onTapAdd(Stubs.publicProfile);

      //THEN
      expect(presenter.state.users.first.selected, true);
    },
  );
}
