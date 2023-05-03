import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/circle_member_settings/circle_member_settings_initial_params.dart';
import 'package:picnic_app/features/circles/circle_member_settings/circle_member_settings_navigator.dart';
import 'package:picnic_app/features/circles/circle_member_settings/circle_member_settings_page.dart';
import 'package:picnic_app/features/circles/circle_member_settings/circle_member_settings_presentation_model.dart';
import 'package:picnic_app/features/circles/circle_member_settings/circle_member_settings_presenter.dart';
import 'package:picnic_app/features/circles/domain/model/circle_member_custom_roles.dart';
import 'package:picnic_app/features/profile/domain/use_cases/get_user_action_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../../chat/mocks/chat_mocks.dart';
import '../../profile/mocks/profile_mocks.dart';
import '../mocks/circles_mocks.dart';

Future<void> main() async {
  late CircleMemberSettingsPage page;
  late CircleMemberSettingsInitialParams initParams;
  late CircleMemberSettingsPresentationModel model;
  late CircleMemberSettingsPresenter presenter;
  late CircleMemberSettingsNavigator navigator;

  void _initMvp({required User user}) {
    when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);

    initParams = CircleMemberSettingsInitialParams(
      user: Stubs.publicProfile,
      circle: Stubs.circle,
    );
    model = CircleMemberSettingsPresentationModel.initial(
      initParams,
      Mocks.userStore,
    );
    navigator = CircleMemberSettingsNavigator(Mocks.appNavigator);

    when(() => Mocks.getUserUseCase.execute(userId: Stubs.user.id))
        .thenAnswer((invocation) => successFuture(Stubs.publicProfile.copyWith(user: user)));

    when(() => ProfileMocks.getProfileStatsUseCase.execute(userId: Stubs.user.id))
        .thenAnswer((invocation) => successFuture(Stubs.profileStats));

    when(
      () => Mocks.followUserUseCase.execute(
        userId: Stubs.user.id,
        follow: true,
      ),
    ).thenAnswer((invocation) => successFuture(unit));

    presenter = CircleMemberSettingsPresenter(
      model,
      navigator,
      ChatMocks.createSingleChatUseCase,
      Mocks.followUserUseCase,
      const GetUserActionUseCase(),
      Mocks.sendGlitterBombUseCase,
      Mocks.getUserUseCase,
      ProfileMocks.getProfileStatsUseCase,
      Mocks.unblockUserUseCase,
      CirclesMocks.getUserRolesInCircleUseCase,
    );
    when(
      () => CirclesMocks.getUserRolesInCircleUseCase.execute(
        circleId: any(named: 'circleId'),
        userId: any(named: 'userId'),
      ),
    ).thenAnswer(
      (invocation) => successFuture(
        CircleMemberCustomRoles(
          roles: List.filled(3, Stubs.circleCustomRole),
          unassigned: List.filled(3, Stubs.circleCustomRole.copyWith(name: 'role')),
          mainRoleId: 'roleId',
        ),
      ),
    );
    page = CircleMemberSettingsPage(presenter: presenter);
  }

  await screenshotTest(
    "circle_member_settings_page",
    variantName: "action_buttons_shown",
    setUp: () async {
      _initMvp(user: Stubs.user2);
    },
    pageBuilder: () => page,
  );

  await screenshotTest(
    "circle_member_settings_page",
    variantName: "action_buttons_hidden",
    setUp: () async {
      _initMvp(user: Stubs.user);
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp(user: Stubs.user2);
    final page = getIt<CircleMemberSettingsPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
