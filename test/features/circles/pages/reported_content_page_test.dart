import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/reported_content/reported_content_initial_params.dart';
import 'package:picnic_app/features/circles/reported_content/reported_content_navigator.dart';
import 'package:picnic_app/features/circles/reported_content/reported_content_page.dart';
import 'package:picnic_app/features/circles/reported_content/reported_content_presentation_model.dart';
import 'package:picnic_app/features/circles/reported_content/reported_content_presenter.dart';
import 'package:picnic_app/features/reports/domain/model/report_entity_type.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';

Future<void> main() async {
  late ReportedContentPage page;
  late ReportedContentInitialParams initParams;
  late ReportedContentPresentationModel model;
  late ReportedContentPresenter presenter;
  late ReportedContentNavigator navigator;

  void _initMvp() {
    initParams = ReportedContentInitialParams(
      author: Stubs.publicProfile,
      circleId: Stubs.circle.id,
      reportId: Stubs.textPost.id,
      reportType: ReportEntityType.post,
    );
    model = ReportedContentPresentationModel.initial(
      initParams,
    );
    navigator = ReportedContentNavigator(Mocks.appNavigator);
    presenter = ReportedContentPresenter(
      model,
      Mocks.resolveReportUseCase,
      navigator,
    );
    page = ReportedContentPage(presenter: presenter);
  }

  await screenshotTest(
    "reported_content_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<ReportedContentPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
