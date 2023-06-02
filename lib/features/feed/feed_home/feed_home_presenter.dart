import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/use_cases/update_app_badge_count_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/view_post_use_case.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/analytics/domain/model/analytics_event.dart';
import 'package:picnic_app/features/analytics/domain/model/change/analytics_change_target.dart';
import 'package:picnic_app/features/analytics/domain/model/tap/analytics_tap_target.dart';
import 'package:picnic_app/features/analytics/domain/use_cases/log_analytics_event_use_case.dart';
import 'package:picnic_app/features/feed/domain/model/feed.dart';
import 'package:picnic_app/features/feed/domain/model/feed_type.dart';
import 'package:picnic_app/features/feed/domain/model/get_feeds_list_failure.dart';
import 'package:picnic_app/features/feed/feed_home/feed_home_navigator.dart';
import 'package:picnic_app/features/feed/feed_home/feed_home_presentation_model.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/profile/domain/use_cases/get_unread_notifications_count_use_case.dart';
import 'package:picnic_app/features/profile/notifications/notifications_list_initial_params.dart';
import 'package:picnic_app/features/profile/private_profile/private_profile_initial_params.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';

class FeedHomePresenter extends Cubit<FeedHomeViewModel> with SubscriptionsMixin {
  FeedHomePresenter(
    FeedHomePresentationModel model,
    this.navigator,
    this._viewPostUseCase,
    this._logAnalyticsEventUseCase,
    this._getUnreadNotificationsCountUseCase,
    this._updateAppBadgeCountUseCase,
  ) : super(model);

  final FeedHomeNavigator navigator;
  final ViewPostUseCase _viewPostUseCase;
  final LogAnalyticsEventUseCase _logAnalyticsEventUseCase;
  final GetUnreadNotificationsCountUseCase _getUnreadNotificationsCountUseCase;
  final UpdateAppBadgeCountUseCase _updateAppBadgeCountUseCase;

  FeedHomePresentationModel get _model => state as FeedHomePresentationModel;

  void init() {
    final _hardcodedFeeds = [
      const Feed.empty().copyWith(
        feedType: FeedType.forYou,
        name: appLocalizations.feedForYouName,
      ),
      const Feed.empty().copyWith(
        id: _model.privateProfile.id,
        feedType: FeedType.user,
        name: appLocalizations.feedMyCirclesName,
      ),
    ];

    tryEmit(
      _model.copyWith(remoteFeedsResult: const StreamResult.empty().copyWith(status: StreamStatus.finished)),
    );

    _onEmitFeedsList(
      CacheableResult(
        result: success<GetFeedsListFailure, PaginatedList<Feed>>(
          PaginatedList.singlePage(_hardcodedFeeds),
        ),
        source: CacheableSource.network,
      ),
    );

    _getUnreadNotificationsCount();
  }

  void onTapProfile() => navigator.openPrivateProfile(const PrivateProfileInitialParams());

  Future<void> onTapNotifications() async {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.profileNotificationsButton,
      ),
    );
    await navigator.openNotifications(const NotificationsListInitialParams());
    _getUnreadNotificationsCount();
  }

  void onTapCirclesSideMenu() => _model.onCirclesSideMenuToggled();

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
    doNothing();
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
}
