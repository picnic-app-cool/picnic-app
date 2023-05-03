import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/invite_users_to_circle_input.dart';
import 'package:picnic_app/features/circles/invite_user_list/invite_user_list_initial_params.dart';
import 'package:picnic_app/features/circles/invite_user_list/invite_user_list_navigator.dart';
import 'package:picnic_app/features/circles/invite_user_list/invite_user_list_page.dart';
import 'package:picnic_app/features/circles/invite_user_list/invite_user_list_presentation_model.dart';
import 'package:picnic_app/features/circles/invite_user_list/invite_user_list_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/circles_mocks.dart';

Future<void> main() async {
  late InviteUserListPage page;
  late InviteUserListInitialParams initParams;
  late InviteUserListPresentationModel model;
  late InviteUserListPresenter presenter;
  late InviteUserListNavigator navigator;

  void _initMvp() {
    initParams = InviteUserListInitialParams(circleId: Stubs.circle.id);
    model = InviteUserListPresentationModel.initial(
      initParams,
    );
    navigator = InviteUserListNavigator(Mocks.appNavigator);
    presenter = InviteUserListPresenter(
      model,
      navigator,
      CirclesMocks.inviteUserToCircleUseCase,
      CirclesMocks.searchNonMemberUsersUseCase,
      Mocks.debouncer,
    );
    page = InviteUserListPage(presenter: presenter);
  }

  await screenshotTest(
    "invite_user_list_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  await screenshotTest(
    "invite_user_one_user_invited_page",
    setUp: () async {
      _initMvp();
      await presenter.loadMore();
      await presenter.onTapInvite(Stubs.publicProfile);
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<InviteUserListPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });

  setUp(() {
    when(
      () => CirclesMocks.searchNonMemberUsersUseCase.execute(
        searchQuery: '',
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
