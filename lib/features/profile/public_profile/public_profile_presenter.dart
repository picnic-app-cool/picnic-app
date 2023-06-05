import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/circle_role.dart';
import 'package:picnic_app/core/domain/model/collection.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/pod_app.dart';
import 'package:picnic_app/core/domain/model/profile_stats.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/core/domain/model/stat_type.dart';
import 'package:picnic_app/core/domain/use_cases/block_user_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/follow_unfollow_user_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/get_collections_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/get_user_circles_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/get_user_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/unblock_user_use_case.dart';
import 'package:picnic_app/core/fx_effect_overlay/confetti_fx_effect.dart';
import 'package:picnic_app/core/fx_effect_overlay/lottie_fx_effect.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/analytics/domain/model/analytics_event.dart';
import 'package:picnic_app/features/analytics/domain/model/change/analytics_change_target.dart';
import 'package:picnic_app/features/analytics/domain/model/tap/analytics_tap_target.dart';
import 'package:picnic_app/features/analytics/domain/use_cases/log_analytics_event_use_case.dart';
import 'package:picnic_app/features/chat/domain/model/basic_chat.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/domain/use_cases/create_single_chat_use_case.dart';
import 'package:picnic_app/features/chat/single_chat/single_chat_initial_params.dart';
import 'package:picnic_app/features/circles/add_circle_pod/add_circle_pod_initial_params.dart';
import 'package:picnic_app/features/circles/circle_details/circle_details_initial_params.dart';
import 'package:picnic_app/features/discover/discover_explore/discover_explore_initial_params.dart';
import 'package:picnic_app/features/pods/domain/use_cases/get_saved_pods_use_case.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/single_feed/single_feed_initial_params.dart';
import 'package:picnic_app/features/profile/collection/collection_initial_params.dart';
import 'package:picnic_app/features/profile/domain/model/get_user_posts_failure.dart';
import 'package:picnic_app/features/profile/domain/model/public_profile_action.dart';
import 'package:picnic_app/features/profile/domain/use_cases/get_profile_stats_use_case.dart';
import 'package:picnic_app/features/profile/domain/use_cases/get_user_action_use_case.dart';
import 'package:picnic_app/features/profile/domain/use_cases/get_user_posts_use_case.dart';
import 'package:picnic_app/features/profile/domain/use_cases/send_glitter_bomb_use_case.dart';
import 'package:picnic_app/features/profile/followers/followers_initial_params.dart';
import 'package:picnic_app/features/profile/public_profile/public_profile_navigator.dart';
import 'package:picnic_app/features/profile/public_profile/public_profile_presentation_model.dart';
import 'package:picnic_app/features/reports/domain/model/report_entity_type.dart';
import 'package:picnic_app/features/reports/report_form/report_form_initial_params.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/navigation/horizontal_action_bottom_sheet_route.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/utils/clipboard_manager.dart';

class PublicProfilePresenter extends Cubit<PublicProfileViewModel> {
  PublicProfilePresenter(
    PublicProfilePresentationModel model,
    this.navigator,
    this._getUserUseCase,
    this._getCollectionsUseCase,
    this._getUserCirclesUseCase,
    this._blockUserUseCase,
    this._unblockUserUseCase,
    this._followUnfollowUserUseCase,
    this._getUserPostsUseCase,
    this._getUserActionUseCase,
    this._sendGlitterBombUseCase,
    this._createSingleChatUseCase,
    this._getProfileStatsUseCase,
    this._logAnalyticsEventUseCase,
    this._clipboardManager,
    this._getSavedPodsUseCase,
  ) : super(model);

  final PublicProfileNavigator navigator;
  final GetUserUseCase _getUserUseCase;
  final GetCollectionsUseCase _getCollectionsUseCase;
  final GetUserCirclesUseCase _getUserCirclesUseCase;
  final BlockUserUseCase _blockUserUseCase;
  final UnblockUserUseCase _unblockUserUseCase;
  final SendGlitterBombUseCase _sendGlitterBombUseCase;
  final CreateSingleChatUseCase _createSingleChatUseCase;

  final FollowUnfollowUserUseCase _followUnfollowUserUseCase;

  final GetUserPostsUseCase _getUserPostsUseCase;
  final GetUserActionUseCase _getUserActionUseCase;
  final GetProfileStatsUseCase _getProfileStatsUseCase;
  final LogAnalyticsEventUseCase _logAnalyticsEventUseCase;
  final ClipboardManager _clipboardManager;
  final GetSavedPodsUseCase _getSavedPodsUseCase;

  PublicProfilePresentationModel get _model => state as PublicProfilePresentationModel;

  Future<void> onInit() async {
    _getUser();
    _getProfileStats();
  }

  @override
  void onChange(Change<PublicProfileViewModel> change) {
    super.onChange(change);

    if (change.currentState.publicProfile != change.nextState.publicProfile) {
      _updateUserAction(change.nextState.publicProfile);
    }
  }

  void onTapBack() => navigator.closeWithResult(true);

