import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/features/settings/community_guidelines/community_guidelines_initial_params.dart';
import 'package:picnic_app/features/settings/community_guidelines/community_guidelines_presentation_model.dart';
import 'package:picnic_app/features/settings/community_guidelines/community_guidelines_presenter.dart';

import '../mocks/settings_mock_definitions.dart';

void main() {
  late CommunityGuidelinesPresentationModel model;
  late CommunityGuidelinesPresenter presenter;
  late MockCommunityGuidelinesNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  setUp(() {
    model = CommunityGuidelinesPresentationModel.initial(const CommunityGuidelinesInitialParams());
    navigator = MockCommunityGuidelinesNavigator();
    presenter = CommunityGuidelinesPresenter(
      model,
      navigator,
    );
  });
}
