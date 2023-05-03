import 'package:flutter/material.dart';
import 'package:picnic_app/features/profile/domain/private_profile_tab.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_tab.dart';
import 'package:picnic_ui_components/ui/theme/picnic_colors.dart';
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

    return Container(
      margin: const EdgeInsets.only(top: 24),
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: PicnicColors.lightGrey,
          ),
        ),
      ),
      child: Center(
        child: TabBar(
          isScrollable: true,
          controller: tabController,
          labelPadding: const EdgeInsets.symmetric(horizontal: 24),
          indicator: const BoxDecoration(),
          labelColor: colors.activeTabColor,
          tabs: tabs.map((it) {
            switch (it) {
              case PrivateProfileTab.posts:
                return PicnicTab(
                  iconPath: Assets.images.image.path,
                  title: appLocalizations.postsTabTitle,
                  isActive: selectedTab == PrivateProfileTab.posts,
                );
              case PrivateProfileTab.circles:
                return PicnicTab(
                  iconPath: Assets.images.tusers.path,
                  title: appLocalizations.cirlcesTabTitle,
                  isActive: selectedTab == PrivateProfileTab.circles,
                );
              case PrivateProfileTab.collections:
                return PicnicTab(
                  iconPath: Assets.images.folder.path,
                  title: appLocalizations.collectionsTabTitle,
                  isActive: selectedTab == PrivateProfileTab.collections,
                );
            }
          }).toList(),
        ),
      ),
    );
  }
}
