import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/posts/comment_chat/comment_chat_initial_params.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/post_overlay/post_overlay_presentation_model.dart';
import 'package:picnic_app/features/posts/post_overlay/post_overlay_presenter.dart';
import 'package:picnic_app/features/posts/text_post_profile/text_post_profile_navigator.dart';
import 'package:picnic_app/features/posts/text_post_profile/text_post_profile_presentation_model.dart';

class TextPostProfilePresenter extends Cubit<TextPostProfileViewModel> with SubscriptionsMixin {
  TextPostProfilePresenter(
    TextPostProfilePresentationModel model,
    this.navigator,
    this.postOverlayPresenter,
  ) : super(model) {
    listenTo<PostOverlayViewModel>(
      stream: postOverlayPresenter.stream,
      subscriptionId: _postOverlayPresentationModelSubscription,
      onChange: (postOverlayViewModel) {
        tryEmit(_model.copyWith(postOverlayViewModel: postOverlayViewModel));
      },
    );
  }

  final TextPostProfileNavigator navigator;
  final PostOverlayPresenter postOverlayPresenter;

  static const _postOverlayPresentationModelSubscription = "postOverlayPresentationModelSubscription";

  // ignore: unused_element
  TextPostProfilePresentationModel get _model => state as TextPostProfilePresentationModel;

  Future<void> onInit() async {
    await postOverlayPresenter.onInit();
  }

  void onTapUpload() => notImplemented();

  void postUpdated(Post post) {
    tryEmit(_model.copyWith(post: post));
    _model.onPostUpdatedCallback?.call(_model.post);
  }

  void onTapShowMore() {
    navigator.openCommentChat(
      CommentChatInitialParams(
        post: _model.post,
      ),
    );
  }
}
