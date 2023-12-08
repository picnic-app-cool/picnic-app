import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/domain/use_cases/delete_posts_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/view_post_use_case.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/post_route_result.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/domain/use_cases/get_post_use_case.dart';
import 'package:picnic_app/features/posts/post_details/post_details_navigator.dart';
import 'package:picnic_app/features/posts/post_details/post_details_presentation_model.dart';
import 'package:picnic_app/features/posts/post_share/post_share_initial_params.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/navigation/confirmation_bottom_sheet_route.dart';

class PostDetailsPresenter extends Cubit<PostDetailsViewModel> with SubscriptionsMixin {
  PostDetailsPresenter(
    PostDetailsPresentationModel model,
    this.navigator,
    this._deletePostsUseCase,
    this._viewPostUseCase,
    UserStore _userStore,
    this._getPostUseCase,
  ) : super(model) {
    listenTo<PrivateProfile>(
      stream: _userStore.stream,
      subscriptionId: _userStoreSubscription,
      onChange: (privateProfile) {
        tryEmit(_model.copyWith(privateProfile: privateProfile));
      },
    );
  }

  final PostDetailsNavigator navigator;

  static const _userStoreSubscription = "postDetailsUserStoreSubscription";
  final DeletePostsUseCase _deletePostsUseCase;
  final ViewPostUseCase _viewPostUseCase;
  final GetPostUseCase _getPostUseCase;

  // ignore: unused_element
  PostDetailsPresentationModel get _model => state as PostDetailsPresentationModel;

  Future<void> onInit() async {
    if (_model.post == const Post.empty() && _model.postId != const Id.empty()) {
      await _fetchPostDetails();
      // Because the post is empty since it comes from a deeplink, it is necessary to fetch the data first
      // otherwise we wrongly use short id to increase post view
      await _increasePostViews(postId: _model.post.id);
    } else {
      await _increasePostViews(postId: _model.postId);
    }
  }

  void onTapDeletePost() {
    navigator.close();
    navigator.showConfirmationBottomSheet(
      title: appLocalizations.deletePost,
      message: appLocalizations.deletePostConfirmationMessage,
      primaryAction: ConfirmationAction(
        roundedButton: true,
        title: appLocalizations.deletePost,
        action: () {
          navigator.close();
          _deletePostsUseCase.execute(postIds: [_model.postId]).doOn(
            success: (success) => navigator.closeWithResult(const PostRouteResult(postRemoved: true)),
            fail: (fail) => navigator.showError(fail.displayableFailure()),
          );
        },
      ),
      secondaryAction: ConfirmationAction.negative(
        action: () => navigator.close(),
      ),
    );
  }

  void onLongPressPost() => navigator.openPostShare(PostShareInitialParams(post: _model.post));

  void onPostUpdated(Post post) {
    tryEmit(_model.copyWith(post: post));
    _model.onPostUpdatedCallback?.call(post);
  }

  void onUserTap() {
    _model.deleteEnabled ? _onTapMoreAuthorModOrDirector() : _onTapMorePublic();
  }

  void _onTapMoreAuthorModOrDirector() => navigator.onTapMore(
        onTapDeletePost: onTapDeletePost,
        onTapReport: _model.isModOrDirector ? onLongPressPost : null,
      );

  void _onTapMorePublic() => navigator.onTapMore(
        onTapReport: onLongPressPost,
      );

  //intentionally not showing error if viewPost fails
  Future<void> _increasePostViews({required Id postId}) => _viewPostUseCase.execute(postId: postId);

  Future<void> _fetchPostDetails() => _getPostUseCase
      .execute(postId: _model.postId) //
      .observeStatusChanges((result) => tryEmit(_model.copyWith(getPostResult: result)))
      .doOn(success: onPostUpdated)
      .doOn(fail: (fail) => navigator.showError(fail.displayableFailure()));
}
