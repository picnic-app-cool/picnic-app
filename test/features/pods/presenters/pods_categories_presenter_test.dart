import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/features/pods/pods_categories_initial_params.dart';
import 'package:picnic_app/features/pods/pods_categories_presentation_model.dart';
import 'package:picnic_app/features/pods/pods_categories_presenter.dart';

import '../../../mocks/mocks.dart';
import '../mocks/pods_mock_definitions.dart';
import '../mocks/pods_mocks.dart';

void main() {
  late PodsCategoriesPresentationModel model;
  late PodsCategoriesPresenter presenter;
  late MockPodsCategoriesNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  setUp(() {
    model = PodsCategoriesPresentationModel.initial(const PodsCategoriesInitialParams());
    navigator = MockPodsCategoriesNavigator();
    presenter = PodsCategoriesPresenter(
      model,
      navigator,
      PodsMocks.getPodsTagsUseCase,
      Mocks.searchPodsUseCase,
    );
  });
}
