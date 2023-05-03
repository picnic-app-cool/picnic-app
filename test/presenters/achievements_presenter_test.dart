import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/features/profile/achievements/achievements_initial_params.dart';
import 'package:picnic_app/features/profile/achievements/achievements_presentation_model.dart';
import 'package:picnic_app/features/profile/achievements/achievements_presenter.dart';

import '../mocks/mock_definitions.dart';

void main() {
  late AchievementsPresentationModel model;
  late AchievementsPresenter presenter;
  late MockAchievementsNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter.state, isNotNull); // TODO implement this
    },
  );

  setUp(() {
    model = AchievementsPresentationModel.initial(const AchievementsInitialParams());
    navigator = MockAchievementsNavigator();
    presenter = AchievementsPresenter(
      model,
      navigator,
    );
  });
}
