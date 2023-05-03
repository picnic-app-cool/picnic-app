import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/reports/report_form/report_form_initial_params.dart';
import 'package:picnic_app/features/reports/report_form/report_form_navigator.dart';
import 'package:picnic_app/features/reports/report_form/report_form_page.dart';
import 'package:picnic_app/features/reports/report_form/report_form_presentation_model.dart';
import 'package:picnic_app/features/reports/report_form/report_form_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/reports_mocks.dart';

Future<void> main() async {
  late ReportFormPage page;
  late ReportFormInitialParams initParams;
  late ReportFormPresentationModel model;
  late ReportFormPresenter presenter;
  late ReportFormNavigator navigator;

  void _initMvp() {
    initParams = const ReportFormInitialParams();
    model = ReportFormPresentationModel.initial(
      initParams,
    );
    navigator = ReportFormNavigator(Mocks.appNavigator);

    presenter = ReportFormPresenter(
      model,
      navigator,
      ReportsMocks.getGlobalReportReasonsUseCase,
      ReportsMocks.getCircleReportReasonsUseCase,
      ReportsMocks.createGlobalReportUseCase,
      ReportsMocks.createCircleReportUseCase,
    );

    page = ReportFormPage(presenter: presenter);

    when(
      () => ReportsMocks.getGlobalReportReasonsUseCase.execute(
        reportEntityType: any(named: 'reportEntityType'),
      ),
    ).thenAnswer(
      (_) => successFuture(Stubs.reportReasons),
    );

    when(
      () => ReportsMocks.createGlobalReportUseCase.execute(
        report: any(named: 'report'),
      ),
    ).thenAnswer(
      (_) => successFuture(unit),
    );
  }

  await screenshotTest(
    "report_form_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<ReportFormPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
