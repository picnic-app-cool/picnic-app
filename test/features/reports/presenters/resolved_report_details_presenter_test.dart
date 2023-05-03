import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/reports/report_details/resolved_report_details_initial_params.dart';
import 'package:picnic_app/features/reports/report_details/resolved_report_details_presentation_model.dart';
import 'package:picnic_app/features/reports/report_details/resolved_report_details_presenter.dart';

import '../../../mocks/stubs.dart';
import '../mocks/reports_mock_definitions.dart';

void main() {
  late ResolvedReportDetailsPresentationModel model;
  late ResolvedReportDetailsPresenter presenter;
  late MockReportDetailsNavigator navigator;

  setUp(() {
    model = ResolvedReportDetailsPresentationModel.initial(
      ResolvedReportDetailsInitialParams(
        moderator: Stubs.postAuthor,
        resolvedAt: Stubs.dateTime.toIso8601String(),
      ),
    );
    navigator = MockReportDetailsNavigator();
    presenter = ResolvedReportDetailsPresenter(
      model,
      navigator,
    );
  });

  test(
    'tapping close should return false as result',
    () {
      //GIVEN
      presenter.onTapClose();

      // THEN
      verify(
        () => navigator.closeWithResult(false),
      );
    },
  );
}
