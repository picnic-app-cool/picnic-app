import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/circle_pod_app.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/discover_pods/discover_pods_initial_params.dart';
import 'package:picnic_app/features/circles/discover_pods/discover_pods_navigator.dart';
import 'package:picnic_app/features/circles/discover_pods/discover_pods_page.dart';
import 'package:picnic_app/features/circles/discover_pods/discover_pods_presentation_model.dart';
import 'package:picnic_app/features/circles/discover_pods/discover_pods_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../mocks/circles_mocks.dart';

Future<void> main() async {
  late DiscoverPodsPage page;
  late DiscoverPodsInitialParams initParams;
  late DiscoverPodsPresentationModel model;
  late DiscoverPodsPresenter presenter;
  late DiscoverPodsNavigator navigator;

  void initMvp() {
    when(
      () => CirclesMocks.getPodsUseCase.execute(
        circleId: any(named: "circleId"),
        cursor: any(named: "cursor"),
      ),
    ).thenAnswer(
      (_) => successFuture(
        const PaginatedList.singlePage(
          [CirclePodApp.empty()],
        ),
      ),
    );
    initParams = DiscoverPodsInitialParams(circleId: Stubs.circle.id);
    model = DiscoverPodsPresentationModel.initial(
      initParams,
    );
    navigator = DiscoverPodsNavigator(Mocks.appNavigator);
    presenter = DiscoverPodsPresenter(
      model,
      navigator,
      CirclesMocks.getPodsUseCase,
      Mocks.getAuthTokenUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
    );

    getIt.registerFactoryParam<DiscoverPodsPresenter, DiscoverPodsInitialParams, dynamic>(
      (initialParams, _) => presenter,
    );
    page = DiscoverPodsPage(initialParams: initParams);
  }

  await screenshotTest(
    "discover_pods_page",
    setUp: () async {
      initMvp();
    },
    pageBuilder: () => page,
  );
}
