// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/discover/discover_explore/discover_explore_presentation_model.dart';
import 'package:picnic_app/features/discover/discover_explore/discover_explore_presenter.dart';
import 'package:picnic_app/features/discover/discover_explore/widgets/picnic_circle_listview.dart';
import 'package:picnic_app/features/discover/discover_explore/widgets/picnic_pod_listview.dart';
import 'package:picnic_app/features/discover/discover_explore/widgets/picnic_title_text_with_padding.dart';
import 'package:picnic_app/features/discover/widgets/picnic_discovery_navigation_bar.dart';
import 'package:picnic_app/features/discover/widgets/picnic_discovery_search_bar.dart';
import 'package:picnic_app/features/discover/widgets/picnic_discovery_trending_posts.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/picnic_tag.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class DiscoverExplorePage extends StatefulWidget with HasPresenter<DiscoverExplorePresenter> {
  const DiscoverExplorePage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final DiscoverExplorePresenter presenter;

  @override
  State<DiscoverExplorePage> createState() => _DiscoverExplorePageState();
}

class _DiscoverExplorePageState extends State<DiscoverExplorePage>
    with PresenterStateMixin<DiscoverExploreViewModel, DiscoverExplorePresenter, DiscoverExplorePage> {
  late final TextEditingController controller;
  late final FocusNode focusNode;

  static const _midPadding = 16.0;
  static const _highPadding = 24.0;
  static const _radius = 16.0;
  static const _tagRadius = 100.0;

  @override
  void initState() {
    controller = TextEditingController();

    focusNode = FocusNode();
    focusNode.addListener(() {
      // The textfield in this screen is nothing but a placeholder / button that navigates the user to the discovery search page
      // Any focus here has to be prevented programatically.
      if (focusNode.hasPrimaryFocus) {
        FocusScope.of(context).unfocus();
        presenter.onTapSearchBar();
      }
    });
    super.initState();
    presenter.init();
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final themeColors = theme.colors;
    final blackAndWhite = themeColors.blackAndWhite;
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, isScroller) => [
          const SliverToBoxAdapter(child: PicnicDiscoveryNavigationBar()),
          SliverToBoxAdapter(
            child: GestureDetector(
              child: PicnicDiscoverySearchBar(
                controller: controller,
                focusNode: focusNode,
              ),
            ),
          ),
        ],
        body: stateObserver(
          builder: (context, state) {
            const linearGradient = LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [
                0.0,
                0.4319,
                1.0312,
              ],
              colors: [
                Color(0xFFBE86F5),
                Color(0xFFA76AF5),
                Color(0xFFA497F5),
              ],
            );
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 24.0,
                          right: 24.0,
                          top: 24.0,
                        ),
                        child: Row(
                          children: [
                            Text(
                              appLocalizations.discoverPods,
                              style: theme.styles.title30,
                            ),
                            const Gap(_radius),
                            PicnicTag(
                              borderRadius: _tagRadius,
                              title: appLocalizations.newFeature,
                              gradient: linearGradient,
                              titleTextStyle: theme.styles.body20.copyWith(
                                color: blackAndWhite.shade100,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(4.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24.0,
                        ),
                        child: Text(
                          appLocalizations.discoverPodsDescription,
                          style: theme.styles.caption20.copyWith(color: blackAndWhite.shade600),
                        ),
                      ),
                      const Gap(16.0),
                      PicnicPodListView(
                        circlePodApps: state.pods,
                        onTapPod: presenter.onTapViewPod,
                        loadMore: presenter.loadMore,
                      ),
                    ],
                  ),
                ),
                if (state.areTrendingPostsEnabled) ...[
                  SliverToBoxAdapter(
                    child: PicnicTitleTextWithPadding(
                      text: appLocalizations.trendingPosts,
                      topPadding: _midPadding,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: PicnicDiscoveryTrendingPosts(
                      onTapView: presenter.onTapViewPost,
                      onTapAvatar: presenter.onTapViewProfile,
                      trendingPosts: state.popularFeedPosts,
                    ),
                  ),
                ],
                ...state.feedGroups.map((element) {
                  return SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PicnicTitleTextWithPadding(
                          text: appLocalizations.circleWithTopic(element.name),
                          topPadding: _highPadding,
                          bottomPadding: 0,
                        ),
                        PicnicCircleListView(
                          items: element.topCircles,
                          onTapViewCircle: presenter.onTapViewCircle,
                        ),
                      ],
                    ),
                  );
                }).toList(growable: false),
              ],
            );
          },
        ),
      ),
    );
  }
}
