import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/posts/text_post_creation/text_post_creation_initial_params.dart';
import 'package:picnic_app/features/posts/text_post_creation/text_post_creation_presentation_model.dart';
import 'package:picnic_app/features/posts/text_post_creation/text_post_creation_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../mocks/posts_mock_definitions.dart';

void main() {
  late TextPostCreationPresentationModel model;
  late TextPostCreationPresenter presenter;
  late MockTextPostCreationNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  setUp(() {
    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);
    model = TextPostCreationPresentationModel.initial(
      TextPostCreationInitialParams(onTapPost: (_) {}),
      Mocks.featureFlagsStore,
    );
    navigator = MockTextPostCreationNavigator();
    presenter = TextPostCreationPresenter(
      model,
      navigator,
    );
  });
}
