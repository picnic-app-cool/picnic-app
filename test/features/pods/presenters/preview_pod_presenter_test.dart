import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/core/domain/model/pod_app.dart';
import 'package:picnic_app/features/pods/domain/model/preview_pod_tab.dart';
import 'package:picnic_app/features/pods/previewPod/preview_pod_initial_params.dart';
import 'package:picnic_app/features/pods/previewPod/preview_pod_presentation_model.dart';
import 'package:picnic_app/features/pods/previewPod/preview_pod_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../mocks/pods_mock_definitions.dart';
import '../mocks/pods_mocks.dart';

void main() {
  late PreviewPodPresentationModel model;
  late PreviewPodPresenter presenter;
  late MockPreviewPodNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  setUp(() {
    model = PreviewPodPresentationModel.initial(
      PreviewPodInitialParams(
        pod: const PodApp.empty().copyWith(name: 'AI Image Generator'),
        initialTab: PreviewPodTab.launch,
      ),
    );
    navigator = MockPreviewPodNavigator();
    presenter = PreviewPodPresenter(
      model,
      navigator,
      PodsMocks.enablePodInCircleUseCase,
      PodsMocks.getRecommendedCirclesUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
      Mocks.getUserScopedPodTokenUseCase,
      Mocks.debouncer,
    );
  });
}
