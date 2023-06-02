import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/analytics/domain/model/analytics_event.dart';
import 'package:picnic_app/features/analytics/domain/model/tap/analytics_tap_target.dart';
import 'package:picnic_app/features/analytics/domain/use_cases/log_analytics_event_use_case.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/domain/use_cases/get_circle_details_use_case.dart';
import 'package:picnic_app/features/posts/domain/model/get_feed_posts_list_failure.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/domain/use_cases/get_feed_posts_list_use_case.dart';
import 'package:picnic_app/features/posts/post_creation_index/post_creation_index_initial_params.dart';
import 'package:picnic_app/features/posts/posts_list/posts_list_initial_params.dart';
import 'package:picnic_app/features/posts/posts_list/posts_list_navigator.dart';
import 'package:picnic_app/features/posts/posts_list/posts_list_presentation_model.dart';
import 'package:picnic_app/features/reports/domain/model/report_entity_type.dart';
import 'package:picnic_app/features/reports/report_form/report_form_initial_params.dart';

class PostsListPresenter extends Cubit<PostsListViewModel> {
  PostsListPresenter(
    PostsListPresentationModel model,
    this.navigator,
    this._getPostsListUseCase,
    this._logAnalyticsEventUseCase,
    this._getCircleDetailsUseCase,
  ) : super(model);

  final PostsListNavigator navigator;
  final GetFeedPostsListUseCase _getPostsListUseCase;
  final LogAnalyticsEventUseCase _logAnalyticsEventUseCase;
  final GetCircleDetailsUseCase _getCircleDetailsUseCase;

  // ignore: unused_element
  PostsListPresentationModel get _model => state as PostsListPresentationModel;

  Future<void> init() async {
    await _getFromCache();
    await loadMore();
  }

  void updateInitialParams(PostsListInitialParams initialParams) {
    final refreshNeeded = _model.localPost != initialParams.localPost && initialParams.localPost != const Post.empty();
    tryEmit(
      _model.copyWith(
        gridView: initialParams.gridView,
        feed: initialParams.feed,
        localPost: initialParams.localPost,
        ignoreLocalPost: !refreshNeeded && _model.ignoreLocalPost,
        onPostChangedCallback: initialParams.onPostChanged,
      ),
    );
    if (refreshNeeded) {
      refresh(removeLocalPost: false);
    }
  }

  Future<void> loadMore() {
    return _getPosts().networkResult.observeStatusChanges((result) {
      tryEmit(_model.copyWith(postsListResult: result));
    }).doOn(
      success: (list) {
        tryEmit(
          _model.cursor.isFirstPage ? _model.copyWith(remotePosts: list) : _model.byAppendingPostsList(list),
        );
      },
    );
  }

  Future<void> onRefresh() async => refresh(removeLocalPost: true);

  Future<void> refresh({required bool removeLocalPost}) async {
    if (_model.isRefreshing) {
      return;
    }
    tryEmit(_model.copyWith(refreshResult: const RefreshResult.empty()));
    await _getPosts()
        .networkResult
        .observeStatusChanges(
          (result) => tryEmit(_model.copyWith(refreshResult: result)),
        )
        .doOn(
      success: (list) {
        tryEmit(
          _model.copyWith(
            remotePosts: list,
            ignoreLocalPost: removeLocalPost || _model.ignoreLocalPost,
          ),
        );
        if (list.items.isNotEmpty) {
          postDidAppear(list.items.first);
        }
      },
    );
  }

  void postDidAppear(Post post) {
    _model.onPostChangedCallback(post);
  }

  void onTapAuthor(Id userId) {
    navigator.openProfile(userId: userId);
  }

  void onTapReport(Post post) {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.postReportLongTap,
      ),
    );
    navigator.openReportForm(
      ReportFormInitialParams(
        circleId: post.circle.id,
        entityId: post.id,
        reportEntityType: ReportEntityType.post,
        contentAuthorId: post.author.id,
      ),
    );
  }

  void onTapCreatePost() {
    _getCircleDetailsUseCase.execute(circleId: _model.feed.circleId).doOn(
          success: _openPostCreation,
          fail: (fail) => _openPostCreation(const Circle.empty().copyWith(id: _model.feed.circleId)),
        );
  }

  void onPostUpdated(Post post) {
    tryEmit(_model.byUpdatingPostInList(post));
    _model.onPostChangedCallback(post);
  }

  void _openPostCreation(Circle? circle) => navigator.openPostCreation(
        PostCreationIndexInitialParams(
          circle: circle,
        ),
      );

  /// loads list of posts from cache, if available
  Future<void> _getFromCache() => _getPosts(
        cachePolicy: CachePolicy.cacheOnly,
      ).firstResult.doOn(
        success: (posts) {
          tryEmit(
            _model.copyWith(
              remotePosts: _model.remotePosts.copyWith(
                // we only care about posts and not cursor info, since we want to have network call in [loadMore]
                // to start completely from scratch
                items: posts.items,
              ),
            ),
          );
        },
        //we silently ignore any errors and just proceed with loading posts from network
      );

  Stream<CacheableResult<GetFeedPostsListFailure, PaginatedList<Post>>> _getPosts({
    CachePolicy? cachePolicy,
  }) {
    return _getPostsListUseCase.execute(
      feed: _model.feed,
      searchQuery: '',
      cursor: _model.cursor,
      cachePolicy: cachePolicy,
    );
  }
}
