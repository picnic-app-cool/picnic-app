import 'package:flutter/material.dart';
import 'package:picnic_app/features/profile/domain/public_profile_tab.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/picnic_tab.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PublicProfileTabs extends StatelessWidget {
  const PublicProfileTabs({
    Key? key,
    required this.tabController,
    required this.selectedTab,
    required this.tabs,
  }) : super(key: key);

  final TabController tabController;

  final PublicProfileTab selectedTab;
  final List<PublicProfileTab> tabs;

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
          labelColor: colors.activeTabColor,
          indicatorColor: colors.darkBlue.shade900,
          tabs: tabs.map((it) {
            switch (it) {
              case PublicProfileTab.posts:
                return PicnicTab(
                  title: appLocalizations.postsTabTitle,
                  isActive: selectedTab == PublicProfileTab.posts,
                  bottomPadding: tabPaddingToIndicator,
                );
              case PublicProfileTab.circles:
                return PicnicTab(
                  title: appLocalizations.cirlcesTabTitle,
                  isActive: selectedTab == PublicProfileTab.circles,
                  bottomPadding: tabPaddingToIndicator,
                );
              case PublicProfileTab.collections:
                return PicnicTab(
                  title: appLocalizations.collectionsTabTitle,
                  isActive: selectedTab == PublicProfileTab.collections,
                  bottomPadding: tabPaddingToIndicator,
                );
              case PublicProfileTab.pods:
                return PicnicTab(
                  title: appLocalizations.pods,
                  isActive: selectedTab == PublicProfileTab.pods,
                  bottomPadding: tabPaddingToIndicator,
                );
            }
          }).toList(),
        ),
      ),
    );
  }
}
