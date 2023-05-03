import 'package:flutter/material.dart';
import 'package:picnic_app/features/circles/domain/model/circle_tab.dart';
import 'package:picnic_app/ui/widgets/picnic_tab.dart';
import 'package:picnic_ui_components/ui/theme/picnic_colors.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class CircleTabs extends StatelessWidget {
  const CircleTabs({
    Key? key,
    required this.tabController,
    required this.selectedTab,
    required this.tabs,
  }) : super(key: key);

  final TabController tabController;
  final CircleTab selectedTab;
  final List<CircleTab> tabs;

  @override
  Widget build(BuildContext context) {
    final colors = PicnicTheme.of(context).colors;

    return Container(
      margin: const EdgeInsets.only(top: 14),
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
          tabs: tabs
              .map(
                (it) => PicnicTab(
                  iconPath: it.icon,
                  title: it.label,
                  isActive: selectedTab == it,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
