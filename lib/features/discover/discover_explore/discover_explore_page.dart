// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/discover/discover_explore/discover_explore_presentation_model.dart';
import 'package:picnic_app/features/discover/discover_explore/discover_explore_presenter.dart';
import 'package:picnic_app/features/discover/discover_explore/widgets/picnic_circle_listview.dart';
import 'package:picnic_app/features/discover/discover_explore/widgets/picnic_title_text_with_padding.dart';
import 'package:picnic_app/features/discover/widgets/picnic_discovery_navigation_bar.dart';
import 'package:picnic_app/features/discover/widgets/picnic_discovery_search_bar.dart';
import 'package:picnic_app/features/discover/widgets/picnic_discovery_trending_posts.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';

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
            return CustomScrollView(
              slivers: [
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
