import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/chat/domain/model/invite_users_to_circle_input.dart';
import 'package:picnic_app/features/circles/invite_user_list/invite_user_list_initial_params.dart';
import 'package:picnic_app/features/circles/invite_user_list/invite_user_list_presentation_model.dart';
import 'package:picnic_app/features/circles/invite_user_list/invite_user_list_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/circles_mock_definitions.dart';
import '../mocks/circles_mocks.dart';

void main() {
  late InviteUserListPresentationModel model;
  late InviteUserListPresenter presenter;
  late MockInviteUserListNavigator navigator;
  late MockInviteUserToCircleUseCase useCase;
  late MockSearchNonMemberUsersUseCase searchUseCase;

  final user = Stubs.publicProfile;
  final input = InviteUsersToCircleInput(
    circleId: Stubs.circle.id,
    userIds: [user.id],
  );

  setUp(() {
    model = InviteUserListPresentationModel.initial(InviteUserListInitialParams(circleId: Stubs.circle.id));
    navigator = MockInviteUserListNavigator();
    useCase = CirclesMocks.inviteUserToCircleUseCase;
    searchUseCase = CirclesMocks.searchNonMemberUsersUseCase;
    presenter = InviteUserListPresenter(
      model,
      navigator,
      useCase,
      searchUseCase,
      Mocks.debouncer,
    );
  });

  test(
    'onTapInvite should invert selectable user state',
    () async {
      fakeAsync((async) {
        // GIVEN
        when(() => useCase.execute(input: input)).thenAnswer((_) => successFuture(Stubs.circle));
        when(
          () => searchUseCase.execute(
            searchQuery: any(named: 'searchQuery'),
            circleId: any(named: 'circleId'),
            cursor: any(named: 'cursor'),
          ),
        ).thenAnswer(
          (_) => successFuture(PaginatedList.singlePage([user])),
        );

        // WHEN
        presenter.loadMore();
        async.flushMicrotasks();
        presenter.onTapInvite(user);
        async.flushMicrotasks();

        // THEN
        verify(() => useCase.execute(input: input)).called(1);
        expect(presenter.state.users.first.selected, true);
      });
    },
  );
}
