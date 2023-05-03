import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/domain/model/circle_member_custom_roles.dart';
import 'package:picnic_app/features/circles/user_roles/user_roles_initial_params.dart';
import 'package:picnic_app/features/circles/user_roles/user_roles_navigator.dart';
import 'package:picnic_app/features/circles/user_roles/user_roles_page.dart';
import 'package:picnic_app/features/circles/user_roles/user_roles_presentation_model.dart';
import 'package:picnic_app/features/circles/user_roles/user_roles_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/circles_mocks.dart';

Future<void> main() async {
  late UserRolesPage page;
  late UserRolesInitialParams initParams;
  late UserRolesPresentationModel model;
  late UserRolesPresenter presenter;
  late UserRolesNavigator navigator;

  void initMvp() {
    initParams = UserRolesInitialParams(
      user: Stubs.publicProfile,
      circleId: Stubs.circle.id,
    );
    model = UserRolesPresentationModel.initial(
      initParams,
    );
    navigator = UserRolesNavigator(Mocks.appNavigator);
    presenter = UserRolesPresenter(
      model,
      navigator,
      CirclesMocks.assignUserRoleUseCase,
      CirclesMocks.unAssignUserRoleUseCase,
      CirclesMocks.getUserRolesInCircleUseCase,
    );
    when(
      () => CirclesMocks.getUserRolesInCircleUseCase.execute(
        circleId: Stubs.circle.id,
        userId: Stubs.publicProfile.id,
      ),
    ).thenAnswer(
      (_) => successFuture(
        CircleMemberCustomRoles(
          unassigned: List.filled(2, Stubs.circleCustomRole),
          roles: List.filled(2, Stubs.circleCustomRole.copyWith(name: 'assigned role')),
          mainRoleId: 'roleId',
        ),
      ),
    );
    page = UserRolesPage(presenter: presenter);
  }

  await screenshotTest(
    "user_roles_page",
    setUp: () async {
      initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    initMvp();
    final page = getIt<UserRolesPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
