import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/circles/resolve_report_with_no_action/resolve_report_with_no_action_initial_params.dart';
import 'package:picnic_app/features/circles/resolve_report_with_no_action/resolve_report_with_no_action_presentation_model.dart';
import 'package:picnic_app/features/circles/resolve_report_with_no_action/resolve_report_with_no_action_presenter.dart';

import '../../../mocks/stubs.dart';
import '../mocks/circles_mock_definitions.dart';

void main() {
  late ResolveReportWithNoActionPresentationModel model;
  late ResolveReportWithNoActionPresenter presenter;
  late MockResolveReportWithNoActionNavigator navigator;

  test(
    'tapping on close should call the navigator to close the widget returning false',
    () {
      //WHEN
      presenter.onTapClose();

      //THEN
      verify(() async => navigator.closeWithResult(false));
    },
  );

  test(
    'on resolve with no action should call the navigator to close the widget returning true',
    () {
      //WHEN
      presenter.onTapResolveWithNoAction();

      //THEN
      verify(() async => navigator.closeWithResult(true));
    },
  );

  setUp(() {
    model = ResolveReportWithNoActionPresentationModel.initial(
      ResolveReportWithNoActionInitialParams(
        circleId: Stubs.id,
        reportId: Stubs.id,
      ),
    );
    navigator = MockResolveReportWithNoActionNavigator();
    presenter = ResolveReportWithNoActionPresenter(
      model,
      navigator,
    );
  });
}
