//ignore_for_file: maximum-nesting: 4
// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/discover/discover_explore/discover_explore_presentation_model.dart';
import 'package:picnic_app/features/discover/discover_explore/discover_explore_presenter.dart';
import 'package:picnic_app/features/discover/discover_explore/widgets/picnic_circle_listview.dart';
import 'package:picnic_app/features/discover/discover_explore/widgets/picnic_title_text_with_padding.dart';
import 'package:picnic_app/features/discover/discover_explore/widgets/trending_circles.dart';
import 'package:picnic_app/features/discover/domain/model/circle_group.dart';
import 'package:picnic_app/features/discover/widgets/picnic_discovery_navigation_bar.dart';
import 'package:picnic_app/features/discover/widgets/pod_circle_banner.dart';
import 'package:picnic_app/features/discover/widgets/pod_list.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_tag.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_text_button.dart';

//ignore_for_file: maximum-nesting-level
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

  //ignore: maximum-nesting-level
  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;

    const linearGradientNewTag = LinearGradient(
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
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, isScroller) => [
          SliverToBoxAdapter(
            child: PicnicDiscoveryNavigationBar(
              controller: controller,
              focusNode: focusNode,
            ),
          ),
        ],
        body: stateObserver(
          builder: (context, state) {
            final headerPodCircle = Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: PodCircleBanner(
                    title: appLocalizations.pods,
                    imagePath: Assets.images.podBack.path,
                    onTap: presenter.onTapViewPods,
                  ),
                ),
                const Gap(4),
                Flexible(
                  child: PodCircleBanner(
                    title: appLocalizations.circles,
                    imagePath: Assets.images.circleBack.path,
                    onTap: presenter.onTapViewCircles,
                  ),
                ),
              ],
            );
            final link15BlueStyle = theme.styles.link15.copyWith(color: colors.blue);
            final title40 = theme.styles.title40;
            final topContent = Padding(
              padding: const EdgeInsets.only(
                left: 24.0,
                right: 24.0,
                top: 24.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  headerPodCircle,
                  const Gap(8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Assets.images.podRobot.image(),
                          const Gap(6),
                          Text(
                            appLocalizations.trendingPods,
                            style: title40,
                          ),
                          const Gap(6),
                          PicnicTag(
                            borderRadius: _tagRadius,
                            title: appLocalizations.newLabel,
                            gradient: linearGradientNewTag,
                            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                            titleTextStyle: theme.styles.body20.copyWith(
                              color: colors.blackAndWhite.shade100,
                            ),
                          ),
                        ],
                      ),
                      PicnicTextButton(
                        label: appLocalizations.viewAllAction,
                        labelStyle: link15BlueStyle,
                        onTap: presenter.onTapViewPods,
                      ),
                    ],
                  ),
                  const Gap(4.0),
                  Text(
                    appLocalizations.discoverPodsDescription,
                    style: theme.styles.subtitle10.copyWith(color: colors.darkBlue.shade700),
                  ),
                  const Gap(16.0),
                  PodList(
                    circlePodApps: state.pods.mapItems((p0) => p0.app),
                    onTapPod: presenter.onTapViewPod,
                    loadMore: presenter.loadMore,
                    onTapSave: presenter.onTapSavePod,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Assets.images.trendingCircles.image(),
                          const Gap(6),
                          Text(
                            appLocalizations.trendingCircles,
                            style: title40,
                          ),
                        ],
                      ),
                      PicnicTextButton(
                        label: appLocalizations.viewAllAction,
                        labelStyle: link15BlueStyle,
                        onTap: presenter.onTapViewCircles,
                      ),
                    ],
                  ),
                  stateObserver(
                    buildWhen: (previous, current) => previous.trendingCircles != current.trendingCircles,
                    builder: (context, state) => TrendingCircles(
                      circles: state.trendingCircles,
                      onTapJoin: presenter.onTapViewCircle,
                      onTapCircleChat: presenter.onTapCircleChat,
                      onTapShareCircle: presenter.onTapShareCircle,
                    ),
                  ),
                ],
              ),
            );

            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: topContent,
                ),
                ...state.feedGroups.map((element) {
                  return _DiscoverExplorePage(
                    circleGroup: element,
                    onTapViewCircles: presenter.onTapViewCircles,
                    onTapViewCircle: presenter.onTapViewCircle,
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

class _DiscoverExplorePage extends StatelessWidget {
  const _DiscoverExplorePage({
    required this.circleGroup,
    required this.onTapViewCircles,
    required this.onTapViewCircle,
  });

  final CircleGroup circleGroup;
  final VoidCallback onTapViewCircles;
  final Function(Id) onTapViewCircle;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);

    final link15BlueStyle = theme.styles.link15.copyWith(color: theme.colors.blue);
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PicnicTitleTextWithPadding(
                text: appLocalizations.circleWithTopic(circleGroup.name),
                topPadding: 0,
                bottomPadding: 0,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 24.0),
                child: PicnicTextButton(
                  label: appLocalizations.viewAllAction,
                  labelStyle: link15BlueStyle,
                  onTap: onTapViewCircles,
                ),
              ),
            ],
          ),
          PicnicCircleListView(
            items: circleGroup.topCircles,
            onTapViewCircle: onTapViewCircle,
          ),
        ],
      ),
    );
  }
}
