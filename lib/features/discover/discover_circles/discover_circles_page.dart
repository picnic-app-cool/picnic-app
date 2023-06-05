// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/discover/discover_circles/discover_circles_presentation_model.dart';
import 'package:picnic_app/features/discover/discover_circles/discover_circles_presenter.dart';
import 'package:picnic_app/features/discover/discover_explore/widgets/picnic_circle_listview.dart';
import 'package:picnic_app/features/discover/discover_explore/widgets/picnic_title_text_with_padding.dart';
import 'package:picnic_app/features/discover/discover_explore/widgets/trending_circles.dart';
import 'package:picnic_app/features/discover/widgets/picnic_discovery_navigation_bar.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

//ignore_for_file: maximum-nesting-level
class DiscoverCirclesPage extends StatefulWidget with HasPresenter<DiscoverCirclesPresenter> {
  const DiscoverCirclesPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final DiscoverCirclesPresenter presenter;

  @override
  State<DiscoverCirclesPage> createState() => _DiscoverCirclesPageState();
}

class _DiscoverCirclesPageState extends State<DiscoverCirclesPage>
    with PresenterStateMixin<DiscoverCirclesViewModel, DiscoverCirclesPresenter, DiscoverCirclesPage> {
  late final TextEditingController controller;
  late final FocusNode focusNode;

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
            final title30 = theme.styles.title30;
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
                        child: Text(
                          appLocalizations.trendingCircles,
                          style: title30,
                        ),
                      ),
                      const Gap(20.0),
                      stateObserver(
                        buildWhen: (previous, current) => previous.trendingCircles != current.trendingCircles,
                        builder: (context, state) => Padding(
                          padding: const EdgeInsets.only(
                            left: 24.0,
                            right: 24.0,
                          ),
                          child: TrendingCircles(
                            circles: state.trendingCircles,
                            onTapJoin: presenter.onTapViewCircle,
                            onTapShareCircle: presenter.onTapShareCircle,
                            onTapCircleChat: presenter.onTapCircleChat,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 24.0,
                          right: 24.0,
                        ),
                        child: Text(
                          appLocalizations.exploreCircles,
                          style: title30,
                        ),
                      ),
                      PicnicCircleListView(
                        items: state.trendingCircles,
                        onTapViewCircle: presenter.onTapViewCircle,
                      ),
                    ],
                  ),
                ),
                ...state.feedGroups.map((element) {
                  return SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(4),
                        PicnicTitleTextWithPadding(
                          text: appLocalizations.circleWithTopic(element.name),
                          topPadding: 0,
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
