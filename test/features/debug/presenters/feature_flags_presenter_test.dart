import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/debug/feature_flags/feature_flags_initial_params.dart';
import 'package:picnic_app/features/debug/feature_flags/feature_flags_presentation_model.dart';
import 'package:picnic_app/features/debug/feature_flags/feature_flags_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../mocks/debug_mock_definitions.dart';
import '../mocks/debug_mocks.dart';

void main() {
  late FeatureFlagsPresentationModel model;
  late FeatureFlagsPresenter presenter;
  late MockFeatureFlagsNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  setUp(() {
    whenListen(
      Mocks.featureFlagsStore,
      Stream.fromIterable([Stubs.featureFlags]),
    );
    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);
    model = FeatureFlagsPresentationModel.initial(
      const FeatureFlagsInitialParams(),
      Mocks.featureFlagsStore,
    );
    navigator = MockFeatureFlagsNavigator();
    presenter = FeatureFlagsPresenter(
      model,
      navigator,
      DebugMocks.changeFeatureFlagsUseCase,
      Mocks.getFeatureFlagsUseCase,
      Mocks.featureFlagsStore,
    );
  });
}
