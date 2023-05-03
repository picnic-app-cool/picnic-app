import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/features/avatar_selection/avatar_selection_initial_params.dart';
import 'package:picnic_app/features/avatar_selection/avatar_selection_presentation_model.dart';
import 'package:picnic_app/features/avatar_selection/avatar_selection_presenter.dart';

import '../mocks/avatar_selection_mock_definitions.dart';

void main() {
  late AvatarSelectionPresentationModel model;
  late AvatarSelectionPresenter presenter;
  late MockAvatarSelectionNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  setUp(() {
    model = AvatarSelectionPresentationModel.initial(const AvatarSelectionInitialParams(emoji: '😄'));
    navigator = MockAvatarSelectionNavigator();
    presenter = AvatarSelectionPresenter(
      model,
      navigator,
    );
  });
}
