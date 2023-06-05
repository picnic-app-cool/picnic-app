// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/discover/discover_pods/discover_pods_presentation_model.dart';
import 'package:picnic_app/features/discover/discover_pods/discover_pods_presenter.dart';
import 'package:picnic_app/features/discover/widgets/picnic_discovery_navigation_bar.dart';
import 'package:picnic_app/features/discover/widgets/pod_circle_banner.dart';
import 'package:picnic_app/features/discover/widgets/pod_list.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_tag.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_text_button.dart';

class DiscoverPodsPage extends StatefulWidget with HasPresenter<DiscoverPodsPresenter> {
  const DiscoverPodsPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final DiscoverPodsPresenter presenter;

  @override
  State<DiscoverPodsPage> createState() => _DiscoverPodsPageState();
}

class _DiscoverPodsPageState extends State<DiscoverPodsPage>
    with PresenterStateMixin<DiscoverPodsViewModel, DiscoverPodsPresenter, DiscoverPodsPage> {
  late final TextEditingController controller;
  late final FocusNode focusNode;
  static const podContainerSize = 400.0;
  static const tagHeight = 30.0;
  static const double _tagsBorderRadius = 8.0;

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
    final link = theme.styles.link15.copyWith(color: theme.colors.blue);

    final tagsRow = SizedBox(
      height: tagHeight,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: state.cats.length,
        separatorBuilder: (context, index) => const Gap(8),
        itemBuilder: (BuildContext context, int index) {
          final tag = state.cats[index];
          final darkBlue = theme.colors.darkBlue;
          return PicnicTag(
            opacity: 1.0,
            style: PicnicTagStyle.outlined,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            titleHeight: 1.0,
            title: tag,
            borderColor: darkBlue.shade700,
            borderRadius: _tagsBorderRadius,
            borderWidth: 0.5,
            backgroundColor: theme.colors.blackAndWhite.shade100,
            titleTextStyle: theme.styles.body10.copyWith(color: darkBlue.shade800),
          );
        },
      ),
    );
    return stateObserver(
      builder: (context, state) {
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
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 24.0,
                          right: 24.0,
                          top: 24.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PodCircleBanner(
                              title: appLocalizations.discoverPods,
                              width: podContainerSize,
                              imagePath: Assets.images.podsBack.path,
                            ),
                            const Gap(16.0),
                            Text(
                              appLocalizations.trendingPods,
                              style: title30,
                            ),
                            const Gap(8.0),
                            stateObserver(
                              buildWhen: (previous, current) => previous.trendingPods != current.trendingPods,
                              builder: (context, state) => PodList(
                                circlePodApps: state.trendingPods,
                                onTapPod: presenter.onTapViewPod,
                                loadMore: presenter.loadMoreTrendingPods,
                                onTapSave: presenter.onTapSavePod,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  appLocalizations.findYourCategory,
                                  style: title30,
                                ),
                                PicnicTextButton(
                                  label: appLocalizations.viewAllAction,
                                  labelStyle: link,
                                  onTap: presenter.onTapCategories,
                                ),
                              ],
                            ),
                            const Gap(8.0),
                            tagsRow,
                            const Gap(16.0),
                            Text(
                              appLocalizations.featuredPods,
                              style: title30,
                            ),
                            const Gap(8.0),
                            PodList(
                              circlePodApps: state.featuredPods,
                              onTapPod: presenter.onTapViewPod,
                              loadMore: presenter.loadMoreFeaturedPods,
                              onTapSave: presenter.onTapSavePod,
                            ),
                            Text(
                              appLocalizations.explorePods,
                              style: title30,
                            ),
                            const Gap(8.0),
                            PodList(
                              circlePodApps: state.newPods,
                              onTapPod: presenter.onTapViewPod,
                              loadMore: presenter.loadMoreNewPods,
                              onTapSave: presenter.onTapSavePod,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
