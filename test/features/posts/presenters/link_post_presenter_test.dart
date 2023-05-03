import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/features/posts/link_post/link_post_initial_params.dart';
import 'package:picnic_app/features/posts/link_post/link_post_presentation_model.dart';
import 'package:picnic_app/features/posts/link_post/link_post_presenter.dart';

import '../../../mocks/stubs.dart';
import '../mocks/posts_mock_definitions.dart';

void main() {
  late LinkPostPresentationModel model;
  late LinkPostPresenter presenter;
  late MockLinkPostNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  setUp(() {
    model = LinkPostPresentationModel.initial(
      LinkPostInitialParams(
        reportId: Stubs.id,
        post: Stubs.linkPost,
      ),
    );
    navigator = MockLinkPostNavigator();
    presenter = LinkPostPresenter(
      model,
      navigator,
    );
  });
}
