import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/circle_role.dart';
import 'package:picnic_app/core/domain/model/collection.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/pod_app.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/model/profile_stats.dart';
import 'package:picnic_app/core/domain/model/runtime_permission.dart';
import 'package:picnic_app/core/domain/model/runtime_permission_status.dart';
import 'package:picnic_app/core/domain/model/stat_type.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/domain/use_cases/get_collections_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/get_user_circles_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/leave_circle_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/request_runtime_permission_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/update_app_badge_count_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/upload_contacts_use_case.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/analytics/domain/model/analytics_event.dart';
import 'package:picnic_app/features/analytics/domain/model/change/analytics_change_target.dart';
import 'package:picnic_app/features/analytics/domain/model/tap/analytics_tap_target.dart';
import 'package:picnic_app/features/analytics/domain/use_cases/log_analytics_event_use_case.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/add_circle_pod/add_circle_pod_initial_params.dart';
import 'package:picnic_app/features/circles/circle_details/circle_details_initial_params.dart';
import 'package:picnic_app/features/create_circle/create_circle/create_circle_initial_params.dart';
import 'package:picnic_app/features/discover/discover_explore/discover_explore_initial_params.dart';
import 'package:picnic_app/features/pods/domain/use_cases/get_saved_pods_use_case.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/post_creation_index/post_creation_index_initial_params.dart';
import 'package:picnic_app/features/posts/single_feed/single_feed_initial_params.dart';
import 'package:picnic_app/features/profile/collection/collection_initial_params.dart';
import 'package:picnic_app/features/profile/domain/model/get_saved_posts_failure.dart';
import 'package:picnic_app/features/profile/domain/model/get_user_posts_failure.dart';
import 'package:picnic_app/features/profile/domain/use_cases/get_private_profile_use_case.dart';
import 'package:picnic_app/features/profile/domain/use_cases/get_profile_stats_use_case.dart';
import 'package:picnic_app/features/profile/domain/use_cases/get_saved_posts_use_case.dart';
import 'package:picnic_app/features/profile/domain/use_cases/get_unread_notifications_count_use_case.dart';
import 'package:picnic_app/features/profile/domain/use_cases/get_user_posts_use_case.dart';
import 'package:picnic_app/features/profile/edit_profile/edit_profile_initial_params.dart';
import 'package:picnic_app/features/profile/followers/followers_initial_params.dart';
import 'package:picnic_app/features/profile/notifications/notifications_list_initial_params.dart';
import 'package:picnic_app/features/profile/private_profile/private_profile_navigator.dart';
import 'package:picnic_app/features/profile/private_profile/private_profile_presentation_model.dart';
import 'package:picnic_app/features/profile/saved_posts/saved_posts_initial_params.dart';
import 'package:picnic_app/features/reports/domain/model/report_entity_type.dart';
import 'package:picnic_app/features/reports/report_form/report_form_initial_params.dart';
import 'package:picnic_app/features/seeds/domain/use_cases/get_seeds_use_case.dart';
import 'package:picnic_app/features/seeds/domain/use_cases/get_user_seeds_total_use_case.dart';
import 'package:picnic_app/features/seeds/sell_seeds/sell_seeds_initial_params.dart';
import 'package:picnic_app/features/settings/settings_home/settings_home_initial_params.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/navigation/confirmation_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/horizontal_action_bottom_sheet_route.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/utils/clipboard_manager.dart';

class PrivateProfilePresenter extends Cubit<PrivateProfileViewModel> with SubscriptionsMixin {
  PrivateProfilePresenter(
    PrivateProfilePresentationModel super.model,
    this.navigator,
    this._getCollectionsUseCase,
    this._getUserCirclesUseCase,
    this._getPrivateProfileUseCase,
    this._getUserPostsUseCase,
    this._getUnreadNotificationsCountUseCase,
    this._getProfileStatsUseCase,
    this._uploadContactsUseCase,
    this._requestRuntimePermissionUseCase,
    this._updateAppBadgeCountUseCase,
    this._userStore,
    this._logAnalyticsEventUseCase,
    this._getSavedPostsUseCase,
    this._getUserSeedsTotalUseCase,
    this._leaveCircleUseCase,
    this._clipboardManager,
    this._getSavedPodsUseCase,
    this._getSeedsUseCase,
  ) {
    listenTo<PrivateProfile>(
      stream: _userStore.stream,
      subscriptionId: _userStoreSubscription,
      onChange: (user) {
        tryEmit(_model.copyWith(user: user));
      },
    );
  }

