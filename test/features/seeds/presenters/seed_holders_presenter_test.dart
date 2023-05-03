import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/current_time_provider.dart';
import 'package:picnic_app/features/seeds/seed_holders/seed_holders_initial_params.dart';
import 'package:picnic_app/features/seeds/seed_holders/seed_holders_presentation_model.dart';
import 'package:picnic_app/features/seeds/seed_holders/seed_holders_presenter.dart';

import '../../../mocks/stubs.dart';
import '../mocks/seeds_mock_definitions.dart';
import '../mocks/seeds_mocks.dart';

void main() {
  late SeedHoldersPresentationModel model;
  late SeedHoldersPresenter presenter;
  late MockSeedHoldersNavigator navigator;

  test(
    'verify that a tap on a seed owner opens the profile',
    () {
      //GIVEN
      when(() => navigator.openProfile(userId: Stubs.publicProfile.id)).thenAnswer((_) => Future.value());

      //WHEN
      presenter.onTapUser(Stubs.publicProfile.id);

      //THEN
      verify(() => navigator.openProfile(userId: Stubs.publicProfile.id));
    },
  );

  setUp(() {
    model = SeedHoldersPresentationModel.initial(
      const SeedHoldersInitialParams(),
      CurrentTimeProvider(),
    );
    navigator = MockSeedHoldersNavigator();
    presenter = SeedHoldersPresenter(
      model,
      navigator,
      SeedsMocks.getSeedholdersUseCase,
    );
  });
}
