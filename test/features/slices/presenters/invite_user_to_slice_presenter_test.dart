import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/chat/domain/model/invite_users_to_circle_input.dart';
import 'package:picnic_app/features/slices/invite_user_to_slice/invite_user_to_slice_initial_params.dart';
import 'package:picnic_app/features/slices/invite_user_to_slice/invite_user_to_slice_presentation_model.dart';
import 'package:picnic_app/features/slices/invite_user_to_slice/invite_user_to_slice_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../../circles/mocks/circles_mock_definitions.dart';
import '../../circles/mocks/circles_mocks.dart';
import '../mocks/slices_mock_definitions.dart';

void main() {
  late InviteUserToSlicePresentationModel model;
  late InviteUserToSlicePresenter presenter;
  late MockInviteUserToSliceNavigator navigator;
  late MockInviteUserToCircleUseCase useCase;
  late MockGetCircleMembersUseCase searchUseCase;

  final user = Stubs.publicProfile;
  final input = InviteUsersToCircleInput(
    circleId: Stubs.circle.id,
    userIds: [user.id],
  );

  setUp(() {
    model = InviteUserToSlicePresentationModel.initial(
      InviteUserToSliceInitialParams(circleId: Stubs.circle.id, sliceId: Stubs.slice.id),
    );
    navigator = MockInviteUserToSliceNavigator();
    useCase = CirclesMocks.inviteUserToCircleUseCase;
    searchUseCase = CirclesMocks.getCircleMembersUseCase;
    presenter = InviteUserToSlicePresenter(
      model,
      navigator,
      useCase,
      searchUseCase,
      Mocks.debouncer,
    );
  });

  test(
    'onTapInvite  should invert selectable user state',
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