  final PrivateProfileNavigator navigator;
  final GetCollectionsUseCase _getCollectionsUseCase;
  final GetUserCirclesUseCase _getUserCirclesUseCase;
  final GetPrivateProfileUseCase _getPrivateProfileUseCase;
  final GetUserPostsUseCase _getUserPostsUseCase;
  final GetUnreadNotificationsCountUseCase _getUnreadNotificationsCountUseCase;
  final GetProfileStatsUseCase _getProfileStatsUseCase;
  final UploadContactsUseCase _uploadContactsUseCase;
  final RequestRuntimePermissionUseCase _requestRuntimePermissionUseCase;
  final GetSavedPostsUseCase _getSavedPostsUseCase;
  final UpdateAppBadgeCountUseCase _updateAppBadgeCountUseCase;
  final GetUserSeedsTotalUseCase _getUserSeedsTotalUseCase;
  final LeaveCircleUseCase _leaveCircleUseCase;
  final ClipboardManager _clipboardManager;
  final GetSavedPodsUseCase _getSavedPodsUseCase;
  final GetSeedsUseCase _getSeedsUseCase;

  final UserStore _userStore;
  final LogAnalyticsEventUseCase _logAnalyticsEventUseCase;

  static const _userStoreSubscription = "privateProfileUserStoreSubscription";

  PrivateProfilePresentationModel get _model => state as PrivateProfilePresentationModel;

  Future<void> onInit() async {
    _getUser();
    _getUnreadNotificationsCount();
    _getProfileStats();
    _requestContactsPermissions();
    await _getTotalUsersSeeds();
  }

  Future<void> onTapCopyUserName() async {
    await _clipboardManager.saveText(_model.user.username);
    await navigator.showSnackBar(appLocalizations.usernameCopiedAction);
  }

