import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flag_type.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/posts/comment_chat/comment_chat_initial_params.dart';
import 'package:picnic_app/features/posts/comment_chat/comment_chat_navigator.dart';
import 'package:picnic_app/features/posts/comment_chat/comment_chat_page.dart';
import 'package:picnic_app/features/posts/comment_chat/comment_chat_presentation_model.dart';
import 'package:picnic_app/features/posts/comment_chat/comment_chat_presenter.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../mocks/posts_mocks.dart';

Future<void> main() async {
  setUpAll(() {
    registerFallbackValue(const Post.empty());
  });

  void _initMvp() {
    when(() => Mocks.currentTimeProvider.currentTime).thenReturn(DateTime(2023, 3, 26));
    when(() => PostsMocks.getCommentsUseCase.execute(post: any(named: 'post')))
        .thenAnswer((_) => successFuture(Stubs.comments));
    when(() => PostsMocks.getPinnedCommentsUseCase.execute(post: any(named: 'post')))
        .thenAnswer((_) => successFuture([]));

    when(() => Mocks.userStore.privateProfile).thenAnswer((_) => Stubs.privateProfile);

    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);
  }

  Widget _buildPage({
    bool replyMode = false,
    bool disableFeatureFlags = false,
  }) {
    final flags = Stubs.featureFlags
        .disable(FeatureFlagType.commentAttachmentEnabled)
        .disable(FeatureFlagType.commentInstantCommandsEnabled);

    final initParams = CommentChatInitialParams(
      post: Stubs.textPost,
    );
    final model = CommentChatPresentationModel.initial(
      initParams,
      Mocks.featureFlagsStore,
      Mocks.userStore,
    ).copyWith(
      replyingComment: replyMode ? Stubs.comments.children[0] : null,
      featureFlags: disableFeatureFlags ? flags : null,
    );
    final navigator = CommentChatNavigator(
      Mocks.appNavigator,
      Mocks.userStore,
    );
    final presenter = CommentChatPresenter(
      model,
      navigator,
      PostsMocks.likeUnlikePostUseCase,
      PostsMocks.unreactToPostUseCase,
      Mocks.sharePostUseCase,
      PostsMocks.likeUnlikeCommentUseCase,
      PostsMocks.getCommentsUseCase,
      PostsMocks.createCommentUseCase,
      PostsMocks.deleteCommentUseCase,
      PostsMocks.getPinnedCommentsUseCase,
      PostsMocks.pinCommentUseCase,
      PostsMocks.unpinCommentUseCase,
      Mocks.joinCircleUseCase,
      Mocks.savePostToCollectionUseCase,
      PostsMocks.voteInPollUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
      Mocks.followUserUseCase,
      Mocks.userStore,
    );
    return CommentChatPage(presenter: presenter);
  }

  await screenshotTest(
    "comment_chat_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => _buildPage(),
  );

  await screenshotTest(
    "comment_chat_page_with_pinned_comment",
    setUp: () async {
      _initMvp();
      when(() => PostsMocks.getPinnedCommentsUseCase.execute(post: any(named: 'post')))
          .thenAnswer((_) => successFuture([Stubs.pinnedComment]));
    },
    pageBuilder: () => _buildPage(),
  );

  await screenshotTest(
    "comment_chat_page_disabled_feature_flags",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => _buildPage(disableFeatureFlags: true),
  );

  await screenshotTest(
    "comment_chat_page_reply",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => _buildPage(replyMode: true),
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<CommentChatPage>(
      param1: CommentChatInitialParams(
        post: Stubs.textPost,
      ),
    );
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
