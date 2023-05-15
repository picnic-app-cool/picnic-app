import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/core/domain/model/pod_app.dart';
import 'package:picnic_app/features/circles/pods/pod_web_view_initial_params.dart';
import 'package:picnic_app/features/circles/pods/pod_web_view_presentation_model.dart';
import 'package:picnic_app/features/circles/pods/pod_web_view_presenter.dart';

import '../mocks/circles_mock_definitions.dart';

void main() {
  late PodWebViewPresentationModel model;
  late PodWebViewPresenter presenter;
  late MockPodWebViewNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  setUp(() {
    model = PodWebViewPresentationModel.initial(
      const PodWebViewInitialParams(
        pod: PodApp.empty(),
      ),
    );
    navigator = MockPodWebViewNavigator();
    presenter = PodWebViewPresenter(
      model,
      navigator,
    );
  });
}
