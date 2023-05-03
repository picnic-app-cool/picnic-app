import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/features/circles/add_word_blacklist/add_black_list_word_initial_params.dart';
import 'package:picnic_app/features/circles/add_word_blacklist/add_black_list_word_presentation_model.dart';
import 'package:picnic_app/features/circles/add_word_blacklist/add_black_list_word_presenter.dart';

import '../../../mocks/stubs.dart';
import '../mocks/circles_mock_definitions.dart';
import '../mocks/circles_mocks.dart';

void main() {
  late AddBlackListWordPresentationModel model;
  late AddBlackListWordPresenter presenter;
  late MockAddBlackListWordNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  setUp(() {
    model = AddBlackListWordPresentationModel.initial(
      AddBlackListWordInitialParams(circleId: Stubs.id),
    );
    navigator = MockAddBlackListWordNavigator();
    presenter = AddBlackListWordPresenter(
      model,
      navigator,
      CirclesMocks.addBlacklistedWordsUseCase,
      CirclesMocks.removeBlacklistedWordsUseCase,
    );
  });
}
