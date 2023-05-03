import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/circle_role/circle_role_initial_params.dart';
import 'package:picnic_app/features/circles/circle_role/circle_role_navigator.dart';
import 'package:picnic_app/features/circles/circle_role/circle_role_page.dart';
import 'package:picnic_app/features/circles/circle_role/circle_role_presentation_model.dart';
import 'package:picnic_app/features/circles/circle_role/circle_role_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../mocks/circles_mocks.dart';

Future<void> main() async {
  late CircleRolePage page;
  late CircleRoleInitialParams initParams;
  late CircleRolePresentationModel model;
  late CircleRolePresenter presenter;
  late CircleRoleNavigator navigator;

  void initMvp() {
    initParams = CircleRoleInitialParams(
      circleId: const Circle.empty().id,
      formType: CircleRoleFormType.createCircleRole,
    );
    model = CircleRolePresentationModel.initial(
      initParams,
    );
    navigator = CircleRoleNavigator(Mocks.appNavigator);
    presenter = CircleRolePresenter(
      model,
      navigator,
      CirclesMocks.createCircleRoleUseCase,
      CirclesMocks.updateCircleRoleUseCase,
    );
    page = CircleRolePage(presenter: presenter);
  }

  await screenshotTest(
    "circle_role_page",
    setUp: () async {
      initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    initMvp();
    final page = getIt<CircleRolePage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
