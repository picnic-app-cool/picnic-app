import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/circle_role.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flag_type.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flags.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/members/members_initial_params.dart';
import 'package:picnic_app/features/circles/members/members_navigator.dart';
import 'package:picnic_app/features/circles/members/members_page.dart';
import 'package:picnic_app/features/circles/members/members_presentation_model.dart';
import 'package:picnic_app/features/circles/members/members_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/circles_mocks.dart';

void main() {
  late MembersPage page;
  late MembersInitialParams initParams;
  late MembersPresentationModel model;
  late MembersPresenter presenter;
  late MembersNavigator navigator;

  void _initMvp({bool isDirector = false, required FeatureFlags featureFlags}) {
    when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);
    when(() => Mocks.featureFlagsStore.featureFlags).thenReturn(featureFlags);
    initParams = MembersInitialParams(
      circle: Stubs.circle.copyWith(
        circleRole: isDirector ? CircleRole.director : CircleRole.member,
      ),
    );
    model = MembersPresentationModel.initial(
      initParams,
      Mocks.userStore,
      Mocks.featureFlagsStore,
    );
    when(
      () => CirclesMocks.getCircleMembersByRoleUseCase.execute(
        circleId: any(named: 'circleId'),
        cursor: any(named: 'cursor'),
        roles: any(named: 'roles'),
        searchQuery: model.searchQuery,
      ),
    ).thenAnswer(
      (_) => successFuture(PaginatedList.singlePage([Stubs.circleMemberDirector, Stubs.circleMemberDirector])),
    );

    navigator = MembersNavigator(Mocks.appNavigator, Mocks.userStore);

    presenter = MembersPresenter(
      model,
      navigator,
      Mocks.followUserUseCase,
      CirclesMocks.getCircleMembersByRoleUseCase,
      Mocks.clipboardManager,
      Mocks.debouncer,
    );

    page = MembersPage(presenter: presenter);
  }

  screenshotTest(
    "members_page_member_view",
    setUp: () async {
      _initMvp(featureFlags: Stubs.featureFlags);
    },
    pageBuilder: () => page,
  );

  screenshotTest(
    "members_page_director_view_with_custom_roles_enabled",
    setUp: () async {
      final featureFlags = Stubs.featureFlags.enable(FeatureFlagType.customRoles);
      _initMvp(isDirector: true, featureFlags: featureFlags);
    },
    pageBuilder: () => page,
  );

  screenshotTest(
    "members_page_director_view_with_custom_roles_disabled",
    setUp: () async {
      final featureFlags = Stubs.featureFlags.disable(FeatureFlagType.customRoles);
      _initMvp(isDirector: true, featureFlags: featureFlags);
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp(featureFlags: Stubs.featureFlags);
    final page = getIt<MembersPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
