import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/circles/circle_details/circle_details_presentation_model.dart';
import 'package:picnic_app/features/circles/circle_details/circle_details_presenter.dart';
import 'package:picnic_app/features/circles/circle_details/widgets/circle_details_buttons.dart';
import 'package:picnic_app/features/circles/circle_details/widgets/no_royals.dart';
import 'package:picnic_app/features/circles/circle_details/widgets/private_circle_warning.dart';
import 'package:picnic_app/features/circles/circle_details/widgets/sort_button.dart';
import 'package:picnic_app/features/circles/domain/model/circle_member.dart';
import 'package:picnic_app/features/circles/domain/model/circle_tab.dart';
import 'package:picnic_app/features/circles/widgets/circle_container.dart';
import 'package:picnic_app/features/circles/widgets/circle_tabs.dart';
import 'package:picnic_app/features/circles/widgets/full_members_list.dart';
import 'package:picnic_app/features/circles/widgets/no_rules.dart';
import 'package:picnic_app/features/circles/widgets/royals_tab.dart';
import 'package:picnic_app/features/circles/widgets/rules_tab.dart';
import 'package:picnic_app/features/circles/widgets/slices_tab.dart';
import 'package:picnic_app/features/profile/widgets/tabs/posts_tab.dart';
import 'package:picnic_app/features/profile/widgets/tabs/preview_tab.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_container_icon_button.dart';
import 'package:picnic_app/ui/widgets/status_bars/dark_status_bar.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_app/ui/widgets/view_in_foreground_detector.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class CircleDetailsPage extends StatefulWidget with HasPresenter<CircleDetailsPresenter> {
  const CircleDetailsPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final CircleDetailsPresenter presenter;

  @override
  State<CircleDetailsPage> createState() => _CircleDetailsPageState();
}

