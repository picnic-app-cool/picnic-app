import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/features/posts/image_post/image_post_initial_params.dart';
import 'package:picnic_app/features/posts/image_post/image_post_presentation_model.dart';
import 'package:picnic_app/features/posts/image_post/image_post_presenter.dart';

import '../../../mocks/stubs.dart';
import '../mocks/posts_mock_definitions.dart';

void main() {
  late ImagePostPresentationModel model;
  late ImagePostPresenter presenter;
  late MockImagePostNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter.navigator, isNotNull);
      expect(presenter.state, model);
    },
  );

  setUp(() {
    model = ImagePostPresentationModel.initial(
      ImagePostInitialParams(
        reportId: Stubs.id,
        post: Stubs.imagePost,
      ),
    );
    navigator = MockImagePostNavigator();
    presenter = ImagePostPresenter(
      model,
      navigator,
    );
  });
}
