import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/deeplink_handler/domain/model/deep_link_post.dart';
import 'package:picnic_app/features/posts/domain/model/view_post_failure.dart';
import 'package:picnic_app/features/posts/post_details/post_details_initial_params.dart';
import 'package:picnic_app/features/posts/post_details/post_details_presentation_model.dart';
import 'package:picnic_app/features/posts/post_details/post_details_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/posts_mock_definitions.dart';
import '../mocks/posts_mocks.dart';

void main() {
  late PostDetailsPresenter presenter;
  late MockPostDetailsNavigator navigator;

  void _initPresenter({PostDetailsInitialParams? initialParams}) {
    presenter = PostDetailsPresenter(
      PostDetailsPresentationModel.initial(
        initialParams ?? PostDetailsInitialParams(post: Stubs.imagePost),
        Mocks.userStore,
      ),
      navigator,
      Mocks.deletePostsUseCase,
      Mocks.viewPostUseCase,
      Mocks.userStore,
      PostsMocks.getPostUseCase,
    );
  }

  test(
    'should properly call viewPost if opened from deeplink',
    () async {
      when(() => Mocks.viewPostUseCase.execute(postId: any(named: 'postId'))) //
          .thenSuccess((_) => unit);
      when(() => PostsMocks.getPostUseCase.execute(postId: any(named: 'postId'))) //
          .thenSuccess((_) => Stubs.textPost);
      _initPresenter(
        initialParams: PostDetailsInitialParams.fromDeepLink(
          deepLink: DeepLinkPost.fromUri(
            Uri.parse('https://picnic.zone/post/222cbe60-8ad7-4378-a3a1-168fb0e5f170'),
          ),
        ),
      );

      //WHEN
      await presenter.onInit();

      verify(
        () => Mocks.viewPostUseCase.execute(postId: const Id("222cbe60-8ad7-4378-a3a1-168fb0e5f170")),
      );
      verify(
        () => PostsMocks.getPostUseCase.execute(postId: const Id("222cbe60-8ad7-4378-a3a1-168fb0e5f170")),
      );
    },
  );

  test('verify that view post is called onInitPresenter', () async {
    _initPresenter();
    // GIVEN
    when(() => Mocks.viewPostUseCase.execute(postId: Stubs.imagePost.id)).thenAnswer((_) => successFuture(unit));

    // WHEN
    await presenter.onInit();

    // THEN
    verify(() => Mocks.viewPostUseCase.execute(postId: Stubs.id));
  });

  test(
    'failing viewPostUseCase should not show error to the user',
    () async {
      _initPresenter();
      // GIVEN
      when(() => Mocks.viewPostUseCase.execute(postId: Stubs.imagePost.id))
          .thenFailure((_) => const ViewPostFailure.unknown());

      // WHEN
      await presenter.onInit();

      // THEN
      verify(() => Mocks.viewPostUseCase.execute(postId: Stubs.id));
      verifyNoMoreInteractions(navigator);
    },
  );

  setUp(() {
    whenListen(
      Mocks.userStore,
      Stream.fromIterable([Stubs.privateProfile]),
    );
    when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);

    navigator = MockPostDetailsNavigator();
  });
}
