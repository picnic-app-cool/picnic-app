import 'package:async/async.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/circle_role.dart';
import 'package:picnic_app/core/domain/model/circle_stats.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/join_circle_failure.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/core/domain/model/save_post_to_collection_failure.dart';
import 'package:picnic_app/core/domain/model/slice.dart';
import 'package:picnic_app/core/domain/model/stat_type.dart';
import 'package:picnic_app/core/domain/use_cases/delete_posts_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/follow_unfollow_user_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/get_circle_stats_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/get_slices_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/join_circle_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/join_slice_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/leave_circle_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/save_post_to_collection_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/share_post_use_case.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/analytics/domain/model/analytics_event.dart';
import 'package:picnic_app/features/analytics/domain/model/tap/analytics_tap_target.dart';
import 'package:picnic_app/features/analytics/domain/use_cases/log_analytics_event_use_case.dart';
import 'package:picnic_app/features/chat/circle_chat/circle_chat_initial_params.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/domain/use_cases/get_chat_use_case.dart';
import 'package:picnic_app/features/circles/circle_details/circle_details_navigator.dart';
import 'package:picnic_app/features/circles/circle_details/circle_details_presentation_model.dart';
import 'package:picnic_app/features/circles/circle_details/models/posts_sorting_type.dart';
import 'package:picnic_app/features/circles/circle_member_settings/circle_member_settings_initial_params.dart';
import 'package:picnic_app/features/circles/circle_role/circle_role_initial_params.dart';
import 'package:picnic_app/features/circles/circle_role/circle_role_presentation_model.dart';
import 'package:picnic_app/features/circles/circle_settings/circle_settings_initial_params.dart';
import 'package:picnic_app/features/circles/discover_pods/discover_pods_initial_params.dart';
import 'package:picnic_app/features/circles/domain/model/circle_member.dart';
import 'package:picnic_app/features/circles/domain/model/get_circle_sorted_posts_failure.dart';
import 'package:picnic_app/features/circles/domain/model/royalty.dart';
import 'package:picnic_app/features/circles/domain/use_cases/get_circle_details_use_case.dart';
import 'package:picnic_app/features/circles/domain/use_cases/get_circle_members_by_role_use_case.dart';
import 'package:picnic_app/features/circles/domain/use_cases/get_circle_sorted_posts_use_case.dart';
import 'package:picnic_app/features/circles/domain/use_cases/get_last_used_sorting_option_use_case.dart';
import 'package:picnic_app/features/circles/domain/use_cases/get_royalty_use_case.dart';
import 'package:picnic_app/features/circles/domain/use_cases/view_circle_use_case.dart';
import 'package:picnic_app/features/circles/edit_rules/edit_rules_initial_params.dart';
import 'package:picnic_app/features/circles/invite_user_list/invite_user_list_initial_params.dart';
import 'package:picnic_app/features/circles/members/members_initial_params.dart';
import 'package:picnic_app/features/circles/user_roles/user_roles_initial_params.dart';
import 'package:picnic_app/features/create_slice/presentation/create_slice_initial_params.dart';
import 'package:picnic_app/features/posts/comment_chat/comment_chat_initial_params.dart';
import 'package:picnic_app/features/posts/domain/model/like_dislike_reaction.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/domain/model/save_post_input.dart';
import 'package:picnic_app/features/posts/domain/use_cases/get_post_use_case.dart';
import 'package:picnic_app/features/posts/domain/use_cases/like_dislike_post_use_case.dart';
import 'package:picnic_app/features/posts/domain/use_cases/unreact_to_post_use_case.dart';
import 'package:picnic_app/features/posts/post_creation_index/post_creation_index_initial_params.dart';
import 'package:picnic_app/features/posts/post_overlay/widgets/saved_post_snackbar.dart';
import 'package:picnic_app/features/posts/save_post_to_collection/save_post_to_collection_initial_params.dart';
import 'package:picnic_app/features/posts/single_feed/single_feed_initial_params.dart';
import 'package:picnic_app/features/posts/single_feed/sorting_handler.dart';
import 'package:picnic_app/features/reports/domain/model/report_entity_type.dart';
import 'package:picnic_app/features/reports/report_form/report_form_initial_params.dart';
import 'package:picnic_app/features/seeds/circle_governance/circle_governance_initial_params.dart';
import 'package:picnic_app/features/seeds/domain/use_cases/get_governance_use_case.dart';
import 'package:picnic_app/features/seeds/domain/use_cases/get_seed_holders_use_case.dart';
import 'package:picnic_app/features/seeds/seed_holders/seed_holders_initial_params.dart';
import 'package:picnic_app/features/slices/domain/model/slice_settings_page_result.dart';
import 'package:picnic_app/features/slices/slice_details/slice_details_initial_params.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/navigation/confirmation_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/horizontal_action_bottom_sheet_route.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/utils/clipboard_manager.dart';

