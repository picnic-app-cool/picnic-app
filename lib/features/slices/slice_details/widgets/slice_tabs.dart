import 'package:flutter/material.dart';
import 'package:picnic_app/features/slices/domain/model/slice_details_tab.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_tab.dart';
import 'package:picnic_ui_components/ui/theme/picnic_colors.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class SliceTabs extends StatelessWidget {
  const SliceTabs({
    Key? key,
    required this.tabController,
    required this.selectedTab,
    required this.tabs,
  }) : super(key: key);

  final TabController tabController;
  final SliceDetailsTab selectedTab;
  final List<SliceDetailsTab> tabs;

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
              case SliceDetailsTab.members:
                return PicnicTab(
                  iconPath: Assets.images.tusers.path,
                  title: appLocalizations.membersLabel,
                  isActive: selectedTab == SliceDetailsTab.members,
                );
              case SliceDetailsTab.circleInfo:
                return PicnicTab(
                  iconPath: Assets.images.reports.path,
                  title: appLocalizations.sliceTabCircleInfo,
                  isActive: selectedTab == SliceDetailsTab.circleInfo,
                );
              case SliceDetailsTab.rules:
                return PicnicTab(
                  iconPath: Assets.images.file.path,
                  title: appLocalizations.sliceTabRules,
                  isActive: selectedTab == SliceDetailsTab.rules,
                );
            }
          }).toList(),
        ),
      ),
    );
  }
}
