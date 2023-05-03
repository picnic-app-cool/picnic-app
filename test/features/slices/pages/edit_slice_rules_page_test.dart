import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/slices/edit_slices/edit_slice_rules_initial_params.dart';
import 'package:picnic_app/features/slices/edit_slices/edit_slice_rules_navigator.dart';
import 'package:picnic_app/features/slices/edit_slices/edit_slice_rules_page.dart';
import 'package:picnic_app/features/slices/edit_slices/edit_slice_rules_presentation_model.dart';
import 'package:picnic_app/features/slices/edit_slices/edit_slice_rules_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';

Future<void> main() async {
  late EditSliceRulesPage page;
  late EditSliceRulesInitialParams initParams;
  late EditSliceRulesPresentationModel model;
  late EditSliceRulesPresenter presenter;
  late EditSliceRulesNavigator navigator;

  void initMvp() {
    initParams = EditSliceRulesInitialParams(Stubs.slice);
    model = EditSliceRulesPresentationModel.initial(
      initParams,
    );
    navigator = EditSliceRulesNavigator(Mocks.appNavigator);
    presenter = EditSliceRulesPresenter(
      model,
      navigator,
      Mocks.updateSliceUseCase,
    );
    page = EditSliceRulesPage(presenter: presenter);
  }

  await screenshotTest(
    "edit_slice_rules_page",
    setUp: () async {
      initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    initMvp();
    final page = getIt<EditSliceRulesPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
