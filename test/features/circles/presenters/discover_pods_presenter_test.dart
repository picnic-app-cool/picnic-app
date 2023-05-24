import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/features/circles/discover_pods/discover_pods_initial_params.dart';
import 'package:picnic_app/features/circles/discover_pods/discover_pods_presentation_model.dart';
import 'package:picnic_app/features/circles/discover_pods/discover_pods_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../mocks/circles_mock_definitions.dart';
import '../mocks/circles_mocks.dart';

void main() {
  late DiscoverPodsPresentationModel model;
  late DiscoverPodsPresenter presenter;
  late MockDiscoverPodsNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  setUp(() {
    model = DiscoverPodsPresentationModel.initial(DiscoverPodsInitialParams(circleId: Stubs.circle.id));
    navigator = MockDiscoverPodsNavigator();
    presenter = DiscoverPodsPresenter(
      model,
      navigator,
      CirclesMocks.getPodsUseCase,
      Mocks.getUserScopedPodTokenUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
    );
  });
}
