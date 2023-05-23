import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:picnic_app/core/domain/model/basic_circle.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/stores/user_circles_store.dart';
import 'package:picnic_app/core/domain/use_cases/update_app_badge_count_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/view_post_use_case.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/analytics/domain/model/analytics_event.dart';
import 'package:picnic_app/features/analytics/domain/model/change/analytics_change_target.dart';
import 'package:picnic_app/features/analytics/domain/use_cases/log_analytics_event_use_case.dart';
import 'package:picnic_app/features/feed/domain/model/feed.dart';
import 'package:picnic_app/features/feed/domain/model/get_feeds_list_failure.dart';
import 'package:picnic_app/features/feed/domain/stores/local_feeds_store.dart';
import 'package:picnic_app/features/feed/domain/use_cases/get_feeds_list_use_case.dart';
import 'package:picnic_app/features/feed/feed_home/feed_home_navigator.dart';
import 'package:picnic_app/features/feed/feed_home/feed_home_presentation_model.dart';
import 'package:picnic_app/features/feed/feed_more/feed_more_initial_params.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/profile/domain/use_cases/get_unread_notifications_count_use_case.dart';
import 'package:picnic_app/features/profile/notifications/notifications_list_initial_params.dart';
import 'package:picnic_app/features/profile/private_profile/private_profile_initial_params.dart';

class FeedHomePresenter extends Cubit<FeedHomeViewModel> with SubscriptionsMixin {
  FeedHomePresenter(
    FeedHomePresentationModel model,
    this.navigator,
    this._getFeedsListUseCase,
    this._viewPostUseCase,
    this._logAnalyticsEventUseCase,
    this._localFeedsStore,
    this._getUnreadNotificationsCountUseCase,
    this._updateAppBadgeCountUseCase,
    UserCirclesStore userCirclesStore,
  ) : super(model) {
    listenTo<UnmodifiableListView<Feed>>(
      stream: _localFeedsStore.stream,
      subscriptionId: _localFeedsStoreSubscription,
      onChange: (localFeeds) => tryEmit(_model.copyWith(localFeeds: localFeeds)),
    );

    listenTo<PaginatedList<BasicCircle>>(
      stream: userCirclesStore.stream,
      subscriptionId: _userCirclesStoreSubscription,
      onChange: (circles) => init(),
    );
  }

  static const feedListSubscriptionId = 'init_feed_load';

  final FeedHomeNavigator navigator;
  final GetFeedsListUseCase _getFeedsListUseCase;
  final ViewPostUseCase _viewPostUseCase;
  final LogAnalyticsEventUseCase _logAnalyticsEventUseCase;
  final LocalFeedsStore _localFeedsStore;
  final GetUnreadNotificationsCountUseCase _getUnreadNotificationsCountUseCase;
  final UpdateAppBadgeCountUseCase _updateAppBadgeCountUseCase;

  static const _localFeedsStoreSubscription = "localFeedsStoreSubscription";
  static const _userCirclesStoreSubscription = "userCirclesStoreSubscription";

  static const _feedPageSize = 7;

  FeedHomePresentationModel get _model => state as FeedHomePresentationModel;

  void init() {
    _getFeedsListUseCase
        .execute(
      nextPageCursor: const Cursor.firstPage(pageSize: _feedPageSize),
    )
        .observeStatusChanges(
      onSubscribed: (subscription) {
        addSubscription(feedListSubscriptionId, subscription);
      },
      onStatusChange: (result) {
        tryEmit(_model.copyWith(remoteFeedsResult: result));
      },
      onEmit: (cacheable) {
        _onEmitFeedsList(cacheable);
      },
    );

    _getUnreadNotificationsCount();
  }

  void onTapProfile() => navigator.openPrivateProfile(const PrivateProfileInitialParams());

  void onTapNotifications() => navigator.openNotifications(const NotificationsListInitialParams());

  void onTapCirclesSideMenu() => _model.onCirclesSideMenuToggled();

  Future<void> onTapSeeMore() async {
    final feed = await navigator.openFeedMore(
      FeedMoreInitialParams(
        initialFeedsPageId: _model.remoteFeeds.pageInfo.nextPageId,
      ),
    );
    if (feed != null) {
      _localFeedsStore.add(feed);
    }
  }

  void onFeedChangedByIndex(int index) {
    onFeedChanged(_model.feeds[index]);
  }

  void onFeedChanged(Feed feed) {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.change(
        target: AnalyticsChangeTarget.feedTab,
        targetValue: feed.feedType.value,
        secondaryTargetValue: feed.circleId.value,
      ),
    );
    tryEmit(_model.copyWith(selectedFeed: feed));
  }

  void onPostChanged(Post post) {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.change(
        target: AnalyticsChangeTarget.post,
        targetValue: post.id.value,
      ),
    );
    _model.onPostChangedCallback(post);
    if (post != _model.currentPost) {
      if (post != const Post.empty()) {
        _viewPostUseCase.execute(postId: post.id);
      }
      tryEmit(_model.copyWith(currentPost: post));
    }
  }

  void onLocalPostChanged(Post post) {
    tryEmit(_model.copyWith(forYouLocalPost: post));
  }

  void onUpdateFeedsList() {
    if (_model.remoteFeeds.isNotEmpty) {
      _getFeedsListUseCase
          .execute(
        nextPageCursor: const Cursor.firstPage(pageSize: _feedPageSize),
      )
          .observeStatusChanges(
        onSubscribed: (subscription) {
          addSubscription(feedListSubscriptionId, subscription);
        },
        onEmit: (cacheable) {
          cacheable.result.doOn(success: _checkForExistingIds);
        },
      );
    }
  }

  void _onEmitFeedsList(CacheableResult<GetFeedsListFailure, PaginatedList<Feed>> cacheable) {
    cacheable.result.doOn(
      success: (list) {
        tryEmit(
          _model.copyWith(
            selectedFeed: list.isEmptyNoMorePage ? null : list.first,
            remoteFeeds: list,
          ),
        );
        if (list.isEmptyNoMorePage) {
          _model.onPostChangedCallback(const Post.empty());
        }
      },
      fail: (_) {
        tryEmit(
          _model.copyWith(remoteFeeds: const PaginatedList.singlePage()),
        );
        _model.onPostChangedCallback(const Post.empty());
      },
    );
  }

  void _getUnreadNotificationsCount() => _getUnreadNotificationsCountUseCase.execute().doOn(
        success: (count) {
          tryEmit(_model.copyWith(unreadNotificationsCount: count));
          _updateAppBadgeCountUseCase.execute(count.count);
        },
      );

  void _checkForExistingIds(PaginatedList<Feed> list) {
    if (_model.remoteFeeds.hasTheSameIdsAs(list)) {
      tryEmit(_model.copyWith(remoteFeeds: list));
    }
  }
}
