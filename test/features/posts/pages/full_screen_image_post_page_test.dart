import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/posts/full_screen_image/full_screen_image_post_initial_params.dart';
import 'package:picnic_app/features/posts/full_screen_image/full_screen_image_post_navigator.dart';
import 'package:picnic_app/features/posts/full_screen_image/full_screen_image_post_page.dart';
import 'package:picnic_app/features/posts/full_screen_image/full_screen_image_post_presentation_model.dart';
import 'package:picnic_app/features/posts/full_screen_image/full_screen_image_post_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';

Future<void> main() async {
  late FullScreenImagePostPage page;
  late FullScreenImagePostInitialParams initParams;
  late FullScreenImagePostPresentationModel model;
  late FullScreenImagePostPresenter presenter;
  late FullScreenImagePostNavigator navigator;

  void initMvp() {
    when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);
    whenListen(
      Mocks.userStore,
      Stream.fromIterable([Stubs.privateProfile]),
    );
    initParams = FullScreenImagePostInitialParams(post: Stubs.imagePost);
    model = FullScreenImagePostPresentationModel.initial(
      initParams,
      Mocks.userStore,
    );
    navigator = FullScreenImagePostNavigator(Mocks.appNavigator);
    presenter = FullScreenImagePostPresenter(
      model,
      navigator,
      Mocks.deletePostsUseCase,
    );

    getIt.registerFactoryParam<FullScreenImagePostPresenter, FullScreenImagePostInitialParams, dynamic>(
      (initialParams, _) => presenter,
    );
    page = FullScreenImagePostPage(initialParams: initParams);
  }

  await screenshotTest(
    "full_screen_image_post_page",
    setUp: () async {
      initMvp();
    },
    pageBuilder: () => page,
  );
}
