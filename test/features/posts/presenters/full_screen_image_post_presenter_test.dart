import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/full_screen_image/full_screen_image_post_initial_params.dart';
import 'package:picnic_app/features/posts/full_screen_image/full_screen_image_post_presentation_model.dart';
import 'package:picnic_app/features/posts/full_screen_image/full_screen_image_post_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../mocks/posts_mock_definitions.dart';

void main() {
  late FullScreenImagePostPresentationModel model;
  late FullScreenImagePostPresenter presenter;
  late MockFullScreenImagePostNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull);
    },
  );

  setUp(() {
    when(() => Mocks.userStore.privateProfile).thenAnswer((_) => Stubs.privateProfile);

    model = FullScreenImagePostPresentationModel.initial(
      const FullScreenImagePostInitialParams(post: Post.empty()),
      Mocks.userStore,
    );
    navigator = MockFullScreenImagePostNavigator();
    presenter = FullScreenImagePostPresenter(
      model,
      navigator,
      Mocks.deletePostsUseCase,
    );
  });
}
