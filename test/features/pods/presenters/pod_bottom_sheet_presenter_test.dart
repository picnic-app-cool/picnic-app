import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/core/domain/model/pod_app.dart';
import 'package:picnic_app/features/pods/pod_bottom_sheet_initial_params.dart';
import 'package:picnic_app/features/pods/pod_bottom_sheet_presentation_model.dart';
import 'package:picnic_app/features/pods/pod_bottom_sheet_presenter.dart';

import '../../circles/mocks/circles_mocks.dart';
import '../mocks/pods_mock_definitions.dart';
import '../mocks/pods_mocks.dart';

void main() {
  late PodBottomSheetPresentationModel model;
  late PodBottomSheetPresenter presenter;
  late MockPodBottomSheetNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  setUp(() {
    model = PodBottomSheetPresentationModel.initial(const PodBottomSheetInitialParams(pod: PodApp.empty()));
    navigator = MockPodBottomSheetNavigator();
    presenter = PodBottomSheetPresenter(
      model,
      navigator,
      CirclesMocks.votePodsUseCase,
      PodsMocks.savePodUseCase,
      CirclesMocks.unVotePodsUseCase,
    );
  });
}
