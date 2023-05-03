import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/reports_list/models/circle_reports_filter_by.dart';
import 'package:picnic_app/features/circles/reports_list/reports_list_initial_params.dart';
import 'package:picnic_app/features/circles/reports_list/reports_list_navigator.dart';
import 'package:picnic_app/features/circles/reports_list/reports_list_page.dart';
import 'package:picnic_app/features/circles/reports_list/reports_list_presentation_model.dart';
import 'package:picnic_app/features/circles/reports_list/reports_list_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../../posts/mocks/posts_mocks.dart';
import '../mocks/circles_mocks.dart';

Future<void> main() async {
  late ReportsListPage page;
  late ReportsListInitialParams initParams;
  late ReportsListPresentationModel model;
  late ReportsListPresenter presenter;
  late ReportsListNavigator navigator;

  void initMvp() {
    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);
    initParams = ReportsListInitialParams(circle: Stubs.circle);
    model = ReportsListPresentationModel.initial(
      initParams,
      Mocks.featureFlagsStore,
    );
    navigator = ReportsListNavigator(Mocks.appNavigator, Mocks.userStore);
    presenter = ReportsListPresenter(
      model,
      navigator,
      CirclesMocks.getReportsUseCase,
      PostsMocks.getPostUseCase,
      CirclesMocks.getRelatedChatMessagesFeedUseCase,
      PostsMocks.getCommentByIdUseCase,
      CirclesMocks.getCircleDetailsUseCase,
    );
    when(
      () => CirclesMocks.getReportsUseCase.execute(
        circleId: any(named: 'circleId'),
        nextPageCursor: any(named: 'nextPageCursor'),
        filterBy: CircleReportsFilterBy.unresolved,
      ),
    ).thenAnswer(
      (_) => successFuture(
        PaginatedList.singlePage(
          [Stubs.messageReport, Stubs.postReport],
        ),
      ),
    );
    page = ReportsListPage(presenter: presenter);
  }

  await screenshotTest(
    "reports_list_page",
    setUp: () async {
      initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    initMvp();
    final page = getIt<ReportsListPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
