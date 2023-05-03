import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/features/seeds/sell_seeds/sell_seeds_initial_params.dart';
import 'package:picnic_app/features/seeds/sell_seeds/sell_seeds_presentation_model.dart';
import 'package:picnic_app/features/seeds/sell_seeds/sell_seeds_presenter.dart';

import '../mocks/seeds_mock_definitions.dart';

void main() {
  late SellSeedsPresentationModel model;
  late SellSeedsPresenter presenter;
  late MockSellSeedsNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  setUp(() {
    model = SellSeedsPresentationModel.initial(SellSeedsInitialParams(onTransferSeedsCallback: () {}));
    navigator = MockSellSeedsNavigator();
    presenter = SellSeedsPresenter(
      model,
      navigator,
    );
  });
}
