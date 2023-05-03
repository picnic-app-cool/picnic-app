import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/reports/domain/model/report_reason.dart';
import 'package:picnic_app/features/reports/report_reasons/report_reasons_initial_params.dart';
import 'package:picnic_app/features/reports/report_reasons/report_reasons_presentation_model.dart';
import 'package:picnic_app/features/reports/report_reasons/report_reasons_presenter.dart';

import '../mocks/reports_mock_definitions.dart';

void main() {
  late ReportReasonsPresentationModel model;
  late ReportReasonsPresenter presenter;
  late MockReportReasonsNavigator navigator;

  test(
    "close with result reason",
    () {
      // WHEN
      presenter.onTapSelectReason(const ReportReason.empty());

      // THEN
      verify(() async => navigator.closeWithResult(const ReportReason.empty()));
    },
  );

  setUp(() {
    model = ReportReasonsPresentationModel.initial(const ReportReasonsInitialParams());
    navigator = MockReportReasonsNavigator();
    presenter = ReportReasonsPresenter(
      model,
      navigator,
    );
  });
}
