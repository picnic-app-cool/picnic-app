import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/reports/report_details/resolved_report_details_initial_params.dart';
import 'package:picnic_app/features/reports/report_details/resolved_report_details_navigator.dart';
import 'package:picnic_app/features/reports/report_details/resolved_report_details_page.dart';
import 'package:picnic_app/features/reports/report_details/resolved_report_details_presentation_model.dart';
import 'package:picnic_app/features/reports/report_details/resolved_report_details_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';

Future<void> main() async {
  late ResolvedReportDetailsPage page;
  late ResolvedReportDetailsInitialParams initParams;
  late ResolvedReportDetailsPresentationModel model;
  late ResolvedReportDetailsPresenter presenter;
  late ResolvedReportDetailsNavigator navigator;

  void _initMvp() {
    initParams = ResolvedReportDetailsInitialParams(
      moderator: Stubs.postAuthor,
      resolvedAt: Stubs.dateTime.toIso8601String(),
    );
    model = ResolvedReportDetailsPresentationModel.initial(
      initParams,
    );
    navigator = ResolvedReportDetailsNavigator(Mocks.appNavigator);
    presenter = ResolvedReportDetailsPresenter(
      model,
      navigator,
    );
    page = ResolvedReportDetailsPage(presenter: presenter);
  }

  await screenshotTest(
    "report_details_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<ResolvedReportDetailsPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