class CircleDetailsPresenter extends Cubit<CircleDetailsViewModel> {
  CircleDetailsPresenter(
    CircleDetailsPresentationModel model,
    this.navigator,
    this._getRoyaltyUseCase,
    this._joinCircleUseCase,
    this._leaveCircleUseCase,
    this._getCircleDetailsUseCase,
    this._getCircleStatsUseCase,
    this._getChatUseCase,
    this._getSlicesUseCase,
    this._clipboardManager,
    this._joinSliceUseCase,
    this._getCircleSortedPostsUseCase,
    this._deletePostsUseCase,
    this._getSeedHoldersUseCase,
    this._getGovernanceUseCase,
    this._getLastUsedSortingOptionUseCase,
    this._logAnalyticsEventUseCase,
    this._sharePostUseCase,
    this._likeDislikePostUseCase,
    this._savePostToCollectionUseCase,
    this._getPostUseCase,
    this._followUnfollowUseCase,
    this._getMembersByRoleUseCase,
    this._unReactToPostUseCase,
    this._viewCircleUseCase,
  ) : super(model);

  final CircleDetailsNavigator navigator;
  final GetRoyaltyUseCase _getRoyaltyUseCase;
  final JoinCircleUseCase _joinCircleUseCase;
  final LeaveCircleUseCase _leaveCircleUseCase;
  final GetCircleSortedPostsUseCase _getCircleSortedPostsUseCase;
  final GetCircleDetailsUseCase _getCircleDetailsUseCase;
  final GetCircleStatsUseCase _getCircleStatsUseCase;
  final GetChatUseCase _getChatUseCase;
  final GetSlicesUseCase _getSlicesUseCase;
  final ClipboardManager _clipboardManager;
  final JoinSliceUseCase _joinSliceUseCase;
  final GetSeedHoldersUseCase _getSeedHoldersUseCase;
  final DeletePostsUseCase _deletePostsUseCase;
  final GetGovernanceUseCase _getGovernanceUseCase;
  final GetLastUsedSortingOptionUseCase _getLastUsedSortingOptionUseCase;
  final LogAnalyticsEventUseCase _logAnalyticsEventUseCase;
  final SharePostUseCase _sharePostUseCase;
  final LikeDislikePostUseCase _likeDislikePostUseCase;
  final SavePostToCollectionUseCase _savePostToCollectionUseCase;
  final GetPostUseCase _getPostUseCase;
  final FollowUnfollowUserUseCase _followUnfollowUseCase;
  final GetCircleMembersByRoleUseCase _getMembersByRoleUseCase;
  final UnreactToPostUseCase _unReactToPostUseCase;
  final ViewCircleUseCase _viewCircleUseCase;

  // ignore: unused_element
  CircleDetailsPresentationModel get _model => state as CircleDetailsPresentationModel;

  void onInit() {
    _getCirclesInfo();
    _getSeedHolders();
    _getGovernance();
    _getLastUsedSortingOption();
  }

