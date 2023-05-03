import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/reports/report_form/report_form_initial_params.dart';
import 'package:picnic_app/features/reports/report_form/report_form_presentation_model.dart';
import 'package:picnic_app/features/reports/report_form/report_form_presenter.dart';

import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/reports_mock_definitions.dart';
import '../mocks/reports_mocks.dart';

void main() {
  late ReportFormPresentationModel model;
  late ReportFormPresenter presenter;
  late MockReportFormNavigator navigator;

  test(
    'test that global reasons are retrieved when initializing the presenter if no circle Id is passed',
    () {
      // GIVEN
      when(
        () => ReportsMocks.getGlobalReportReasonsUseCase.execute(
          reportEntityType: any(named: 'reportEntityType'),
        ),
      ).thenAnswer(
        (_) => successFuture(Stubs.reportReasons),
      );

      // WHEN
      presenter.onInit();

      // THEN
      verify(
        () => ReportsMocks.getGlobalReportReasonsUseCase.execute(
          reportEntityType: any(named: 'reportEntityType'),
        ),
      );
    },
  );

  test(
    'test that circle reasons are retrieved when initializing the presenter if circle Id is passed',
    () {
      // GIVEN
      presenter.emit(model.copyWith(circleId: Stubs.circle.id));
      when(
        () => ReportsMocks.getCircleReportReasonsUseCase.execute(),
      ).thenAnswer(
        (_) => successFuture(Stubs.reportReasons),
      );

      // WHEN
      presenter.onInit();

      // THEN
      verify(
        () => ReportsMocks.getCircleReportReasonsUseCase.execute(),
      );
    },
  );

  test(
    'report should be sent globally when tapping send report if no circleId is provided',
    () {
      // GIVEN
      presenter.emit(model.copyWith(circleId: const Id.empty()));
      when(
        () => ReportsMocks.createGlobalReportUseCase.execute(
          report: any(named: 'report'),
        ),
      ).thenAnswer(
        (_) => successFuture(unit),
      );

      // WHEN
      presenter.onTapSendReport();

      // THEN
      verify(
        () => ReportsMocks.createGlobalReportUseCase.execute(
          report: any(named: 'report'),
        ),
      );
    },
  );

  test(
    'report should be sent in circle when tapping send report if circleId is provided',
    () {
      // GIVEN
      presenter.emit(model.copyWith(circleId: Stubs.circle.id));
      when(
        () => ReportsMocks.createCircleReportUseCase.execute(
          report: any(named: 'report'),
        ),
      ).thenAnswer(
        (_) => successFuture(unit),
      );

      // WHEN
      presenter.onTapSendReport();

      // THEN
      verify(
        () => ReportsMocks.createCircleReportUseCase.execute(
          report: any(named: 'report'),
        ),
      );
    },
  );

  setUp(() {
    model = ReportFormPresentationModel.initial(const ReportFormInitialParams());
    navigator = MockReportFormNavigator();
    presenter = ReportFormPresenter(
      model,
      navigator,
      ReportsMocks.getGlobalReportReasonsUseCase,
      ReportsMocks.getCircleReportReasonsUseCase,
      ReportsMocks.createGlobalReportUseCase,
      ReportsMocks.createCircleReportUseCase,
    );
  });
}
