import 'package:flutter/material.dart';
import 'package:picnic_app/features/profile/domain/private_profile_tab.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/picnic_tab.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PrivateProfileTabs extends StatelessWidget {
  const PrivateProfileTabs({
    Key? key,
    required this.tabController,
    required this.selectedTab,
    required this.tabs,
  }) : super(key: key);

  final TabController tabController;

  final PrivateProfileTab selectedTab;
  final List<PrivateProfileTab> tabs;

  @override
  Widget build(BuildContext context) {
    final colors = PicnicTheme.of(context).colors;
    const tabPaddingToIndicator = 12.0;

    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Center(
        child: TabBar(
          isScrollable: true,
          controller: tabController,
          labelPadding: const EdgeInsets.symmetric(horizontal: 24),
          indicatorColor: colors.darkBlue.shade900,
          labelColor: colors.activeTabColor,
          tabs: tabs.map((it) {
            switch (it) {
              case PrivateProfileTab.posts:
                return PicnicTab(
                  title: appLocalizations.postsTabTitle,
                  isActive: selectedTab == PrivateProfileTab.posts,
                  bottomPadding: tabPaddingToIndicator,
                );
              case PrivateProfileTab.pods:
                return PicnicTab(
                  title: appLocalizations.pods,
                  isActive: selectedTab == PrivateProfileTab.pods,
                  bottomPadding: tabPaddingToIndicator,
                );
              case PrivateProfileTab.circles:
                return PicnicTab(
                  title: appLocalizations.cirlcesTabTitle,
                  isActive: selectedTab == PrivateProfileTab.circles,
                  bottomPadding: tabPaddingToIndicator,
                );
              case PrivateProfileTab.collections:
                return PicnicTab(
                  title: appLocalizations.collectionsTabTitle,
                  isActive: selectedTab == PrivateProfileTab.collections,
                  bottomPadding: tabPaddingToIndicator,
                );
              case PrivateProfileTab.seeds:
                return PicnicTab(
                  title: appLocalizations.seedsTitle,
                  isActive: selectedTab == PrivateProfileTab.seeds,
                  bottomPadding: tabPaddingToIndicator,
                );
            }
          }).toList(),
        ),
      ),
    );
  }
}
