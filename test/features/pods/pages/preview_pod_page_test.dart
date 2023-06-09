import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/pod_app.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/pods/domain/model/get_recommended_circles_input.dart';
import 'package:picnic_app/features/pods/domain/model/preview_pod_tab.dart';
import 'package:picnic_app/features/pods/previewPod/preview_pod_initial_params.dart';
import 'package:picnic_app/features/pods/previewPod/preview_pod_navigator.dart';
import 'package:picnic_app/features/pods/previewPod/preview_pod_page.dart';
import 'package:picnic_app/features/pods/previewPod/preview_pod_presentation_model.dart';
import 'package:picnic_app/features/pods/previewPod/preview_pod_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../mocks/pods_mocks.dart';

Future<void> main() async {
  late PreviewPodPage page;
  late PreviewPodInitialParams initParams;
  late PreviewPodPresentationModel model;
  late PreviewPodPresenter presenter;
  late PreviewPodNavigator navigator;

  void initMvp() {
    registerFallbackValue(const GetRecommendedCirclesInput.empty());
    when(() => PodsMocks.getRecommendedCirclesUseCase.execute(any())).thenAnswer(
      (_) => successFuture(
        PaginatedList.singlePage([
          const Circle.empty().copyWith(name: 'circle1'),
          const Circle.empty().copyWith(name: 'circle2'),
          const Circle.empty().copyWith(name: 'circle3'),
          const Circle.empty().copyWith(name: 'circle4'),
          const Circle.empty().copyWith(name: 'circle5'),
        ]),
      ),
    );
    initParams = PreviewPodInitialParams(
      pod: const PodApp.empty().copyWith(name: 'AI Image Generator'),
      initialTab: PreviewPodTab.launch,
    );
    model = PreviewPodPresentationModel.initial(
      initParams,
    );
    navigator = PreviewPodNavigator(Mocks.appNavigator);
    presenter = PreviewPodPresenter(
      model,
      navigator,
      PodsMocks.enablePodInCircleUseCase,
      PodsMocks.getRecommendedCirclesUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
      Mocks.getUserScopedPodTokenUseCase,
      Mocks.debouncer,
    );

    getIt.registerFactoryParam<PreviewPodPresenter, PreviewPodInitialParams, dynamic>(
      (initialParams, _) => presenter,
    );
    page = PreviewPodPage(initialParams: initParams);
  }

  await screenshotTest(
    "preview_pod_page",
    setUp: () async {
      initMvp();
    },
    pageBuilder: () => page,
  );
}