  void onTapBack() {
    _clearMultiSelectedPosts();
    navigator.close();
  }

  void onTapMore() => navigator.showHorizontalActionBottomSheet(
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
              action: _model.circle.iJoined ? _onTapLeave : _onTapJoinBottomSheet,
              icon: _model.circle.iJoined ? Assets.images.logout.path : Assets.images.login.path,
            ),
        ],
        onTapClose: navigator.close,
      );

  Future<void> onTapOpenElection() async {
    await navigator.openCircleGovernance(CircleGovernanceInitialParams(circle: _model.circle));
    onInit();
  }

  void onTapSettings() => navigator.openCircleSettings(
        CircleSettingsInitialParams(
          circleRole: _model.circle.circleRole,
          circle: _model.circle,
          onCirclePostDeleted: () => loadPosts(fromScratch: true),
          onCircleUpdated: () => _getCircleDetails(),
        ),
      );

  void onTapStat(StatType type) {
    switch (type) {
      case StatType.members:
        _onTapMembersLabel();
        break;
      case StatType.posts:
      case StatType.views:
      case StatType.followers:
      case StatType.likes:
      case StatType.slices:
      case StatType.none:
        break;
    }
  }

  void onTabChanged(int index) => tryEmit(
        _model.copyWith(selectedTab: _model.tabs[index]),
      );

  Future<void> loadPosts({
    bool fromScratch = false,
  }) {
    return _loadPosts(
      fromScratch: fromScratch,
    ).doOn(
      fail: (fail) => navigator.showError(fail.displayableFailure()),
    );
  }

  Future<void> onTapEditRules() async {
    final newRules = await navigator.openEditRules(EditRulesInitialParams(circle: _model.circle));
    if (newRules != null) {
      tryEmit(
        _model.copyWith(circle: _model.circle.copyWith(rulesText: newRules)),
      );
    }
  }

  Future<void> onTapViewPost(Post post) async {
    await navigator.openSingleFeed(
      SingleFeedInitialParams(
        preloadedPosts: _model.posts,
        initialIndex: _model.posts.indexOf(post),
        onPostsListUpdated: (posts) => {},
        sortingHandler: SortingHandler(
          selectedSortOption: () => _model.postSortOption,
          onTapSort: _openSortScreen,
        ),
        loadMore: () => _loadPosts().mapFailure((f) => f.displayableFailure()),
        refresh: () => _loadPosts(fromScratch: true).mapFailure((f) => f.displayableFailure()),
      ),
    );
    _getCircleStats();

    await _loadPosts(fromScratch: true).mapFailure((f) => f.displayableFailure());
  }

  void onTapCircleMember(PublicProfile user) {
    navigator.openCircleMemberSettings(
      CircleMemberSettingsInitialParams(user: user, circle: _model.circle),
    );
  }

  void onTapViewPublicProfile(Id userId) => navigator.openProfile(userId: userId);

  void onTapSelectedViewPost(Post post) {
    final newSelectedPosts = _model.selectedPosts;
    if (newSelectedPosts.contains(post)) {
      newSelectedPosts.remove(post);
    } else {
      newSelectedPosts.add(post);
    }

    tryEmit(
      _model.copyWith(
        selectedPosts: newSelectedPosts,
        isMultiSelectionEnabled: newSelectedPosts.isNotEmpty,
      ),
    );
  }

  void onTapClosePostsSelection() {
    _clearMultiSelectedPosts();
  }

  void onTapConfirmPostsSelection() {
    navigator.showDeletePostConfirmation(
      title: appLocalizations.deletePostsConfirmation(_model.selectedPosts.length),
      onDelete: () {
        onTapDeletePost();
      },
      onClose: () {
        _clearMultiSelectedPosts();
        navigator.close();
      },
    );
  }

  void onTapDeletePost() => {
        _deletePostsUseCase
            .execute(
              postIds: _model.selectedPosts.map((post) => post.id).toList(),
            )
            .doOn(
              success: (success) {
                _clearMultiSelectedPosts();
                navigator.close();
                loadPosts(fromScratch: true);
              },
              fail: (fail) => navigator.showError(fail.displayableFailure()),
            ),
      };

