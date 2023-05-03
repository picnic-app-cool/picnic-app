import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/posts/posts_list/posts_list_info_provider.dart';
import 'package:picnic_app/features/posts/video_post/video_post_initial_params.dart';
import 'package:picnic_app/features/posts/video_post/video_post_presentation_model.dart';
import 'package:picnic_app/features/posts/video_post/video_post_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../mocks/posts_mock_definitions.dart';
import '../mocks/posts_mocks.dart';

void main() {
  late VideoPostPresenter presenter;
  late MockVideoPostNavigator navigator;

  void _initPresenter({
    PostsListInfoProvider? postsListInfoProvider,
  }) {
    navigator = MockVideoPostNavigator();
    presenter = VideoPostPresenter(
      VideoPostPresentationModel.initial(
        VideoPostInitialParams(
          post: Stubs.videoPost,
          reportId: Stubs.id,
          postsListInfoProvider: postsListInfoProvider,
        ),
      ),
      navigator,
      Mocks.videoMuteStore,
      Mocks.currentTimeProvider,
    );
  }

  test(
    'missing postsListInfoProvider should assume video is currently visible',
    () {
      _initPresenter();
      presenter.onInit();
      expect(presenter.state.isCurrentlyVisible, true);
    },
  );

  test(
    'having postsListInfoProvider should assume video is currently invisible until explicit callback on postDidAppear',
    () {
      _initPresenter(postsListInfoProvider: PostsMocks.postsListInfoProvider);
      presenter.onInit();
      expect(presenter.state.isCurrentlyVisible, false);
    },
  );

  setUp(() {
    when(() => Mocks.videoMuteStore.muted).thenReturn(false);
    whenListen(
      Mocks.videoMuteStore,
      Stream.fromIterable([false]),
    );
  });
}
