import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/pods/domain/model/preview_pod_tab.dart';
import 'package:picnic_app/features/pods/previewPod/preview_pod_initial_params.dart';
import 'package:picnic_app/features/pods/previewPod/preview_pod_presentation_model.dart';
import 'package:picnic_app/features/pods/previewPod/preview_pod_presenter.dart';
import 'package:picnic_app/features/pods/previewPod/widgets/pod_preview_tabs.dart';
import 'package:picnic_app/features/pods/previewPod/widgets/preview_pod_tab_widget.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/picnic_soft_search_bar.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';

class PreviewPodPage extends StatefulWidget with HasInitialParams {
  const PreviewPodPage({
    super.key,
    required this.initialParams,
  });

  @override
  final PreviewPodInitialParams initialParams;

  @override
  State<PreviewPodPage> createState() => _PreviewPodPageState();
}

class _PreviewPodPageState extends State<PreviewPodPage>
    with
        PresenterStateMixinAuto<PreviewPodViewModel, PreviewPodPresenter, PreviewPodPage>,
        SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: state.tabs.length, vsync: this);
    _tabController.index = state.tabs.indexOf(state.selectedTab);
    _tabController.addListener(() => presenter.onTabChanged(_tabController.index));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = PicnicAppBar(
      child: PicnicSoftSearchBar(
        onChanged: (newQuery) => presenter.onSearchTextChanged(newQuery),
        hintText: appLocalizations.search,
      ),
    );
    return Scaffold(
      appBar: appBar,
      body: Column(
        children: [
          stateObserver(
            builder: (context, state) => PodPreviewTabs(
              tabs: state.tabs,
              tabController: _tabController,
              selectedTab: state.selectedTab,
            ),
          ),
          Flexible(
            child: TabBarView(
              controller: _tabController,
              children: state.tabs.map(
                (tab) {
                  switch (tab) {
                    case PreviewPodTab.launch:
                      return stateObserver(
                        buildWhen: (previous, current) => previous.circlesToLaunchPodIn != current.circlesToLaunchPodIn,
                        builder: (context, state) => PreviewPodTabWidget(
                          circles: state.circlesToLaunchPodIn,
                          onLoadMore: presenter.loadCirclesThatCanBeLaunched,
                          onTapCircle: presenter.onTapLaunchPodInCircle,
                          title: appLocalizations.launchPodTitle(state.pod.name),
                          description: appLocalizations.launchPodDescription,
                        ),
                      );
                    case PreviewPodTab.addToCircles:
                      return stateObserver(
                        buildWhen: (previous, current) => previous.circlesToEnablePodIn != current.circlesToEnablePodIn,
                        builder: (context, state) => PreviewPodTabWidget(
                          circles: state.circlesToEnablePodIn,
                          onLoadMore: presenter.loadCirclesToEnablePod,
                          onTapCircle: presenter.onTapEnablePodInCircle,
                          title: appLocalizations.addPodToCircleTitle(state.pod.name),
                          description: appLocalizations.addPodToCircleDescription,
                        ),
                      );
                  }
                },
              ).toList(),
            ),
          ),
          const Gap(20),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
