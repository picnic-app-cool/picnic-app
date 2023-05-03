import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/core/domain/model/circle_moderation_type.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/create_circle/rule_selection/rule_selection_initial_params.dart';
import 'package:picnic_app/features/create_circle/rule_selection/rule_selection_navigator.dart';
import 'package:picnic_app/features/create_circle/rule_selection/rule_selection_page.dart';
import 'package:picnic_app/features/create_circle/rule_selection/rule_selection_presentation_model.dart';
import 'package:picnic_app/features/create_circle/rule_selection/rule_selection_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';

Future<void> main() async {
  late RuleSelectionPage page;
  late RuleSelectionInitialParams initParams;
  late RuleSelectionPresentationModel model;
  late RuleSelectionPresenter presenter;
  late RuleSelectionNavigator navigator;

  void _initMvp() {
    initParams = RuleSelectionInitialParams(
      createPostInput: Stubs.createTextPostInput,
      circle: Stubs.circle.copyWith(moderationType: CircleModerationType.director),
    );
    model = RuleSelectionPresentationModel.initial(
      initParams,
    );
    navigator = RuleSelectionNavigator(Mocks.appNavigator);
    presenter = RuleSelectionPresenter(
      model,
      navigator,
      Mocks.updateCircleUseCase,
    );
    page = RuleSelectionPage(presenter: presenter);
  }

  await screenshotTest(
    "circle_creation_rule_selection_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<RuleSelectionPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
