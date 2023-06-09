import 'package:flutter/material.dart';
import 'package:picnic_app/features/pods/domain/model/preview_pod_tab.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/picnic_tab.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PodPreviewTabs extends StatelessWidget {
  const PodPreviewTabs({
    Key? key,
    required this.tabController,
    required this.selectedTab,
    required this.tabs,
  }) : super(key: key);

  final TabController tabController;

  final PreviewPodTab selectedTab;
  final List<PreviewPodTab> tabs;

  @override
  Widget build(BuildContext context) {
    final colors = PicnicTheme.of(context).colors;
    const tabPaddingToIndicator = 12.0;
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Center(
        child: TabBar(
          controller: tabController,
          indicatorColor: colors.darkBlue.shade900,
          labelColor: colors.activeTabColor,
          tabs: tabs.map((it) {
            switch (it) {
              case PreviewPodTab.launch:
                return PicnicTab(
                  title: appLocalizations.launchAction,
                  isActive: selectedTab == PreviewPodTab.launch,
                  bottomPadding: tabPaddingToIndicator,
                );
              case PreviewPodTab.addToCircles:
                return PicnicTab(
                  title: appLocalizations.addToCircles,
                  isActive: selectedTab == PreviewPodTab.addToCircles,
                  bottomPadding: tabPaddingToIndicator,
                );
            }
          }).toList(),
        ),
      ),
    );
  }
}