  Future<void> onTapNotifications() async {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.profileNotificationsButton,
      ),
    );
    await navigator.openNotifications(const NotificationsListInitialParams());
    _getUnreadNotificationsCount();
  }

  void onTapSettings() {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.profileSettingsButton,
      ),
    );
    navigator.openSettingsHome(SettingsHomeInitialParams(user: _model.user.user));
  }

  void onTapStat(StatType type) {
    switch (type) {
      case StatType.followers:
        openFollowers();
        break;
      case StatType.views:
      case StatType.likes:
      case StatType.posts:
      case StatType.slices:
      case StatType.members:
      case StatType.none:
        break;
    }
  }

  Future<void> openFollowers() async {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.profileFollowersTap,
      ),
    );

    final profileUpdated = await navigator.openFollowers(FollowersInitialParams(userId: _model.user.id)) ?? false;

    if (profileUpdated) {
      await onLoadMoreCircles(fromScratch: true);
    }
  }

  Future<void> onTapEditProfile() async {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.profileEditButton,
      ),
    );

    final profileUpdated = await navigator.openEditProfile(
          EditProfileInitialParams(privateProfile: _model.user),
        ) ??
        false;
    if (profileUpdated) {
      await loadPosts(fromScratch: true);
    }
  }

  void onTapSavedPosts() {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.profileSavedPostsButton,
      ),
    );

    navigator.openSavedPosts(const SavedPostsInitialParams());
  }

  void onTabChanged(int index) {
    final selectedTab = _model.tabs[index];

    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.change(
        target: AnalyticsChangeTarget.profileTab,
        targetValue: selectedTab.value,
      ),
    );

    tryEmit(
      _model.copyWith(selectedTab: selectedTab),
    );
  }

  Future<void> openLink(String link) async => navigator.openWebView(link);

  void onTapSearchCircles() => navigator.openDiscoverExplore(const DiscoverExploreInitialParams());

  Future<void> onTapEnterCircle(Id circleId) async {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.profileOpenCircleTap,
        targetValue: circleId.value,
      ),
    );

    await navigator.openCircleDetails(
      CircleDetailsInitialParams(
        circleId: circleId,
        onCircleMembershipChange: _onCircleUpdated,
      ),
    );

    await onLoadMoreCircles(fromScratch: true);
  }

  Future<void> onTapViewPost(Post post) async {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.profileOpenPostTap,
        targetValue: post.id.value,
      ),
    );

    await navigator.openSingleFeed(
      SingleFeedInitialParams(
        preloadedPosts: _model.posts,
        initialIndex: _model.posts.indexOf(post),
        onPostsListUpdated: (posts) => {},
        loadMore: () => _loadPosts().mapFailure((f) => f.displayableFailure()),
        refresh: () => _loadPosts(fromScratch: true).mapFailure((f) => f.displayableFailure()),
      ),
      useRoot: true,
    );

    tryEmit(
      _model.byUpdatingProfileStats(
        profileStats: _model.profileStats.copyWith(views: _model.profileStats.views + 1),
      ),
    );

    await _loadPosts(fromScratch: true).mapFailure((f) => f.displayableFailure());
  }

  void onTapShowInfo() => navigator.openInfoSeeds();

  Future<void> loadSeeds({
    bool fromScratch = false,
  }) {
    final cursor = fromScratch ? const Cursor.firstPage() : _model.seedsList.nextPageCursor();
    return _getSeedsUseCase.execute(nextPageCursor: cursor).doOn(
          success: (seeds) {
            final newList = fromScratch ? seeds : _model.seedsList + seeds;
            tryEmit(_model.copyWith(seedsList: newList));
          },
          fail: (fail) => navigator.showError(fail.displayableFailure()),
        );
  }

  void onTapSendSeeds() {
    navigator.openSellSeeds(
      SellSeedsInitialParams(
        onTransferSeedsCallback: () => loadSeeds(fromScratch: true),
      ),
    );
  }

  //TODO(GS-282): https://picnic-app.atlassian.net/browse/GS-282
  void loadMoreCollections() => notImplemented();

  Future<void> onLoadMoreCircles({bool fromScratch = false}) async {
    if (fromScratch) {
      await _loadUserCircles(fromScratch: true);
    } else if (state.userCircles.hasNextPage) {
      await _loadUserCircles();
    }
  }

  void onTapCollection(Collection collection) {
    navigator.openCollection(
      CollectionInitialParams(collection: collection, onPostRemovedCallback: () => loadCollection(fromScratch: true)),
      useRoot: true,
    );
  }

  Future<void> loadCollection({bool fromScratch = false}) => _getCollectionsUseCase
      .execute(
        nextPageCursor: fromScratch ? const Cursor.firstPage() : _model.collectionCursor,
        userId: _model.user.id,
      )
      .observeStatusChanges(
        (result) => tryEmit(_model.copyWith(collectionsResult: result)),
      )
      .doOn(
        success: (list) => fromScratch
            ? tryEmit(_model.copyWith(collections: list))
            : tryEmit(
                _model.copyWith(collections: _model.collections + list),
              ),
        fail: (fail) => navigator.showError(
          fail.displayableFailure(),
        ),
      );

  Future<void> loadPosts({bool fromScratch = false}) {
    return _loadPosts(fromScratch: fromScratch).doOn(
      fail: (fail) => navigator.showError(
        fail.displayableFailure(),
      ),
    );
  }

  Future<void> loadSavedPods() {
    return _getSavedPodsUseCase
        .execute(
          nextPageCursor: _model.savedPods.nextPageCursor(),
        )
        .doOn(
          success: (pods) => tryEmit(
            _model.copyWith(savedPods: _model.savedPods + pods),
          ),
        );
  }

  Future<void> loadSavedPosts({bool fromScratch = false}) => _getSavedPosts(fromScratch: fromScratch).doOn(
        fail: (fail) => navigator.showError(
          fail.displayableFailure(),
        ),
      );

  void onCreateNewCircleTap() {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.profileCreateNewCircleTap,
      ),
    );

    navigator.openCreateCircle(
      CreateCircleInitialParams(
        createCircleWithoutPost: true,
      ),
      useRoot: true,
    );
  }

  void onTapCreatePost() => navigator.openPostCreation(
        const PostCreationIndexInitialParams(),
      );

  void onLongPress(Circle circle) {
    tryEmit(
      _model.bySelectingCircle(circle),
    );
    navigator.showHorizontalActionBottomSheet(
      actions: [
        ActionBottom(
          label: appLocalizations.shareAction,
          action: _onTapShareProfile,
          icon: Assets.images.share.path,
        ),
        ActionBottom(
          label: appLocalizations.reportAction,
          action: _onTapReport,
          icon: Assets.images.infoOutlined.path,
        ),
        if (state.isMuteCircleEnabled)
          ActionBottom(
            label: appLocalizations.muteAction,
            action: notImplemented,
            icon: Assets.images.mute.path,
          ),
        if (!state.isDirector)
          ActionBottom(
            label: _model.circle.iJoined ? appLocalizations.leaveAction : appLocalizations.joinAction,
            action: _onTapLeave,
            icon: _model.circle.iJoined ? Assets.images.logout.path : Assets.images.login.path,
          ),
      ],
      onTapClose: navigator.close,
    );
  }

  void onTapPod(PodApp pod) {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.circlePod,
        targetValue: pod.id.value,
      ),
    );
    navigator.openAddCirclePod(AddCirclePodInitialParams(podId: pod.id));
  }

  void _onCircleUpdated() {
    onLoadMoreCircles(fromScratch: true);
  }

  Future<Either<GetUserPostsFailure, PaginatedList<Post>>> _loadPosts({bool fromScratch = false}) {
    return _getUserPostsUseCase
        .execute(
          userId: _model.user.id,
          nextPageCursor: fromScratch ? const Cursor.firstPage() : _model.posts.nextPageCursor(),
        )
        .doOn(
          success: (posts) => fromScratch
              ? tryEmit(_model.copyWith(posts: posts))
              : tryEmit(
                  _model.copyWith(posts: _model.posts + posts),
                ),
        );
  }

  Future<void> _getTotalUsersSeeds() async {
    await _getUserSeedsTotalUseCase
        .execute()
        .doOn(
          success: (seedCount) => tryEmit(
            _model.copyWith(seedCount: seedCount),
          ),
          fail: (fail) => navigator.showError(fail.displayableFailure()),
        )
        .observeStatusChanges(
      (result) {
        tryEmit(_model.copyWith(seedsCountResult: result));
      },
    );
  }

  Future<void> _loadUserCircles({bool fromScratch = false}) async {
    await _getUserCirclesUseCase.execute(
      nextPageCursor: fromScratch ? const Cursor.firstPage() : _model.userCirclesCursor,
      roles: [
        CircleRole.director,
        CircleRole.moderator,
        CircleRole.member,
      ],
    ).observeStatusChanges(
      (userCirclesResult) {
        tryEmit(_model.copyWith(userCirclesResult: userCirclesResult));
      },
    ).doOn(
      success: (list) {
        tryEmit(
          _model.copyWith(
            userCircles: fromScratch ? list : _model.userCircles.byAppending(list),
          ),
        );
      },
      fail: (fail) => navigator.showError(
        fail.displayableFailure(),
      ),
    );
  }

  void _getProfileStats() => _getProfileStatsUseCase
      .execute(userId: _userStore.privateProfile.id)
      .observeStatusChanges(
        (result) => tryEmit(_model.copyWith(profileStatsResult: result)),
      )
      .doOn(
        success: (profileStats) => tryEmit(_model.copyWith(profileStats: profileStats)),
        //intentionally not showing any error, since users cannot recover from it anyway
        fail: (fail) => tryEmit(_model.copyWith(profileStats: const ProfileStats.empty())),
      );

  void _getUser() => _getPrivateProfileUseCase.execute().doOn(success: (user) => _userStore.privateProfile = user);

  void _getUnreadNotificationsCount() => _getUnreadNotificationsCountUseCase.execute().doOn(
        success: (count) {
          tryEmit(_model.copyWith(unreadNotificationsCount: count));
          _updateAppBadgeCountUseCase.execute(count.count);
        },
      );

  void _requestContactsPermissions() => _requestRuntimePermissionUseCase
      .execute(permission: RuntimePermission.contacts) //
      .doOn(
        fail: (fail) => navigator.showError(fail.displayableFailure()),
        success: (status) {
          tryEmit(
            _model.copyWith(
              contactsPermission: status,
            ),
          );
          _uploadContacts();
        },
      );

  Future<Either<GetSavedPostsFailure, PaginatedList<Post>>> _getSavedPosts({bool fromScratch = false}) =>
      _getSavedPostsUseCase
          .execute(nextPageCursor: fromScratch ? const Cursor.firstPage() : _model.savedPosts.nextPageCursor())
          .doOn(
            fail: (failure) => navigator.showError(failure.displayableFailure()),
            success: (savedPosts) => fromScratch
                ? tryEmit(_model.copyWith(savedPosts: savedPosts))
                : tryEmit(
                    _model.byAppendingSavedPostsList(savedPosts),
                  ),
          )
          .observeStatusChanges(
            (result) => tryEmit(_model.copyWith(savedPostsResult: result)),
          );

  Future<void> _uploadContacts() async {
    if (_model.contactsPermission == RuntimePermissionStatus.granted) {
      await _uploadContactsUseCase.execute();
    }
  }

  void _onTapShareProfile() {
    navigator.close();
    navigator.shareText(text: _model.circle.inviteCircleLink);
  }

  void _onTapReport() {
    navigator.close();

    navigator.openReportForm(
      ReportFormInitialParams(
        entityId: _model.circle.id,
        reportEntityType: ReportEntityType.circle,
      ),
      useRoot: true,
    );
  }

  void _onTapLeave() {
    // closes the bottom sheet
    navigator.close();
    navigator.showConfirmationBottomSheet(
      title: appLocalizations.leaveCircle,
      message: appLocalizations.leaveCircleConfirmation,
      primaryAction: ConfirmationAction(
        roundedButton: true,
        title: appLocalizations.leaveCircle,
        action: () {
          _leaveCircleUseCase.execute(circle: _model.circle.toBasicCircle()).doOn(
                fail: (failure) => navigator.showError(failure.displayableFailure()),
                success: (e) {
                  tryEmit(_model.byRemoveUserCircleFromList(_model.circle));
                  // closes the confirmation bottom sheet
                  navigator.close();
                },
              );
        },
      ),
      secondaryAction: ConfirmationAction.negative(
        action: () => navigator.close(),
      ),
    );
  }
}
