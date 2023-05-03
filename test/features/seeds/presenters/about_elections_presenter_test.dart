import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/features/seeds/about_elections/about_elections_initial_params.dart';
import 'package:picnic_app/features/seeds/about_elections/about_elections_presentation_model.dart';
import 'package:picnic_app/features/seeds/about_elections/about_elections_presenter.dart';

import '../mocks/seeds_mock_definitions.dart';

void main() {
  late AboutElectionsPresentationModel model;
  late AboutElectionsPresenter presenter;
  late MockAboutElectionsNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  setUp(() {
    model = AboutElectionsPresentationModel.initial(const AboutElectionsInitialParams());
    navigator = MockAboutElectionsNavigator();
    presenter = AboutElectionsPresenter(
      model,
      navigator,
    );
  });
}
