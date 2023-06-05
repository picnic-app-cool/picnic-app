// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/profile/domain/public_profile_tab.dart';
import 'package:picnic_app/features/profile/public_profile/public_profile_presentation_model.dart';
import 'package:picnic_app/features/profile/public_profile/public_profile_presenter.dart';
import 'package:picnic_app/features/profile/public_profile/widgets/public_profile_blocked_view.dart';
import 'package:picnic_app/features/profile/public_profile/widgets/public_profile_buttons.dart';
import 'package:picnic_app/features/profile/widgets/profile_container.dart';
import 'package:picnic_app/features/profile/widgets/public_profile_tabs.dart';
import 'package:picnic_app/features/profile/widgets/tabs/circles_tab.dart';
import 'package:picnic_app/features/profile/widgets/tabs/collections_tab.dart';
import 'package:picnic_app/features/profile/widgets/tabs/pods_tab.dart';
import 'package:picnic_app/features/profile/widgets/tabs/preview_tab.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_container_icon_button.dart';
import 'package:picnic_app/ui/widgets/status_bars/dark_status_bar.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class PublicProfilePage extends StatefulWidget with HasPresenter<PublicProfilePresenter> {
  const PublicProfilePage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final PublicProfilePresenter presenter;

  @override
  State<PublicProfilePage> createState() => _PublicProfilePageState();
}

class _PublicProfilePageState extends State<PublicProfilePage>
    with
        PresenterStateMixin<PublicProfileViewModel, PublicProfilePresenter, PublicProfilePage>,
        SingleTickerProviderStateMixin {
  late TabController _tabController;

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
  Widget build(BuildContext context) => stateObserver(
        builder: (context, state) {
          final themeData = PicnicTheme.of(context);
          return DarkStatusBar(
            child: Scaffold(
              appBar: PicnicAppBar(
                onTapBack: presenter.onTapBack,
                backgroundColor: themeData.colors.blackAndWhite.shade100,
                titleText: state.publicProfile.user.fullName,
                actions: [
                  PicnicContainerIconButton(
                    iconPath: Assets.images.moreCircle.path,
                    onTap: presenter.onTapMore,
                  ),
                ],
              ),
              body: NestedScrollView(
                headerSliverBuilder: (BuildContext context, bool _) => [
                  SliverToBoxAdapter(
                    child: state.isLoadingUser
                        ? const PicnicLoadingIndicator()
                        : ProfileContainer(
                            openLink: presenter.openLink,
                            user: state.publicProfile.user,
                            onTap: presenter.onTapStat,
                            profileStats: state.profileStats,
                            isLoadingProfileStats: state.isLoadingProfileStats,
                            onTapCopy: presenter.onTapCopyUserName,
                          ),
                  ),
                  SliverToBoxAdapter(
                    child: stateObserver(
                      builder: (context, state) => state.isLoadingUser
                          ? const PicnicLoadingIndicator()
                          : PublicProfileButtons(
                              action: state.action,
                              onTapDM: state.isBlocked ? null : presenter.onTapDm,
                              onTapAction: () =>
                                  state.followResult.isPending() ? null : presenter.onTapAction(state.action),
                              isBlocked: state.isBlocked,
                            ),
                    ),
                  ),
                  if (!state.isBlocked && !state.isLoadingUser)
                    SliverToBoxAdapter(
                      child: stateObserver(
                        buildWhen: (previous, current) =>
                            previous.selectedTab != current.selectedTab || previous.tabs != current.tabs,
                        builder: (context, state) => PublicProfileTabs(
                          tabController: _tabController,
                          selectedTab: state.selectedTab,
                          tabs: state.tabs,
                        ),
                      ),
                    ),
                ],
                body: state.isBlocked
                    ? const PublicProfileBlockedView()
                    : state.isLoadingUser
                        ? const Center(child: PicnicLoadingIndicator())
                        : Padding(
                            padding: const EdgeInsets.only(bottom: kBottomNavigationBarHeight),
                            child: TabBarView(
                              controller: _tabController,
                              children: state.tabs.map((tab) {
                                switch (tab) {
                                  case PublicProfileTab.posts:
                                    return stateObserver(
                                      buildWhen: (previous, current) => previous.posts != current.posts,
                                      builder: (context, state) => PreviewTab(
                                        isLoading: state.isPostsLoading,
                                        onTapView: presenter.onTapViewPost,
                                        posts: state.posts,
                                        onLoadMore: presenter.loadPosts,
                                        hideAuthorAvatar: true,
                                        postsTabType: PostsTabType.profile,
                                      ),
                                    );
                                  case PublicProfileTab.circles:
                                    return stateObserver(
                                      builder: (context, state) => CirclesTab(
                                        userCircles: state.userCircles,
                                        loadMore: presenter.onLoadMore,
                                        isLoading: state.isCirclesLoading,
                                        onTapEnterCircle: presenter.onTapEnterCircle,
                                        onDiscoverNewCircleTap: presenter.onTapSearchCircles,
                                      ),
                                    );
                                  case PublicProfileTab.collections:
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
                                  case PublicProfileTab.pods:
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                                      child: stateObserver(
                                        buildWhen: (previous, current) => previous.savedPods != current.savedPods,
                                        builder: (context, state) => PodsTab(
                                          pods: state.savedPods,
                                          onLoadMore: presenter.loadSavedPods,
                                          onTapPod: presenter.onTapPod,
                                        ),
                                      ),
                                    );
                                }
                              }).toList(),
                            ),
                          ),
              ),
            ),
          );
        },
      );
}
