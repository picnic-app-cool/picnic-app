import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/use_cases/delete_posts_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/view_post_use_case.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/utils/throttler.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/single_feed/single_feed_navigator.dart';
import 'package:picnic_app/features/posts/single_feed/single_feed_presentation_model.dart';
import 'package:picnic_app/features/reports/domain/model/report_entity_type.dart';
import 'package:picnic_app/features/reports/report_form/report_form_initial_params.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/navigation/confirmation_bottom_sheet_route.dart';

class SingleFeedPresenter extends Cubit<SingleFeedViewModel> {
  SingleFeedPresenter(
    super.model,
    this.navigator,
    this._deletePostsUseCase,
    this._viewPostUseCase,
    this._throttler,
  );

  final SingleFeedNavigator navigator;

  final DeletePostsUseCase _deletePostsUseCase;
  final ViewPostUseCase _viewPostUseCase;
  final Throttler _throttler;

  static const _reachedListEndToastThrottleDuration = Duration(seconds: 3);

  // ignore: unused_element
  SingleFeedPresentationModel get _model => state as SingleFeedPresentationModel;

  Future<void> loadMore() => _model.loadMoreCallback().doOn(
        success: (posts) => tryEmit(_model.byAppendingPosts(posts)),
        fail: (fail) => navigator.showError(fail),
      );

  Future<void> refresh() => _model
      .refreshCallback()
      .observeStatusChanges(
        (result) => tryEmit(_model.copyWith(refreshResult: result)),
      )
      .doOn(
        success: (posts) => tryEmit(_model.copyWith(posts: posts)),
        fail: (fail) => navigator.showError(fail),
      );

  void onPostUpdated(Post updatedPost) {
    tryEmit(_model.byUpdatingPost(updatedPost));
    _model.onPostsListUpdatedCallback(_model.posts);
  }

  void postDidAppear(Post post) {
    if (post == _model.currentPost) {
      return;
    }
    tryEmit(_model.copyWith(currentPost: post));

    //intentionally not showing error if viewPost fails
    _viewPostUseCase.execute(postId: post.id);
  }

  Future<void> onTapSort() async {
    final option = await _model.sortingHandler.onTapSort();
    if (option != null) {
      await refresh();
    }
  }

  void onOverscroll() {
    if (_model.posts.hasNextPage) {
      return;
    }
    _throttler.throttle(
      _reachedListEndToastThrottleDuration,
      () => navigator.showReachedListEndToast(),
    );
  }

  void onReport() {
    _openReportPostForm();
  }

  void onTapMoreOptions() => navigator.onTapMore(
        onTapDeletePost: _model.canDeletePost
            ? () {
                navigator.close();
                _openDeletePostForm();
              }
            : null,
        onTapReport: _model.canReportPost ? _openReportPostForm : null,
      );

  @override
  Future<void> close() {
    _throttler.cancel();
    return super.close();
  }

  void _openDeletePostForm() {
    navigator.showConfirmationBottomSheet(
      title: appLocalizations.deletePost,
      message: appLocalizations.deletePostConfirmationMessage,
      primaryAction: ConfirmationAction(
        roundedButton: true,
        title: appLocalizations.deletePost,
        action: () {
          navigator.close();
          _deletePost(_model.currentPost);
        },
      ),
      secondaryAction: ConfirmationAction.negative(
        action: () => navigator.close(),
      ),
    );
  }

  Future<void> _deletePost(Post post) => _deletePostsUseCase.execute(postIds: [post.id]).doOn(
        success: (success) {
          _model.onPostsListUpdatedCallback(
            _model.byRemovingPost(post).posts,
          );
          navigator.close();
        },
        fail: (fail) => navigator.showError(fail.displayableFailure()),
      );

  void _openReportPostForm() => navigator.openReportForm(
        ReportFormInitialParams(
          entityId: _model.currentPost.id,
          circleId: _model.currentPost.circle.id,
          reportEntityType: ReportEntityType.post,
          contentAuthorId: _model.currentPost.author.id,
        ),
      );
}
