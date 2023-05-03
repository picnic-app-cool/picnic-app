import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/remove_reason/remove_reason_initial_params.dart';
import 'package:picnic_app/features/circles/remove_reason/remove_reason_navigator.dart';
import 'package:picnic_app/features/circles/remove_reason/remove_reason_page.dart';
import 'package:picnic_app/features/circles/remove_reason/remove_reason_presentation_model.dart';
import 'package:picnic_app/features/circles/remove_reason/remove_reason_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/golden_tests_utils.dart';

Future<void> main() async {
  late RemoveReasonPage page;
  late RemoveReasonInitialParams initParams;
  late RemoveReasonPresentationModel model;
  late RemoveReasonPresenter presenter;
  late RemoveReasonNavigator navigator;

  void _initMvp() {
    initParams = const RemoveReasonInitialParams();
    model = RemoveReasonPresentationModel.initial(
      initParams,
    );
    navigator = RemoveReasonNavigator(Mocks.appNavigator);
    presenter = RemoveReasonPresenter(
      model,
      navigator,
    );
    page = RemoveReasonPage(presenter: presenter);
  }

  await screenshotTest(
    "remove_reason_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<RemoveReasonPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
