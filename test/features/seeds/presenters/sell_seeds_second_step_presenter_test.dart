import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/features/seeds/sell_seeds/sell_seeds_navigator.dart';
import 'package:picnic_app/features/seeds/sell_seeds_second_step/sell_seeds_second_step_initial_params.dart';
import 'package:picnic_app/features/seeds/sell_seeds_second_step/sell_seeds_second_step_presentation_model.dart';
import 'package:picnic_app/features/seeds/sell_seeds_second_step/sell_seeds_second_step_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../mocks/seeds_mocks.dart';

void main() {
  late SellSeedsSecondStepPresentationModel model;
  late SellSeedsSecondStepPresenter presenter;
  late SellSeedsNavigator sellSeedsNavigator;

  test(
    'tapping on send offer should be disabled if amount is smaller or equal to 0',
    () async {
      //GIVEN
      presenter.emit(model.copyWith(seed: Stubs.seed, recipient: Stubs.publicProfile));

      // WHEN
      presenter.onChangedSeedAmount(0);

      // THEN
      expect(presenter.state.sendOfferEnabled, false);
    },
  );

  test(
    'tapping on send offer should be enabled if amount is bigger than 0 and recipient is not empty',
    () async {
      //GIVEN
      presenter.emit(model.copyWith(seed: Stubs.seed, recipient: Stubs.publicProfile));

      // WHEN
      presenter.onChangedSeedAmount(1);

      // THEN
      expect(presenter.state.sendOfferEnabled, true);
    },
  );

  test(
    'tapping on send offer should be disabled if amount is bigger than amountAvailable',
    () async {
      // GIVEN
      presenter.emit(model.copyWith(seed: Stubs.seed, recipient: Stubs.publicProfile));

      // WHEN
      presenter.onChangedSeedAmount(1000);

      // THEN
      expect(presenter.state.sendOfferEnabled, false);
    },
  );

  test(
    'tapping on send offer should be enabled if amount is smaller than amountAvailable',
    () async {
      // GIVEN
      presenter.emit(model.copyWith(seed: Stubs.seed.copyWith(amountAvailable: 1000), recipient: Stubs.publicProfile));

      // WHEN
      presenter.onChangedSeedAmount(999);

      // THEN
      expect(presenter.state.sendOfferEnabled, true);
    },
  );

  setUp(() {
    final key = SellSeedsNavigatorKey();
    model = SellSeedsSecondStepPresentationModel.initial(
      SellSeedsSecondStepInitialParams(
        seed: Stubs.seed,
        onTransferSeedsCallback: () {},
      ),
    );
    sellSeedsNavigator = SellSeedsNavigator(Mocks.appNavigator, key);
    presenter = SellSeedsSecondStepPresenter(
      model,
      sellSeedsNavigator,
      SeedsMocks.sellSeedsUseCase,
      SeedsMocks.transferSeedsUseCase,
    );
  });
}
