import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/resolve_report_with_no_action/resolve_report_with_no_action_initial_params.dart';
import 'package:picnic_app/features/circles/resolve_report_with_no_action/resolve_report_with_no_action_navigator.dart';
import 'package:picnic_app/features/circles/resolve_report_with_no_action/resolve_report_with_no_action_page.dart';
import 'package:picnic_app/features/circles/resolve_report_with_no_action/resolve_report_with_no_action_presentation_model.dart';
import 'package:picnic_app/features/circles/resolve_report_with_no_action/resolve_report_with_no_action_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';

Future<void> main() async {
  late ResolveReportWithNoActionPage page;
  late ResolveReportWithNoActionInitialParams initParams;
  late ResolveReportWithNoActionPresentationModel model;
  late ResolveReportWithNoActionPresenter presenter;
  late ResolveReportWithNoActionNavigator navigator;

  void initMvp() {
    initParams = ResolveReportWithNoActionInitialParams(
      circleId: Stubs.id,
      reportId: Stubs.id,
    );
    model = ResolveReportWithNoActionPresentationModel.initial(
      initParams,
    );
    navigator = ResolveReportWithNoActionNavigator(Mocks.appNavigator);
    presenter = ResolveReportWithNoActionPresenter(
      model,
      navigator,
    );
    page = ResolveReportWithNoActionPage(presenter: presenter);
  }

  await screenshotTest(
    "resolve_report_with_no_action_page",
    setUp: () async {
      initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    initMvp();
    final page = getIt<ResolveReportWithNoActionPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