  Future<void> onTapCopyUserName() async {
    await _clipboardManager.saveText(_model.publicProfile.username);
    await navigator.showSnackBar(appLocalizations.usernameCopiedAction);
  }

  void onTapMore() {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.profileOptionsButton,
      ),
    );
    navigator.showHorizontalActionBottomSheet(
      actions: _bottomActions(),
      onTapClose: navigator.close,
    );
  }

  void toggleBlock() {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.profileBlockButton,
        targetValue: (!_model.publicProfile.isBlocked).toString(),
      ),
    );

    if (_model.publicProfile.isBlocked) {
      onTapUnBlock();
    } else {
      onTapBlock();
    }
    navigator.close();
  }

  Future<void> onTapReport() async {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.profileOptionsReportTap,
      ),
    );

    final reportSuccessful = await navigator.openReportForm(
          ReportFormInitialParams(
            reportEntityType: ReportEntityType.user,
            entityId: _model.publicProfile.user.id,
          ),
        ) ??
        false;
    if (reportSuccessful) {
      navigator.close();
    }
  }

  void onTapSearchCircles() => navigator.openDiscoverExplore(const DiscoverExploreInitialParams());

  void onTapBlock() {
    final user = _model.publicProfile.user;

    _blockUserUseCase
        .execute(userId: user.id) //
        .doOn(
          success: (success) {
            final profile = _model.publicProfile.copyWith(
              isBlocked: true,
              iFollow: false,
            );

            final followersCount = _model.profileStats.followers;
            final profileStats = _model.profileStats.copyWith(
              followers: _model.publicProfile.iFollow ? followersCount - 1 : followersCount,
            );
            return tryEmit(
              _model
                  .byUpdatingPublicProfile(publicProfile: profile)
                  .copyWith(action: _getUserActionUseCase.execute(profile))
                  .byUpdatingProfileStats(profileStats: profileStats),
            );
          },
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

  void onTapPod(PodApp pod) {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.circlePod,
        targetValue: pod.id.value,
      ),
    );
    navigator.openAddCirclePod(AddCirclePodInitialParams(podId: pod.id));
  }

  void onTapUnBlock() {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.profileBlockButton,
        targetValue: false.toString(),
      ),
    );

    _unblockUserUseCase
        .execute(
          userId: _model.publicProfile.id,
        ) //
        .doOn(
          success: (success) {
            final profile = _model.publicProfile.copyWith(
              isBlocked: false,
              iFollow: false,
            );
            return tryEmit(
              _model.byUpdatingPublicProfile(publicProfile: profile).copyWith(
                    action: _getUserActionUseCase.execute(
                      profile,
                    ),
                  ),
            );
          },
          fail: (fail) => navigator.showError(
            fail.displayableFailure(),
          ),
        );
  }

  Future<void> toggleFollow() async {
    final previousFollowState = _model.publicProfile.iFollow;
    final counter = previousFollowState ? -1 : 1;
    final followersCount = _model.profileStats.followers;
    final profile = _model.publicProfile.copyWith(iFollow: !previousFollowState);
    final profileStats = _model.profileStats.copyWith(followers: followersCount + counter);
    tryEmit(
      _model
          .byUpdatingPublicProfile(publicProfile: profile)
          .copyWith(action: _getUserActionUseCase.execute(profile))
          .byUpdatingProfileStats(profileStats: profileStats),
    );
    await _followUnfollowUserUseCase.execute(userId: _model.publicProfile.id, follow: !previousFollowState).doOn(
      fail: (error) {
        tryEmit(
          _model.byUpdatingPublicProfile(publicProfile: _model.publicProfile.copyWith(iFollow: previousFollowState)),
        );
        navigator.showError(error.displayableFailure());
      },
    ).observeStatusChanges((result) => tryEmit(_model.copyWith(followResult: result)));

    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.profileFollowButton,
        targetValue: (!previousFollowState).toString(),
      ),
    );
  }

  void onTapGlitterBomb() {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.profileGlitterbombButton,
      ),
    );

    _sendGlitterBombUseCase.execute(_model.userId).doOn(
          success: (_) => navigator
            ..showFxEffect(LottieFxEffect.glitter())
            ..showFxEffect(ConfettiFxEffect.avatar(_model.privateProfile.profileImageUrl)),
        );
  }

  void onTapShareProfile() {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.profileOptionsShareTap,
        targetValue: _model.shareProfileUrl,
      ),
    );

    navigator.close();
    navigator.shareText(text: _model.shareProfileUrl);
  }

  void onTapShareCircleLink(String circleInviteLink) => navigator.shareText(text: circleInviteLink);

  void onTapStat(StatType type) {
    switch (type) {
      case StatType.followers:
        onTapFollowers();
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

  void onTapFollowers() {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.profileFollowersTap,
      ),
    );

    navigator.openFollowers(FollowersInitialParams(userId: _model.publicProfile.id));
  }

  Future<void> onTapDm() async {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.profileDmButton,
      ),
    );

    await _createSingleChatUseCase.execute(userIds: _model.singleChatUserIds).doOn(
          fail: (failure) => navigator.showError(
            failure.displayableFailure(),
          ),
          success: _openSingleChat,
        );
  }

  void onTapAction(PublicProfileAction profileAction) {
    switch (profileAction) {
      case PublicProfileAction.follow:
      case PublicProfileAction.following:
        toggleFollow();
        break;
      case PublicProfileAction.glitterbomb:
        onTapGlitterBomb();
        break;
      case PublicProfileAction.blocked:
        onTapUnBlock();
        break;
    }
  }

  Future<void> onTapEnterCircle(Id circleId) async {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.profileOpenCircleTap,
        targetValue: circleId.value,
      ),
    );

    await navigator.openCircleDetails(CircleDetailsInitialParams(circleId: circleId));
    await _loadUserCircles();
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
    );
    _getProfileStats();

    await _loadPosts(fromScratch: true).mapFailure((f) => f.displayableFailure());
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

  Future<void> loadCollection({bool fromScratch = false}) => _getCollectionsUseCase
      .execute(
        nextPageCursor: fromScratch ? const Cursor.firstPage() : _model.collectionCursor,
        userId: _model.publicProfile.id,
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

  Future<void> onLoadMore() async {
    if (state.userCircles.hasNextPage) {
      await _loadUserCircles();
    }
  }

  Future<void> loadPosts() => _loadPosts().doOn(
        fail: (fail) => navigator.showError(
          fail.displayableFailure(),
        ),
      );

  void onTapCollection(Collection collection) => navigator.openCollection(
        CollectionInitialParams(collection: collection),
      );

  Future<void> openLink(String link) async => navigator.openWebView(link);

  Future<Either<GetUserPostsFailure, PaginatedList<Post>>> _loadPosts({bool fromScratch = false}) {
    return _getUserPostsUseCase
        .execute(
          userId: _model.userId,
          nextPageCursor: fromScratch ? const Cursor.firstPage() : _model.posts.nextPageCursor(),
        )
        .observeStatusChanges(
          (result) => tryEmit(_model.copyWith(postsResult: result)),
        )
        .doOn(
          success: (posts) => tryEmit(
            fromScratch
                ? _model.copyWith(posts: posts) //
                : _model.copyWith(posts: _model.posts + posts),
          ),
        );
  }

  void _getUser() => _getUserUseCase
      .execute(userId: _model.userId) //
      .observeStatusChanges(
        (userResult) => tryEmit(_model.copyWith(userResult: userResult)),
      )
      .doOn(
        success: (profile) =>
            tryEmit(_model.copyWith(action: _getUserActionUseCase.execute(profile), publicProfile: profile)),
        fail: (fail) => navigator.showError(fail.displayableFailure()),
      );

  void _updateUserAction(PublicProfile user) => tryEmit(_model.copyWith(action: _getUserActionUseCase.execute(user)));

  void _openSingleChat(BasicChat chat) {
    navigator.openSingleChat(
      SingleChatInitialParams(chat: chat),
    );
  }

  void _getProfileStats() => _getProfileStatsUseCase
      .execute(userId: _model.userId)
      .observeStatusChanges(
        (result) => tryEmit(_model.copyWith(profileStatsResult: result)),
      )
      .doOn(
        success: (profileStats) => tryEmit(_model.copyWith(profileStats: profileStats)),
        //intentionally not showing any error, since users cannot recover from it any way
        fail: (fail) => tryEmit(_model.copyWith(profileStats: const ProfileStats.empty())),
      );

  Future<void> _loadUserCircles({bool fromScratch = false}) async {
    await _getUserCirclesUseCase
        .execute(
          nextPageCursor: fromScratch ? const Cursor.firstPage() : _model.userCirclesCursor,
          userId: _model.userId,
          roles: [
            CircleRole.director,
            CircleRole.moderator,
            CircleRole.member,
          ],
        )
        .observeStatusChanges(
          (userCirclesResult) => tryEmit(_model.copyWith(userCirclesResult: userCirclesResult)),
        )
        .doOn(
          success: (list) => tryEmit(
            fromScratch
                ? _model.copyWith(userCircles: list)
                : _model.copyWith(userCircles: _model.userCircles.byAppending(list)),
          ),
          fail: (fail) => navigator.showError(
            fail.displayableFailure(),
          ),
        );
  }

  List<ActionBottom> _bottomActions() => [
        ActionBottom(
          label: appLocalizations.shareAction,
          action: onTapShareProfile,
          icon: Assets.images.share.path,
        ),
        ActionBottom(
          label: appLocalizations.reportAction,
          action: onTapReport,
          icon: Assets.images.infoOutlined.path,
        ),
        ActionBottom(
          label: _model.publicProfile.iFollow ? appLocalizations.followingAction : appLocalizations.followAction,
          action: () {
            toggleFollow();
            navigator.close();
          },
          icon: _model.publicProfile.iFollow ? Assets.images.unfollow.path : Assets.images.follow.path,
        ),
        ActionBottom(
          label: _model.publicProfile.isBlocked ? appLocalizations.unblockedAction : appLocalizations.blockAction,
          action: toggleBlock,
          icon: Assets.images.close.path,
        ),
      ];
}
