import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/create_circle/circle_creation_rules/circle_creation_rules_initial_params.dart';
import 'package:picnic_app/features/create_circle/circle_creation_rules/circle_creation_rules_navigator.dart';
import 'package:picnic_app/features/create_circle/circle_creation_rules/circle_creation_rules_page.dart';
import 'package:picnic_app/features/create_circle/circle_creation_rules/circle_creation_rules_presentation_model.dart';
import 'package:picnic_app/features/create_circle/circle_creation_rules/circle_creation_rules_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';

Future<void> main() async {
  late CircleCreationRulesPage page;
  late CircleCreationRulesInitialParams initParams;
  late CircleCreationRulesPresentationModel model;
  late CircleCreationRulesPresenter presenter;
  late CircleCreationRulesNavigator navigator;

  void _initMvp() {
    initParams = CircleCreationRulesInitialParams(
      circle: Stubs.circle,
      createPostInput: Stubs.createTextPostInput,
    );
    model = CircleCreationRulesPresentationModel.initial(
      initParams,
    );
    navigator = CircleCreationRulesNavigator(Mocks.appNavigator);
    presenter = CircleCreationRulesPresenter(
      model,
      navigator,
    );
    page = CircleCreationRulesPage(presenter: presenter);
  }

  await screenshotTest(
    "circle_creation_rules_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<CircleCreationRulesPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
