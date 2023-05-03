import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/features/posts/text_post/text_post_initial_params.dart';
import 'package:picnic_app/features/posts/text_post/text_post_presentation_model.dart';
import 'package:picnic_app/features/posts/text_post/text_post_presenter.dart';

import '../../../mocks/stubs.dart';
import '../mocks/posts_mock_definitions.dart';

void main() {
  late TextPostPresentationModel model;
  late TextPostPresenter presenter;
  late MockTextPostNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter.navigator, isNotNull);
      expect(presenter.state, model);
    },
  );

  setUp(() {
    model = TextPostPresentationModel.initial(
      TextPostInitialParams(
        post: Stubs.textPost,
        reportId: Stubs.id,
      ),
    );
    navigator = MockTextPostNavigator();
    presenter = TextPostPresenter(
      model,
      navigator,
    );
  });
}