// TODO(GS-2939): Unit test - Circle Settings page copy invite link to the clipboard
  void onTapInviteUsers() => navigator.openInviteUsersBottomSheet(
        onTapClose: navigator.close,
        onTapCopyLink: () async {
          await _clipboardManager.saveText(_model.circle.inviteCircleLink);
          navigator.close();
          await navigator.showSnackBar(appLocalizations.invitationLinkCopiedMessage);
        },
        onTapInvite: () => navigator.openInviteUserList(
          InviteUserListInitialParams(circleId: _model.circle.id),
        ),
      );

  void onTapRoyal(Royalty royalty) => notImplemented();

  Future<void> onTapViewPods() async {
    await navigator.openDiscoverPods(
      DiscoverPodsInitialParams(circleId: _model.circle.id),
    );
    _getCirclesInfo();
    await _loadPosts(fromScratch: true);
  }

  Future<void> onTapCircleChat() async {
    await _getChatUseCase
        .execute(
          chatId: _model.circle.chat.id,
        )
        .doOnSuccessWait(
          (chat) => navigator.openCircleChat(
            CircleChatInitialParams(
              chat: chat,
            ),
          ),
        );

    //on back navigation, in circle settings , update circle details page
    _getCirclesInfo();
  }

  Future<void> onTapSeedHolders() async {
    await navigator.openSeedHolders(
      SeedHoldersInitialParams(circleId: _model.circle.id, isSeedHolder: _model.election.isSeedHolder),
    );
    _getCirclesInfo();
  }

  Future<void> loadMoreRoyals() => _getRoyaltyUseCase.execute().doOn(
        fail: (failure) => navigator.showError(failure.displayableFailure()),
        success: (royals) => tryEmit(_model.byAppendingRoyaltyList(royals)),
      );

  void onTapJoin() => _joinCircleUseCase.execute(circle: _model.circle.toBasicCircle()).doOn(
        fail: (failure) => navigator.showError(failure.displayableFailure()),
        success: (e) {
          _increaseMembersCount();

          tryEmit(
            _model.byUpdatingCircle(_model.circle.copyWith(iJoined: true)),
          );

          _onCircleMembershipChange();
        },
      );

  Future<void> loadMoreSlices({bool fromScratch = false}) async {
    final cursor = fromScratch ? const Cursor.firstPage() : _model.slices.nextPageCursor();
    await _getSlicesUseCase.execute(circleId: _model.id, nextPageCursor: cursor).doOn(
          fail: (failure) => navigator.showError(failure.displayableFailure()),
          success: (slices) {
            final newList = fromScratch ? slices : _model.slices.byAppending(slices);
            tryEmit(_model.copyWith(slices: newList));
          },
        );
  }

  Future<void> onTapCreateSlice() async {
    final newSliceCreated = await navigator.openCreateSlice(
          CreateSliceInitialParams(
            circle: _model.circle,
          ),
        ) ??
        false;
    if (newSliceCreated) {
      await loadMoreSlices(fromScratch: true);
    }
  }

  void onTapJoinSlice(Slice slice) => _joinSliceUseCase
      .execute(
        sliceId: slice.id,
      )
      .doOn(
        fail: (failure) => navigator.showError(failure.displayableFailure()),
        success: (e) {
          loadMoreSlices(fromScratch: true);
        },
      );

  Future<void> onTapSliceItem(Slice slice) async {
    final result = await navigator.openSliceDetails(
      SliceDetailsInitialParams(
        slice: slice,
        circle: state.circle,
      ),
    );
    if (result == SliceSettingsPageResult.didLeftSlice) {
      await loadMoreSlices(fromScratch: true);
    }
  }

  void onTapPostToCircle() {
    if (_model.isPostingEnabled && _model.hasPermissionToPost) {
      navigator.openPostCreation(
        PostCreationIndexInitialParams(
          circle: _model.circle,
        ),
      );
    } else {
      navigator.showDisabledBottomSheet(
        title: appLocalizations.postingIsDisabled,
        description: appLocalizations.postingDisabledLabel,
        onTapClose: () => navigator.close(),
      );
    }
  }

  Future<void> onTapSort() async {
    final sortingOption = await _openSortScreen();

    if (sortingOption != null) {
      await _loadPosts(fromScratch: true);
    }
  }

  void onPostUpdated(Post updatedPost) {
    tryEmit(_model.byUpdatingPost(updatedPost));
  }

  void onLongPress(Post post) => _openReportPostForm(post);

  Future<void> onScrollReachedBottom() async => onTapViewPost(_model.posts.first);

  void onSortButtonAppear() {
    tryEmit(_model.copyWith(showSortInAppBar: false));
    Future.delayed(
      const ShortDuration(),
      () => tryEmit(
        _model.copyWith(showSettingsIconButton: true),
      ),
    );
  }

  void onSortButtonDisappear() {
    tryEmit(_model.copyWith(showSortInAppBar: true));
    tryEmit(_model.copyWith(showSettingsIconButton: false));
  }

  void onPageVisibilityChange({required bool isVisible}) {
    tryEmit(_model.copyWith(pageVisible: isVisible));
  }

  void onCoverVisibilityAppear() {
    tryEmit(_model.copyWith(showAppBarBackgroundColor: false));
  }

  void onCoverVisibilityDisappear() {
    tryEmit(_model.copyWith(showAppBarBackgroundColor: true));
  }

  Future<void> onTapLike(Post post) async {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.postLikeButton,
        targetValue: (!post.iLiked).toString(),
      ),
    );
    await _executeLikeReactUnRectUseCase(post);
  }

  Future<void> onTapDislike(Post post) async {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.postDislikeButton,
        targetValue: (!post.iDisliked).toString(),
      ),
    );
    await _executeDislikeReactUnRectUseCase(post);
  }

  Future<void> onTapComments(Post post) async {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.postOpenChatButton,
      ),
    );
    await navigator.openCommentChat(
      CommentChatInitialParams(
        post: post,
        onPostUpdated: (post) {
          onPostUpdated(post);
        },
      ),
    );
    await _refreshPostDetails(post);
  }

  void onTapShare(Post post) {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.postShareButton,
      ),
    );
    navigator.shareText(text: post.shareLink);

    _sharePostUseCase
        .execute(
      postId: post.id,
    )
        .doOn(
      success: (_) {
        final newPost = post.byIncrementingShareCount();
        onPostUpdated(newPost);
      },
    ).doOn(
      fail: (fail) => navigator.showError(
        fail.displayableFailure(),
      ),
    );
  }

  Future<void> onTapBookmark(Post post) {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.postBookmarkButton,
      ),
    );
    return _executeBookmarkUseCase(post);
  }

  void onToggleFollow(Post post) {
    final previousFollow = post.author.iFollow;

    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.postFollowUserButton,
      ),
    );
    final newPost = post.byUpdatingAuthorWithFollow(follow: !previousFollow);
    onPostUpdated(newPost);

    _followUnfollowUseCase
        .execute(
      userId: post.author.id,
      follow: !previousFollow,
    ) //
        .doOn(
      success: (success) {
        final newPost = post.byUpdatingAuthorWithFollow(follow: !previousFollow);
        onPostUpdated(newPost);
      },
    ).doOn(
      fail: (fail) {
        final newPost = post.byUpdatingAuthorWithFollow(follow: previousFollow);
        onPostUpdated(newPost);
        navigator.showError(fail.displayableFailure());
      },
    );
  }

  Future<void> onTapProfile(Post post) async {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.postUserTap,
      ),
    );
    final id = post.author.id;
    await navigator.openProfile(userId: id);

    await _refreshPostDetails(post);
  }

  Future<void> onJoinCircle(Post post) {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.postJoinCircleButton,
      ),
    );
    return _executeJoinCircleUseCase(post);
  }

  Future<void> onLoadMoreMembers({bool fromScratch = false}) async {
    if (fromScratch) {
      await _loadMembers(fromScratch: true);
    } else if (state.members.hasNextPage) {
      await _loadMembers();
    }
  }

  void onTapAddRole() => navigator.openCircleRole(
        CircleRoleInitialParams(
          circleId: _model.circle.id,
          formType: CircleRoleFormType.createCircleRole,
        ),
      );

  void onTapToggleFollow(CircleMember member) {
    _followUnfollowUseCase
        .execute(userId: member.user.id, follow: !member.user.iFollow)
        .doOn(success: (success) => _handleFollowEvent(member.user))
        .observeStatusChanges(
          (result) => tryEmit(_model.copyWith(toggleFollowResult: result)),
        )
        .doOn(fail: (fail) => navigator.showError(fail.displayableFailure()));
  }

  Future<void> onTapEditRole(CircleMember member) async {
    await navigator.openUserRoles(
      UserRolesInitialParams(
        user: member.user,
        circleId: _model.circle.id,
      ),
    );
    await _loadMembers(fromScratch: true);
  }

  Future<void> _loadMembers({bool fromScratch = false}) async {
    if (fromScratch) {
      tryEmit(_model.copyWith(members: const PaginatedList.empty()));
    }
    final operation = CancelableOperation.fromFuture(
      _getMembersByRoleUseCase.execute(
        circleId: _model.circle.id,
        cursor: fromScratch ? const Cursor.firstPage() : _model.membersCursor,
        roles: [
          CircleRole.director,
          CircleRole.member,
          CircleRole.moderator,
        ],
      ),
    );

    await operation.value.doOn(
      fail: (failure) => navigator.showError(failure.displayableFailure()),
      success: (members) => tryEmit(_model.byAppendingMembersList(members)),
    );
  }

  Future<Either<JoinCircleFailure, Unit>> _executeJoinCircleUseCase(Post post) {
    void emitStatus({required bool joined}) {
      final newPost = post.byUpdatingJoinedStatus(iJoined: joined);
      onPostUpdated(newPost);
    }

    //this updates the UI immediately on tap
    emitStatus(joined: true);
    return _joinCircleUseCase.execute(circle: post.circle).doOn(
          success: (_) => emitStatus(joined: true),
          fail: (_) => emitStatus(joined: false),
        );
  }

  void _handleFollowEvent(PublicProfile user) {
    final users = _model.members.items;
    final index = users.indexWhere((element) => element.user.id == user.id);
    final members = users.toList();
    tryEmit(_model.byUpdateFollowAction(members[index]));
  }

  Future<void> _executeLikeReactUnRectUseCase(Post post) async {
    final initialReaction = post.context.reaction;
    final iLikedPreviously = post.iLiked;

    //this updates the UI immediately on tap
    late Post newPost;
    newPost = iLikedPreviously ? post.byUnReactingToPost() : post.byLikingPost();
    onPostUpdated(newPost);

    if (iLikedPreviously) {
      await _unReactToPostUseCase.execute(postId: post.id).doOn(
        fail: (fail) {
          _reEmitInitialReaction(post: post, initialReaction: initialReaction);
        },
      );
    } else {
      await _likeDislikePostUseCase
          .execute(
        id: post.id,
        likeDislikeReaction: LikeDislikeReaction.like,
      )
          .doOn(
        fail: (fail) {
          _reEmitInitialReaction(post: post, initialReaction: initialReaction);
        },
      );
    }
  }

  Future<void> _executeDislikeReactUnRectUseCase(Post post) async {
    final initialReaction = post.context.reaction;
    final iDisLikedPreviously = post.iDisliked;

    //this updates the UI immediately on tap
    late Post newPost;
    newPost = iDisLikedPreviously ? post.byUnReactingToPost() : post.byDislikingPost();
    onPostUpdated(newPost);

    if (iDisLikedPreviously) {
      await _unReactToPostUseCase.execute(postId: post.id).doOn(
        fail: (fail) {
          _reEmitInitialReaction(post: post, initialReaction: initialReaction);
        },
      );
    } else {
      await _likeDislikePostUseCase
          .execute(
        id: post.id,
        likeDislikeReaction: LikeDislikeReaction.dislike,
      )
          .doOn(
        fail: (fail) {
          _reEmitInitialReaction(post: post, initialReaction: initialReaction);
        },
      );
    }
  }

  Future<Either<SavePostToCollectionFailure, Post>> _executeBookmarkUseCase(Post post) {
    final previousState = post.context.saved;

    void emitStatus({required bool saved}) {
      final newPost = post.byUpdatingSavedStatus(iSaved: saved);
      onPostUpdated(newPost);
    }

    //this updates the UI immediately on tap
    emitStatus(saved: !previousState);
    return _savePostToCollectionUseCase
        .execute(
      input: SavePostInput(
        postId: post.id,
        save: !previousState,
      ),
    )
        .observeStatusChanges(
      (result) {
        tryEmit(_model.copyWith(savePostResult: result));
      },
    ).doOn(
      success: (post) {
        emitStatus(saved: post.context.saved);
        _showSavePostSuccess(post);
      },
      fail: (fail) => emitStatus(saved: previousState),
    );
  }

  void _reEmitInitialReaction({
    required Post post,
    required LikeDislikeReaction initialReaction,
  }) {
    late Post newPost;
    switch (initialReaction) {
      case LikeDislikeReaction.like:
        newPost = post.byLikingPost();
        break;
      case LikeDislikeReaction.dislike:
        newPost = post.byDislikingPost();
        break;
      case LikeDislikeReaction.noReaction:
        newPost = post.byUnReactingToPost();
        break;
    }
    onPostUpdated(newPost);
  }

  void _showSavePostSuccess(Post post) {
    if (_model.showSavePostToCollection && post.context.saved) {
      navigator.showSnackBarWithWidget(
        SavedPostSnackBar(
          post: post,
          onTap: () {
            _onTapSavePostToCollection(post);
          },
        ),
      );
    }
  }

  void _onTapSavePostToCollection(Post post) {
    navigator.openSavePostToCollectionBottomSheet(
      SavePostToCollectionInitialParams(userId: _model.id, postId: post.id),
    );
  }

  Future<void> _refreshPostDetails(Post post) async {
    await _getPostUseCase.execute(postId: post.id).doOn(
      success: (post) {
        onPostUpdated(post);
      },
    );
  }

  Future<void> _getGovernance() => _getGovernanceUseCase.execute(circleId: _model.id).doOn(
        success: (election) => tryEmit(_model.copyWith(election: election)),
        fail: (fail) => navigator.showError(fail.displayableFailure()),
      );

  Future<PostsSortingType?> _openSortScreen() async {
    final sortingOption = _model.postSortOption;
    await navigator.openSortPostsBottomSheet(
      onTapSort: (postSortOption) {
        navigator.close();
        tryEmit(_model.copyWith(postSortOption: postSortOption));
      },
      sortOptions: PostsSortingType.allSorts,
      selectedSortOption: _model.postSortOption,
    );

    if (sortingOption != _model.postSortOption) {
      return _model.postSortOption;
    }
    return null;
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
                  _decreaseMembersCount();
                  tryEmit(
                    _model.byUpdatingCircle(
                      _model.circle.copyWith(iJoined: false),
                    ),
                  );
                  _onCircleMembershipChange();
                  // closes the confirmation bottom sheet
                  navigator.close();
                  // navigates back to previous page
                  navigator.closeWithResult(true);
                },
              );
        },
      ),
      secondaryAction: ConfirmationAction.negative(
        action: () => navigator.close(),
      ),
    );
  }

  void _onTapJoinBottomSheet() {
    onTapJoin();
    navigator.close();
  }

  Future<Either<GetCircleSortedPostsFailure, PaginatedList<Post>>> _loadPosts({
    bool fromScratch = false,
  }) {
    return _getCircleSortedPostsUseCase
        .execute(
      circleId: _model.circle.id,
      nextPageCursor: fromScratch ? const Cursor.firstPage() : _model.posts.nextPageCursor(),
      sortingType: _model.postSortOption,
    )
        .doOn(
      success: (posts) {
        tryEmit(
          fromScratch
              ? _model.copyWith(posts: posts) //
              : _model.byAppendingPostsList(posts),
        );
      },
    );
  }

  void _onCircleMembershipChange() {
    _model.onCircleMembershipChangeCallback?.call();
  }

  Future<void> _getCircleDetails() async => _getCircleDetailsUseCase
      .execute(circleId: _model.id)
      .observeStatusChanges(
        (result) => tryEmit(_model.copyWith(circleDetailsResult: result)),
      )
      .doOn(
        fail: (failure) => navigator.showError(failure.displayableFailure()),
        success: (circle) {
          tryEmit(_model.copyWith(circle: circle));
          _increaseCircleViews();
        },
      );

  void _getCircleStats() => _getCircleStatsUseCase
      .execute(circleId: _model.id)
      .observeStatusChanges(
        (result) => tryEmit(_model.copyWith(circleStatsResult: result)),
      )
      .doOn(
        //intentionally not showing any error, since users cannot recover from it any way
        fail: (failure) => tryEmit(_model.copyWith(circleStats: const CircleStats.empty())),
        success: (circleStats) => tryEmit(_model.copyWith(circleStats: circleStats)),
      );

  void _increaseMembersCount() {
    tryEmit(
      _model.byUpdatingCircle(
        _model.circle.copyWith(membersCount: _model.circle.membersCount + 1),
      ),
    );
  }

  void _onTapMembersLabel() => navigator.openMembersPage(MembersInitialParams(circle: _model.circle));

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
    );
  }

  void _decreaseMembersCount() {
    tryEmit(
      _model.byUpdatingCircle(
        _model.circle.copyWith(membersCount: _model.circle.membersCount - 1),
      ),
    );
  }

  void _clearMultiSelectedPosts() {
    tryEmit(
      _model.copyWith(
        selectedPosts: [],
        isMultiSelectionEnabled: false,
      ),
    );
  }

  void _getCirclesInfo() {
    _getCircleStats();
    _getCircleDetails();
  }

  void _getSeedHolders() => _getSeedHoldersUseCase
      .execute(circleId: _model.id)
      .doOn(success: (list) => tryEmit(_model.copyWith(seedHolders: _model.seedHolders + list)))
      .doOn(fail: (fail) => navigator.showError(fail.displayableFailure()));

  void _openReportPostForm(Post post) => navigator.openReportForm(
        ReportFormInitialParams(
          entityId: post.id,
          circleId: post.circle.id,
          reportEntityType: ReportEntityType.post,
          contentAuthorId: post.author.id,
        ),
      );

  void _increaseCircleViews() {
    _viewCircleUseCase.execute(circleId: _model.circle.id).doOn(
          success: (_) => _model.onCircleViewedCallback?.call(),
        );
  }

  void _getLastUsedSortingOption() {
    _getLastUsedSortingOptionUseCase
        .execute(
          circleId: _model.id,
        )
        .observeStatusChanges(
          (result) => tryEmit(_model.copyWith(lastUsedSortingOptionResult: result)),
        )
        .doOn(
          success: (sortingType) => tryEmit(_model.copyWith(postSortOption: sortingType)),
        );
  }
}
