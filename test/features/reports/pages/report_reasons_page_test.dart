import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/reports/report_reasons/report_reasons_initial_params.dart';
import 'package:picnic_app/features/reports/report_reasons/report_reasons_navigator.dart';
import 'package:picnic_app/features/reports/report_reasons/report_reasons_page.dart';
import 'package:picnic_app/features/reports/report_reasons/report_reasons_presentation_model.dart';
import 'package:picnic_app/features/reports/report_reasons/report_reasons_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';

Future<void> main() async {
  late ReportReasonsPage page;
  late ReportReasonsInitialParams initParams;
  late ReportReasonsPresentationModel model;
  late ReportReasonsPresenter presenter;
  late ReportReasonsNavigator navigator;

  void _initMvp() {
    initParams = ReportReasonsInitialParams(
      reasons: Stubs.reportReasons,
    );
    model = ReportReasonsPresentationModel.initial(
      initParams,
    );
    navigator = ReportReasonsNavigator(Mocks.appNavigator);
    presenter = ReportReasonsPresenter(
      model,
      navigator,
    );
    page = ReportReasonsPage(presenter: presenter);
  }

  await screenshotTest(
    "report_reasons_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<ReportReasonsPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
