import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/posts/comment_chat/comment_chat_presentation_model.dart';
import 'package:picnic_app/features/posts/comment_chat/comment_chat_presenter.dart';
import 'package:picnic_app/features/posts/domain/model/post_details_mode.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/post_overlay/post_overlay_presentation_model.dart';
import 'package:picnic_app/features/posts/post_overlay/post_overlay_presenter.dart';
import 'package:picnic_app/features/posts/text_post_feed/text_post_feed_navigator.dart';
import 'package:picnic_app/features/posts/text_post_feed/text_post_feed_presentation_model.dart';

class TextPostFeedPresenter extends Cubit<TextPostFeedViewModel> with SubscriptionsMixin {
  TextPostFeedPresenter(
    TextPostFeedPresentationModel model,
    this.navigator,
    this.commentChatPresenter,
    this.postOverlayPresenter,
  ) : super(model) {
    listenTo<CommentChatViewModel>(
      stream: commentChatPresenter.stream,
      subscriptionId: _commentChatViewModelSubscription,
      onChange: (commentChatViewModel) {
        tryEmit(_model.copyWith(commentChatViewModel: commentChatViewModel));
      },
    );
    listenTo<PostOverlayViewModel>(
      stream: postOverlayPresenter.stream,
      subscriptionId: _postOverlayPresentationModelSubscription,
      onChange: (postOverlayViewModel) {
        tryEmit(_model.copyWith(postOverlayViewModel: postOverlayViewModel));
      },
    );
  }

  final TextPostFeedNavigator navigator;
  final CommentChatPresenter commentChatPresenter;
  final PostOverlayPresenter postOverlayPresenter;

  static const _commentChatViewModelSubscription = "commentChatViewModelSubscription";
  static const _postOverlayPresentationModelSubscription = "postOverlayPresentationModelSubscription";

  // ignore: unused_element
  TextPostFeedPresentationModel get _model => state as TextPostFeedPresentationModel;

  Future<void> onInit() async {
    if (_model.mode != PostDetailsMode.preview) {
      await commentChatPresenter.onInit();
      await postOverlayPresenter.onInit();
    }
  }

  void onTapUpload() => notImplemented();

  void postUpdated(Post post) {
    tryEmit(_model.copyWith(post: post));
    _model.onPostUpdatedCallback?.call(_model.post);
  }

  Future<void> onTapShowMore() async {
    await postOverlayPresenter.onTapChat();
    await commentChatPresenter.loadComments(fromScratch: true);
  }
}
