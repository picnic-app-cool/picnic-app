import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/roles_list/roles_list_initial_params.dart';
import 'package:picnic_app/features/circles/roles_list/roles_list_navigator.dart';
import 'package:picnic_app/features/circles/roles_list/roles_list_page.dart';
import 'package:picnic_app/features/circles/roles_list/roles_list_presentation_model.dart';
import 'package:picnic_app/features/circles/roles_list/roles_list_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/circles_mocks.dart';

Future<void> main() async {
  late RolesListPage page;
  late RolesListInitialParams initParams;
  late RolesListPresentationModel model;
  late RolesListPresenter presenter;
  late RolesListNavigator navigator;

  void _initMvp() {
    initParams = RolesListInitialParams(circleId: Stubs.circle.id);
    model = RolesListPresentationModel.initial(
      initParams,
    );
    navigator = RolesListNavigator(Mocks.appNavigator);
    presenter = RolesListPresenter(
      model,
      navigator,
      CirclesMocks.getCircleRoleUseCase,
      CirclesMocks.deleteRoleUseCase,
    );
    page = RolesListPage(presenter: presenter);

    when(
      () => CirclesMocks.getCircleRoleUseCase.execute(
        circleId: Stubs.circle.id,
      ),
    ).thenAnswer(
      (_) => successFuture(
        PaginatedList.singlePage(
          List.filled(2, Stubs.circleCustomRole),
        ),
      ),
    );
  }

  await screenshotTest(
    "roles_list_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<RolesListPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
