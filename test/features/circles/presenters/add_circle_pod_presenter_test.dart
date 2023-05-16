import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/features/circles/add_circle_pod/add_circle_pod_initial_params.dart';
import 'package:picnic_app/features/circles/add_circle_pod/add_circle_pod_presentation_model.dart';
import 'package:picnic_app/features/circles/add_circle_pod/add_circle_pod_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../mocks/circles_mock_definitions.dart';

void main() {
  late AddCirclePodPresentationModel model;
  late AddCirclePodPresenter presenter;
  late MockAddCirclePodNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  setUp(() {
    model = AddCirclePodPresentationModel.initial(AddCirclePodInitialParams(podId: Stubs.id));
    navigator = MockAddCirclePodNavigator();
    presenter = AddCirclePodPresenter(
      model,
      navigator,
      Mocks.getPostCreationCirclesUseCase,
      Mocks.debouncer,
    );
  });
}
