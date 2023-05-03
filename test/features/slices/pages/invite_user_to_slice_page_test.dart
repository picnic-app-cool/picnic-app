import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/invite_users_to_circle_input.dart';
import 'package:picnic_app/features/slices/invite_user_to_slice/invite_user_to_slice_initial_params.dart';
import 'package:picnic_app/features/slices/invite_user_to_slice/invite_user_to_slice_page.dart';
import 'package:picnic_app/features/slices/invite_user_to_slice/invite_user_to_slice_presentation_model.dart';
import 'package:picnic_app/features/slices/invite_user_to_slice/invite_user_to_slice_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../../circles/mocks/circles_mocks.dart';
import '../mocks/slices_mock_definitions.dart';

Future<void> main() async {
  late InviteUserToSlicePage page;
  late InviteUserToSliceInitialParams initialParams;
  late InviteUserToSlicePresentationModel model;
  late InviteUserToSlicePresenter presenter;
  late MockInviteUserToSliceNavigator navigator;

  void _initMvp() {
    initialParams = InviteUserToSliceInitialParams(circleId: Stubs.circle.id, sliceId: Stubs.slice.id);
    model = InviteUserToSlicePresentationModel.initial(initialParams);
    navigator = MockInviteUserToSliceNavigator();
    presenter = InviteUserToSlicePresenter(
      model,
      navigator,
      CirclesMocks.inviteUserToCircleUseCase,
      CirclesMocks.getCircleMembersUseCase,
      Mocks.debouncer,
    );
    page = InviteUserToSlicePage(presenter: presenter);
  }

  await screenshotTest(
    "invite_user_to_slice_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  await screenshotTest(
    "invite_user_to_slice_one_user_invited_page",
    setUp: () async {
      _initMvp();
      await presenter.loadMore();
      await presenter.onTapInvite(Stubs.publicProfile);
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<InviteUserToSlicePage>(param1: initialParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });

  setUp(() {
    when(
      () => CirclesMocks.getCircleMembersUseCase.execute(
        circleId: Stubs.circle.id,
        cursor: const Cursor.firstPage(),
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
      () => CirclesMocks.inviteUserToCircleUseCase.execute(
        input: InviteUsersToCircleInput(
          circleId: Stubs.circle.id,
          userIds: [Stubs.publicProfile.user.id],
        ),
      ),
    ).thenAnswer((_) => successFuture(Stubs.circle));
  });
}
