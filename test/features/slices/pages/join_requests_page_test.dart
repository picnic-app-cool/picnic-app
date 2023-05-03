import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/slices/join_requests/join_requests_initial_params.dart';
import 'package:picnic_app/features/slices/join_requests/join_requests_navigator.dart';
import 'package:picnic_app/features/slices/join_requests/join_requests_page.dart';
import 'package:picnic_app/features/slices/join_requests/join_requests_presentation_model.dart';
import 'package:picnic_app/features/slices/join_requests/join_requests_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/slices_mocks.dart';

Future<void> main() async {
  late JoinRequestsPage page;
  late JoinRequestsInitialParams initParams;
  late JoinRequestsPresentationModel model;
  late JoinRequestsPresenter presenter;
  late JoinRequestsNavigator navigator;

  void initMvp() {
    when(() => SlicesMocks.getSliceJoinRequestsUseCase.execute(sliceId: Stubs.slice.id)).thenAnswer(
      (_) => successFuture(
        PaginatedList.singlePage([
          Stubs.publicProfile,
          Stubs.publicProfile2,
        ]),
      ),
    );

    initParams = JoinRequestsInitialParams(sliceId: Stubs.slice.id);
    model = JoinRequestsPresentationModel.initial(
      initParams,
    );
    navigator = JoinRequestsNavigator(Mocks.appNavigator);
    presenter = JoinRequestsPresenter(
      model,
      navigator,
      SlicesMocks.getSliceJoinRequestsUseCase,
      SlicesMocks.approveJoinRequestUseCase,
    );
    page = JoinRequestsPage(presenter: presenter);
  }

  await screenshotTest(
    "join_requests_page",
    setUp: () async {
      initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    initMvp();
    final page = getIt<JoinRequestsPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
