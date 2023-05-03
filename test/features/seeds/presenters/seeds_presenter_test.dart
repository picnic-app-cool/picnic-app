import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/seeds/seeds/seeds_initial_params.dart';
import 'package:picnic_app/features/seeds/seeds/seeds_presentation_model.dart';
import 'package:picnic_app/features/seeds/seeds/seeds_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../mocks/seeds_mock_definitions.dart';
import '../mocks/seeds_mocks.dart';

void main() {
  late SeedsPresentationModel model;
  late SeedsPresenter presenter;
  late MockSeedsNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  setUp(() {
    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);
    model = SeedsPresentationModel.initial(
      const SeedsInitialParams(),
      Mocks.featureFlagsStore,
    );
    navigator = MockSeedsNavigator();
    presenter = SeedsPresenter(
      model,
      navigator,
      SeedsMocks.getSeedsUseCase,
    );
  });
}
