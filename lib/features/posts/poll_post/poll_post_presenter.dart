import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/fx_effect_overlay/lottie_fx_effect.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/comment_preview.dart';
import 'package:picnic_app/features/posts/domain/model/post_route_result.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/domain/model/vote_in_poll_input.dart';
import 'package:picnic_app/features/posts/domain/use_cases/vote_in_poll_use_case.dart';
import 'package:picnic_app/features/posts/poll_post/poll_post_navigator.dart';
import 'package:picnic_app/features/posts/poll_post/poll_post_presentation_model.dart';
import 'package:picnic_app/ui/widgets/poll_post/picnic_poll_post.dart';

class PollPostPresenter extends Cubit<PollPostViewModel> with SubscriptionsMixin {
  PollPostPresenter(
    PollPostPresentationModel model,
    this.navigator,
    this._voteInPollUseCase,
    this._userStore,
  ) : super(model) {
    listenTo<PrivateProfile>(
      stream: _userStore.stream,
      subscriptionId: _userStoreSubscription,
      onChange: (privateProfile) {
        tryEmit(_model.copyWith(user: privateProfile));
      },
    );
  }

  final PollPostNavigator navigator;
  final VoteInPollUseCase _voteInPollUseCase;
  final UserStore _userStore;

  static const _userStoreSubscription = "pollPostUserStoreSubscription";

  // ignore: unused_element
  PollPostPresentationModel get _model => state as PollPostPresentationModel;

  void onInit() {
    tryEmit(_model.copyWith(user: _userStore.privateProfile));
  }

  void onVoted(PicnicPollVote value) {
    late Id answerId;
    switch (value) {
      case PicnicPollVote.left:
        answerId = _model.pollContent.leftPollAnswer.id;
        break;
      case PicnicPollVote.right:
        answerId = _model.pollContent.rightPollAnswer.id;
        break;
    }

    final previousState = _model.pollContent;

    // this updates the UI immediately
    _onVoted(answerId);

    _voteInPollUseCase
        .execute(
          VoteInPollInput(
            postId: _model.post.id,
            answerId: answerId,
          ),
        )
        .doOn(
          success: (_) => unit, // already updated
          fail: (_) {
            // Undo post vote
            tryEmit(_model.byUpdatingPostContent(pollContent: previousState));
          },
        );
  }

  void postUpdated(Post post) {
    tryEmit(_model.copyWith(post: post));
    _model.onPostUpdatedCallback?.call(post);
  }

  void reportActionTaken(PostRouteResult result) => navigator.closeWithResult(result);

  void onUpdatedComments(List<CommentPreview> comments) => tryEmit(_model.copyWith(comments: comments));

  void _onVoted(Id answerId) {
    tryEmit(_model.byUpdatingPostVotedAnswer(answerId: answerId));
    _model.onPostUpdatedCallback?.call(_model.post);
    navigator.showFxEffect(LottieFxEffect.glitter());
  }
}
