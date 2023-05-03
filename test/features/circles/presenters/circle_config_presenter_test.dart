import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/circles/circle_config/circle_config_initial_params.dart';
import 'package:picnic_app/features/circles/circle_config/circle_config_presentation_model.dart';
import 'package:picnic_app/features/circles/circle_config/circle_config_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../create_circle/mocks/create_circle_mocks.dart';
import '../mocks/circles_mock_definitions.dart';
import '../mocks/circles_mocks.dart';

void main() {
  late CircleConfigPresentationModel model;
  late CircleConfigPresenter presenter;
  late MockCircleConfigNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  setUp(() {
    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);
    model = CircleConfigPresentationModel.initial(
      const CircleConfigInitialParams(),
      Mocks.featureFlagsStore,
    );
    navigator = MockCircleConfigNavigator();
    presenter = CircleConfigPresenter(
      model,
      navigator,
      CirclesMocks.getDefaultCircleConfigUseCase,
      CreateCircleMocks.createCircleUseCase,
      Mocks.updateCircleUseCase,
    );
  });
}
