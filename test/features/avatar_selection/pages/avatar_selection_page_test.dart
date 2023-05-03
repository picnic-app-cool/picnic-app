import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/avatar_selection/avatar_selection_initial_params.dart';
import 'package:picnic_app/features/avatar_selection/avatar_selection_navigator.dart';
import 'package:picnic_app/features/avatar_selection/avatar_selection_page.dart';
import 'package:picnic_app/features/avatar_selection/avatar_selection_presentation_model.dart';
import 'package:picnic_app/features/avatar_selection/avatar_selection_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/golden_tests_utils.dart';

Future<void> main() async {
  late AvatarSelectionPage page;
  late AvatarSelectionInitialParams initParams;
  late AvatarSelectionPresentationModel model;
  late AvatarSelectionPresenter presenter;
  late AvatarSelectionNavigator navigator;

  void _initMvp() {
    initParams = const AvatarSelectionInitialParams(emoji: '😄');
    model = AvatarSelectionPresentationModel.initial(
      initParams,
    );
    navigator = AvatarSelectionNavigator(Mocks.appNavigator);
    presenter = AvatarSelectionPresenter(
      model,
      navigator,
    );
    page = AvatarSelectionPage(presenter: presenter);
  }

  await screenshotTest(
    "avatar_selection_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<AvatarSelectionPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
