import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/features/slices/join_requests/join_requests_initial_params.dart';
import 'package:picnic_app/features/slices/join_requests/join_requests_presentation_model.dart';
import 'package:picnic_app/features/slices/join_requests/join_requests_presenter.dart';

import '../../../mocks/stubs.dart';
import '../mocks/slices_mock_definitions.dart';
import '../mocks/slices_mocks.dart';

void main() {
  late JoinRequestsPresentationModel model;
  late JoinRequestsPresenter presenter;
  late MockJoinRequestsNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  setUp(() {
    model = JoinRequestsPresentationModel.initial(JoinRequestsInitialParams(sliceId: Stubs.slice.id));
    navigator = MockJoinRequestsNavigator();
    presenter = JoinRequestsPresenter(
      model,
      navigator,
      SlicesMocks.getSliceJoinRequestsUseCase,
      SlicesMocks.approveJoinRequestUseCase,
    );
  });
}
