import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/edit_rules/edit_rules_initial_params.dart';
import 'package:picnic_app/features/circles/edit_rules/edit_rules_navigator.dart';
import 'package:picnic_app/features/circles/edit_rules/edit_rules_page.dart';
import 'package:picnic_app/features/circles/edit_rules/edit_rules_presentation_model.dart';
import 'package:picnic_app/features/circles/edit_rules/edit_rules_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../mocks/circles_mocks.dart';

Future<void> main() async {
  late EditRulesPage page;
  late EditRulesInitialParams initParams;
  late EditRulesPresentationModel model;
  late EditRulesPresenter presenter;
  late EditRulesNavigator navigator;

  void _initMvp() {
    initParams = EditRulesInitialParams(circle: Stubs.circle);
    model = EditRulesPresentationModel.initial(
      initParams,
    );
    navigator = EditRulesNavigator(Mocks.appNavigator);
    presenter = EditRulesPresenter(
      model,
      navigator,
      CirclesMocks.editRulesUseCase,
    );
    page = EditRulesPage(presenter: presenter);
  }

  await screenshotTest(
    "edit_rules_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<EditRulesPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
