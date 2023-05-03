import 'package:flutter/material.dart';
import 'package:picnic_app/features/chat/domain/model/group_chat_more_tab.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_tab.dart';
import 'package:picnic_ui_components/ui/theme/picnic_colors.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class ChatMoreTabs extends StatelessWidget {
  const ChatMoreTabs({
    Key? key,
    required this.tabController,
    required this.selectedTab,
  }) : super(key: key);

  final TabController tabController;
  final GroupChatMoreTab selectedTab;

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
      child: TabBar(
        controller: tabController,
        indicator: const BoxDecoration(),
        labelColor: colors.activeTabColor,
        tabs: [
          PicnicTab(
            iconPath: Assets.images.setting.path,
            title: appLocalizations.settingsLabel,
            isActive: selectedTab == GroupChatMoreTab.settings,
          ),
          PicnicTab(
            iconPath: Assets.images.tusers.path,
            title: appLocalizations.membersLabel,
            isActive: selectedTab == GroupChatMoreTab.members,
          ),
        ],
      ),
    );
  }
}
