import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/features/circles/reported_content/reported_content_initial_params.dart';
import 'package:picnic_app/features/circles/reported_content/reported_content_presentation_model.dart';
import 'package:picnic_app/features/circles/reported_content/reported_content_presenter.dart';
import 'package:picnic_app/features/reports/domain/model/report_entity_type.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../mocks/circles_mock_definitions.dart';

void main() {
  late ReportedContentPresentationModel model;
  late ReportedContentPresenter presenter;
  late MockReportedContentNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  setUp(() {
    model = ReportedContentPresentationModel.initial(
      ReportedContentInitialParams(
        author: const PublicProfile.empty(),
        circleId: Stubs.circle.id,
        reportId: Stubs.textPost.id,
        reportType: ReportEntityType.post,
      ),
    );
    navigator = MockReportedContentNavigator();
    presenter = ReportedContentPresenter(
      model,
      Mocks.resolveReportUseCase,
      navigator,
    );
  });
}
