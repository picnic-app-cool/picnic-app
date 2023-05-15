import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/circle_pod_app.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/circles/discover_pods/discover_pods_initial_params.dart';
import 'package:picnic_app/features/circles/discover_pods/discover_pods_presentation_model.dart';
import 'package:picnic_app/features/circles/discover_pods/discover_pods_presenter.dart';
import 'package:picnic_app/features/circles/discover_pods/widgets/pod_tag.dart';
import 'package:picnic_app/features/circles/discover_pods/widgets/pod_widget.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/paging_list/paging_grid_view.dart';
import 'package:picnic_app/ui/widgets/picnic_tag.dart';
import 'package:picnic_app/ui/widgets/status_bars/dark_status_bar.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class DiscoverPodsPage extends StatefulWidget with HasInitialParams {
  const DiscoverPodsPage({
    super.key,
    required this.initialParams,
  });

  @override
  final DiscoverPodsInitialParams initialParams;

  @override
  State<DiscoverPodsPage> createState() => _DiscoverPodsPageState();
}

class _DiscoverPodsPageState extends State<DiscoverPodsPage>
    with PresenterStateMixinAuto<DiscoverPodsViewModel, DiscoverPodsPresenter, DiscoverPodsPage> {
  static const radius = 16.0;
  static const _tagRadius = 100.0;

  static const int _columns = 3;
  static const double _aspectRatio = 0.74;
  static const double _invertedAspectRatio = 1.34;
  static const double _spacing = 8;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final themeColors = theme.colors;
    final blackAndWhite = themeColors.blackAndWhite;
    final blackWhiteShade200 = blackAndWhite.shade200;
    final widthLeftForPods = MediaQuery.of(context).size.width - (radius * 2 + _spacing * 2);
    final podWidth = widthLeftForPods / _columns;
    return DarkStatusBar(
      child: Scaffold(
        appBar: PicnicAppBar(
          backgroundColor: themeColors.blackAndWhite.shade100,
          child: PodTag(title: appLocalizations.pods),
        ),
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

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: radius),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Gap(radius),
                  Container(
                    decoration: BoxDecoration(
                      color: blackWhiteShade200,
                      borderRadius: BorderRadius.circular(radius),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(38.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                appLocalizations.pods,
                                style: theme.styles.title20,
                              ),
                              const Gap(radius),
                              PicnicTag(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                borderRadius: _tagRadius,
                                title: appLocalizations.newFeature,
                                gradient: linearGradient,
                                titleTextStyle: theme.styles.body20.copyWith(
                                  color: blackAndWhite.shade100,
                                ),
                              ),
                            ],
                          ),
                          const Gap(4.0),
                          Text(
                            appLocalizations.podsDescription,
                            style: theme.styles.caption20.copyWith(color: blackAndWhite.shade600),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Gap(radius),
                  Expanded(
                    child: PagingGridView<CirclePodApp>(
                      paging: state.mockedPodsList,
                      columns: _columns,
                      aspectRatio: (widthLeftForPods / MediaQuery.of(context).size.height) / _aspectRatio,
                      loadMore: presenter.loadMore,
                      loadingBuilder: (_) => const PicnicLoadingIndicator(),
                      crossAxisSpacing: _spacing,
                      mainAxisSpacing: _spacing,
                      itemBuilder: (context, index) {
                        final pod = state.mockedPodsList.items[index];
                        return PodWidget(
                          width: podWidth,
                          height: podWidth * _invertedAspectRatio,
                          pod: pod.app,
                          onTap: () => presenter.onTapPod(pod),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
