import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/profile/domain/private_profile_tab.dart';
import 'package:picnic_app/features/profile/private_profile/private_profile_presentation_model.dart';
import 'package:picnic_app/features/profile/private_profile/private_profile_presenter.dart';
import 'package:picnic_app/features/profile/private_profile/widgets/private_profile_buttons.dart';
import 'package:picnic_app/features/profile/private_profile/widgets/profile_horizontal_item.dart';
import 'package:picnic_app/features/profile/widgets/private_profile_tabs.dart';
import 'package:picnic_app/features/profile/widgets/profile_container.dart';
import 'package:picnic_app/features/profile/widgets/tabs/circles_tab.dart';
import 'package:picnic_app/features/profile/widgets/tabs/collections_tab.dart';
import 'package:picnic_app/features/profile/widgets/tabs/preview_tab.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_container_icon_button.dart';
import 'package:picnic_app/ui/widgets/status_bars/dark_status_bar.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class PrivateProfilePage extends StatefulWidget with HasPresenter<PrivateProfilePresenter> {
  const PrivateProfilePage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final PrivateProfilePresenter presenter;

  @override
  State<PrivateProfilePage> createState() => _PrivateProfilePageState();
}

class _PrivateProfilePageState extends State<PrivateProfilePage>
    with
        PresenterStateMixin<PrivateProfileViewModel, PrivateProfilePresenter, PrivateProfilePage>,
        SingleTickerProviderStateMixin {
  late TabController _tabController;
  static const _iconSize = 20.0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: state.tabs.length, vsync: this);
    _tabController.index = state.tabs.indexOf(state.selectedTab);
    _tabController.addListener(() => presenter.onTabChanged(_tabController.index));
    presenter.navigator.context = context;

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
    final colors = theme.colors;

    final appBar = PicnicAppBar(
      backgroundColor: colors.blackAndWhite.shade100,
      actions: [
        stateObserver(
          buildWhen: (previous, current) => previous.unreadNotificationsCount != current.unreadNotificationsCount,
          builder: (context, state) => PicnicContainerIconButton(
            iconPath: Assets.images.bell.path,
            badgeValue: state.unreadNotificationsCount.count,
            onTap: presenter.onTapNotifications,
          ),
        ),
        PicnicContainerIconButton(
          iconPath: Assets.images.setting.path,
          onTap: presenter.onTapSettings,
        ),
      ],
    );

    return DarkStatusBar(
      child: Scaffold(
        appBar: appBar,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool _) => [
            stateObserver(
              builder: (context, state) => SliverToBoxAdapter(
                child: state.isLoadingUser
                    ? const PicnicLoadingIndicator()
                    : ProfileContainer(
                        openLink: presenter.openLink,
                        user: state.user.user,
                        onTap: presenter.onTapStat,
                        profileStats: state.profileStats,
                        isLoadingProfileStats: state.isLoadingProfileStats,
                        onTapCopy: presenter.onTapCopyUserName,
                      ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const Gap(22),
                  if (state.shouldSeedsBeVisible) ...[
                    stateObserver(
                      builder: (context, state) => ProfileHorizontalItem(
                        onTap: presenter.onTapSeeds,
                        trailingText: appLocalizations.seedsTitle,
                        title: state.seeds,
                        leading: state.isLoadingSeedsCount
                            ? const PicnicLoadingIndicator()
                            : Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Image.asset(
                                  Assets.images.acorn.path,
                                  width: _iconSize,
                                  height: _iconSize,
                                ),
                              ),
                      ),
                    ),
                    const Gap(8),
                  ],
                  if (state.enableAddFriends) ...[
                    ProfileHorizontalItem(
                      onTapTrailing: presenter.onTapShareProfileLink,
                      onTap: presenter.onTapInviteFriends,
                      trailingText: appLocalizations.profileLinkAction,
                      title: appLocalizations.addFriendsAction,
                    ),
                    const Gap(8),
                  ],
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: PrivateProfileButtons(
                onTapEditProfile: presenter.onTapEditProfile,
                onTapCreatePosts: presenter.onTapCreatePost,
              ),
            ),
            if (!state.isLoadingUser)
              SliverToBoxAdapter(
                child: stateObserver(
                  builder: (context, state) => PrivateProfileTabs(
                    tabs: state.tabs,
                    tabController: _tabController,
                    selectedTab: state.selectedTab,
                  ),
                ),
              ),
          ],
          body: stateObserver(
            buildWhen: (prev, next) => prev.tabs != next.tabs,
            builder: (context, state) => state.isLoadingUser
                ? const Center(child: PicnicLoadingIndicator())
                : TabBarView(
                    controller: _tabController,
                    children: state.tabs.map(
                      (tab) {
                        switch (tab) {
                          case PrivateProfileTab.posts:
                            return stateObserver(
                              buildWhen: (previous, current) => previous.posts != current.posts,
                              builder: (context, state) => PreviewTab(
                                isLoading: state.isPostsLoading,
                                posts: state.posts,
                                onLoadMore: presenter.loadPosts,
                                onTapView: presenter.onTapViewPost,
                                hideAuthorAvatar: true,
                                postsTabType: PostsTabType.profile,
                              ),
                            );
                          case PrivateProfileTab.circles:
                            return stateObserver(
                              builder: (context, state) => CirclesTab(
                                onTapEnterCircle: presenter.onTapEnterCircle,
                                userCircles: state.userCircles,
                                loadMore: presenter.onLoadMoreCircles,
                                isLoading: state.isCirclesLoading,
                                onCreateNewCircleTap: presenter.onCreateNewCircleTap,
                                isMe: true,
                                onDiscoverNewCircleTap: presenter.onTapSearchCircles,
                                onLongPress: presenter.onLongPress,
                              ),
                            );
                          case PrivateProfileTab.collections:
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24),
                              child: stateObserver(
                                buildWhen: (previous, current) => previous.collections != current.collections,
                                builder: (context, state) => CollectionsTab(
                                  collections: state.collections,
                                  onLoadMore: presenter.loadCollection,
                                  isLoading: state.isLoadingCollections,
                                  onTapCollection: presenter.onTapCollection,
                                ),
                              ),
                            );
                        }
                      },
                    ).toList(),
                  ),
          ),
        ),
      ),
    );
  }
}
