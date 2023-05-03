import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/features/seeds/domain/model/seed.dart';
import 'package:picnic_app/features/seeds/sell_seeds/sell_seeds_navigator.dart';
import 'package:picnic_app/features/seeds/sell_seeds_first_step/sell_seeds_first_step_initial_params.dart';
import 'package:picnic_app/features/seeds/sell_seeds_first_step/sell_seeds_first_step_presentation_model.dart';
import 'package:picnic_app/features/seeds/sell_seeds_first_step/sell_seeds_first_step_presenter.dart';

import '../../../mocks/mocks.dart';
import '../mocks/seeds_mocks.dart';

void main() {
  late SellSeedsFirstStepPresentationModel model;
  late SellSeedsFirstStepPresenter presenter;
  late SellSeedsNavigator sellSeedsNavigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  setUp(() {
    final key = SellSeedsNavigatorKey();
    model = SellSeedsFirstStepPresentationModel.initial(
      SellSeedsFirstStepInitialParams(
        onChooseCircle: (Seed seed) => {},
      ),
    );
    sellSeedsNavigator = SellSeedsNavigator(Mocks.appNavigator, key);
    presenter = SellSeedsFirstStepPresenter(
      model,
      sellSeedsNavigator,
      SeedsMocks.getSeedsUseCase,
      Mocks.debouncer,
    );
  });
}