class _CircleDetailsPageState extends State<CircleDetailsPage>
    with
        PresenterStateMixin<CircleDetailsViewModel, CircleDetailsPresenter, CircleDetailsPage>,
        SingleTickerProviderStateMixin {
  late TabController _tabController;

  static const _titleSpacing = 8.0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: state.tabs.length, vsync: this);
    _tabController.index = state.tabs.indexOf(state.selectedTab);
    _tabController.addListener(() {
      presenter.onTabChanged(_tabController.index);
    });
    presenter.onInit();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    return stateObserver(
      builder: (context, state) {
        final white = theme.colors.blackAndWhite.shade100;
        final iconTintColor = state.setIconTintColor ? white : null;
        final picnicAppBar = PicnicAppBar(
          backgroundColor: state.showAppBarBackgroundColor && state.pageVisible ? white : Colors.transparent,
          backButtonIconColor: iconTintColor,
          onTapBack: presenter.onTapBack,
          actions: [
            if (state.hasModerationPermissions && state.showSettingsIconButton)
              PicnicContainerIconButton(
                iconPath: Assets.images.setting.path,
                badgeValue: state.hasPermissionReports ? state.circle.reportsCount : null,
                onTap: presenter.onTapSettings,
                iconTintColor: iconTintColor,
              ),
            PicnicContainerIconButton(
              iconPath: Assets.images.moreCircle.path,
              onTap: presenter.onTapMore,
              iconTintColor: iconTintColor,
            ),
          ],
          titleSpacing: _titleSpacing,
          child: state.showSortInAppBar && state.pageVisible
              ? AnimatedOpacity(
                  duration: const ShortDuration(),
                  opacity: state.showSortInAppBar ? 1 : 0,
                  curve: Curves.easeInOut,
                  child: SortButton(
                    onTap: presenter.onTapSort,
                    title: state.postSortOption.valueToDisplay,
                    shouldBeCentered: true,
                  ),
                )
              : null,
        );
        return WillPopScope(
          onWillPop: () async => true,
          child: DarkStatusBar(
            child: ViewInForegroundDetector(
              viewDidAppear: () => presenter.onPageVisibilityChange(isVisible: true),
              viewDidDisappear: () => presenter.onPageVisibilityChange(isVisible: false),
              child: Scaffold(
                appBar: picnicAppBar,
                extendBodyBehindAppBar: true,
                body: state.isLoadingCircle
                    ? const Center(child: PicnicLoadingIndicator())
                    : NestedScrollView(
                        headerSliverBuilder: (BuildContext context, bool _) => [
                          stateObserver(
                            buildWhen: (prev, next) =>
                                prev.circle != next.circle ||
                                prev.circleStats != next.circleStats ||
                                prev.isLoadingStats != next.isLoadingStats ||
                                prev.seedsCount != next.seedsCount,
                            builder: (context, state) {
                              return SliverToBoxAdapter(
                                child: CircleContainer(
                                  circle: state.circle,
                                  onTapStat: presenter.onTapStat,
                                  circleStats: state.circleStats,
                                  isLoadingStats: state.isLoadingStats,
                                  onTapElection: presenter.onTapOpenElection,
                                  onTapSeeds: presenter.onTapSeedHolders,
                                  circleButtons: CircleDetailsButtons(
                                    onTapCircleChat: presenter.onTapCircleChat,
                                    onTapJoin: presenter.onTapJoin,
                                    onTapSeedHolders: presenter.onTapSeedHolders,
                                    isMember: state.circle.iJoined,
                                    showSeedHolders: state.areSeedsEnabled,
                                    onTapPost: presenter.onTapPostToCircle,
                                    onTapInviteUsers: () => presenter.onTapInviteUsers,
                                    isPostingEnabled: state.isPostingEnabled,
                                    hasPermissionToManageCircle: state.hasPermissionToManageCircle,
                                  ),
                                  slicesCount: state.slicesCount,
                                  seedsCount: state.seedsCount,
                                  onCoverVisibilityAppear: presenter.onCoverVisibilityAppear,
                                  onCoverVisibilityDisappear: presenter.onCoverVisibilityDisappear,
                                ),
                              );
                            },
                          ),
                          SliverToBoxAdapter(
                            child: stateObserver(
                              builder: (context, state) => CircleTabs(
                                tabController: _tabController,
                                selectedTab: state.selectedTab,
                                tabs: state.tabs,
                              ),
                            ),
                          ),
                          if (state.showPrivateCircleWarning)
                            const SliverToBoxAdapter(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(
                                  24,
                                  48,
                                  24,
                                  0,
                                ),
                                child: PrivateCircleWarning(),
                              ),
                            ),
                          if (state.showPostSortBottomSheet && !state.showPrivateCircleWarning)
                            SliverToBoxAdapter(
                              child: ViewInForegroundDetector(
                                viewDidAppear: presenter.onSortButtonAppear,
                                viewDidDisappear: presenter.onSortButtonDisappear,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                    24,
                                    0,
                                    24,
                                    16,
                                  ),
                                  child: SortButton(
                                    onTap: presenter.onTapSort,
                                    title: state.postSortOption.valueToDisplay,
                                  ),
                                ),
                              ),
                            ),
                        ],
                        body: state.showPrivateCircleWarning
                            ? const SizedBox.shrink()
                            : MediaQuery.removePadding(
                                context: context,
                                removeTop: true,
                                child: TabBarView(
                                  controller: _tabController,
                                  children: state.tabs.map((tab) {
                                    switch (tab) {
                                      case CircleTab.posts:
                                        return stateObserver(
                                          buildWhen: (previous, current) =>
                                              (previous.posts != current.posts) ||
                                              (previous.postSortOption != current.postSortOption),
                                          builder: (context, state) => PostsTab(
                                            posts: state.posts,
                                            onLoadMore: presenter.loadPosts,
                                            onTapView: presenter.onTapViewPost,
                                            onTapAvatar: presenter.onTapViewPublicProfile,
                                            onPostUpdated: presenter.onPostUpdated,
                                            onReport: presenter.onReportPost,
                                            postsTabType: PostsTabType.circle,
                                            onTapHeart: presenter.onTapHeart,
                                            onTapComments: presenter.onTapComments,
                                            onTapShare: presenter.onTapShare,
                                            onTapBookmark: presenter.onTapBookmark,
                                            bookmarkEnabled: state.savedPostsEnabled,
                                            onToggleFollow: presenter.onToggleFollow,
                                            onTapAuthor: presenter.onTapProfile,
                                          ),
                                        );
                                      case CircleTab.preview:
                                        return stateObserver(
                                          buildWhen: (previous, current) =>
                                              (previous.posts != current.posts) ||
                                              (previous.postSortOption != current.postSortOption) ||
                                              (previous.isMultiSelectionEnabled != current.isMultiSelectionEnabled) ||
                                              (previous.selectedPosts != current.selectedPosts),
                                          builder: (context, state) => PreviewTab(
                                            posts: state.posts,
                                            onLoadMore: presenter.loadPosts,
                                            onTapView: presenter.onTapViewPost,
                                            onTapAvatar: presenter.onTapViewPublicProfile,
                                            postsTabType: PostsTabType.circle,
                                            isMultiSelectionEnabled: state.isMultiSelectionEnabled,
                                            selectedPosts: state.selectedPosts,
                                            onTapSelectedView:
                                                state.hasModerationPermissions ? presenter.onTapSelectedViewPost : null,
                                            onTapClosePostsSelection: presenter.onTapClosePostsSelection,
                                            onTapConfirmPostsSelection: presenter.onTapConfirmPostsSelection,
                                          ),
                                        );
                                      case CircleTab.royalty:
                                        return stateObserver(
                                          buildWhen: (previous, current) => previous.royals != current.royals,
                                          builder: (context, state) => state.royals.items.isEmpty
                                              ? const NoRoyals()
                                              : RoyalsTab(
                                                  loadMore: presenter.loadMoreRoyals,
                                                  royalties: state.royals,
                                                  onTapView: presenter.onTapRoyal,
                                                ),
                                        );
                                      case CircleTab.members:
                                        return stateObserver(
                                          builder: (context, state) {
                                            return FullMembersList(
                                              emptyItems: state.members.items.isEmpty && state.directors.items.isEmpty,
                                              hasMore: state.members.hasNextPage || state.directors.hasNextPage,
                                              privateProfile: state.privateProfile,
                                              members: state.members,
                                              directors: state.directors,
                                              isLoadingToggleFollow: state.isLoadingToggleFollow,
                                              loadMore: presenter.onLoadMoreMembers,
                                              onTapAddRole: () => presenter.onTapAddRole(),
                                              onTapToggleFollow: presenter.onTapToggleFollow,
                                              onTapInviteUsers: presenter.onTapInviteUsers,
                                              onTapViewUserProfile: _onCircleMemberTap,
                                              hasPermissionToManageRoles: state.circle.hasPermissionToManageRoles,
                                              hasPermissionToManageUsers: state.circle.hasPermissionToManageUsers,
                                              onTapEditRole: presenter.onTapEditRole,
                                            );
                                          },
                                        );
                                      case CircleTab.rules:
                                        return stateObserver(
                                          buildWhen: (previous, current) =>
                                              previous.rules != current.rules ||
                                              previous.hasModerationPermissions != current.hasModerationPermissions,
                                          builder: (context, state) => state.rules.isEmpty
                                              ? NoRules(
                                                  onTapEdit: presenter.onTapEditRules,
                                                  isMod: state.hasModerationPermissions,
                                                )
                                              : RulesTab(
                                                  onTapEdit: presenter.onTapEditRules,
                                                  rules: state.rules,
                                                  isMod: state.hasModerationPermissions,
                                                ),
                                        );
                                      case CircleTab.slices:
                                        return stateObserver(
                                          builder: (context, state) => SlicesTab(
                                            onTapCreateSlice: presenter.onTapCreateSlice,
                                            loadMore: presenter.loadMoreSlices,
                                            onTapJoinSlice: presenter.onTapJoinSlice,
                                            onTapSliceItem: presenter.onTapSliceItem,
                                            slices: state.slices,
                                            sliceCount: state.slicesCount,
                                          ),
                                        );
                                    }
                                  }).toList(),
                                ),
                              ),
                      ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _onCircleMemberTap(CircleMember member) {
    presenter.onTapCircleMember.call(member.user);
  }
}
