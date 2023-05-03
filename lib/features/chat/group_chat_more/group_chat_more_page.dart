import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/group_chat_more_tab.dart';
import 'package:picnic_app/features/chat/group_chat_more/group_chat_more_presentation_model.dart';
import 'package:picnic_app/features/chat/group_chat_more/group_chat_more_presenter.dart';
import 'package:picnic_app/features/chat/group_chat_more/utils/group_chat_more_constants.dart';
import 'package:picnic_app/features/chat/group_chat_more/widgets/chat_more_action_buttons.dart';
import 'package:picnic_app/features/chat/group_chat_more/widgets/chat_more_app_bar.dart';
import 'package:picnic_app/features/chat/group_chat_more/widgets/chat_more_members_tab.dart';
import 'package:picnic_app/features/chat/group_chat_more/widgets/chat_more_settings_tab.dart';
import 'package:picnic_app/features/chat/group_chat_more/widgets/chat_more_tabs.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/status_bars/dark_status_bar.dart';

class GroupChatMorePage extends StatefulWidget with HasPresenter<GroupChatMorePresenter> {
  const GroupChatMorePage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final GroupChatMorePresenter presenter;

  @override
  State<GroupChatMorePage> createState() => _GroupChatMorePageState();
}

class _GroupChatMorePageState extends State<GroupChatMorePage>
    with
        PresenterStateMixin<GroupChatMoreViewModel, GroupChatMorePresenter, GroupChatMorePage>,
        SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: GroupChatMoreConstants.tabsCount, vsync: this);
    _tabController.index = state.selectedTab.index;
    _tabController.addListener(
      () => presenter.onTabChanged(GroupChatMoreTab.values[_tabController.index]),
    );
    presenter.onInit();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DarkStatusBar(
      child: stateObserver(
        buildWhen: (previous, current) =>
            previous.membersCount != current.membersCount ||
            previous.onlineCount != current.onlineCount ||
            previous.isAddMembersVisible != current.isAddMembersVisible,
        builder: (context, state) => Scaffold(
          appBar: ChatMoreAppBar(
            title: state.groupName,
            subtitle: appLocalizations.groupChatMoreSubtitle(state.membersCount, state.onlineCount),
          ),
          body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool _) => [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: ChatMoreActionButtons(
                    onTapLeave: presenter.onTapLeave,
                    onTapReport: presenter.onTapReport,
                    onTapAddMembers: presenter.onTapAddMembers,
                    isAddMembersVisible: state.isAddMembersVisible,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: stateObserver(
                  buildWhen: (previous, current) => previous.selectedTab != current.selectedTab,
                  builder: (context, state) => ChatMoreTabs(
                    tabController: _tabController,
                    selectedTab: state.selectedTab,
                  ),
                ),
              ),
            ],
            body: TabBarView(
              controller: _tabController,
              children: [
                stateObserver(
                  buildWhen: (previous, current) =>
                      previous.groupName != current.groupName ||
                      previous.chatSettings.isMuted != current.chatSettings.isMuted,
                  builder: (context, state) => ChatMoreSettingsTab(
                    onTapSwitchNotifications: (value) => presenter.onSwitchNotificationChanged(enabled: value),
                    onChangedSearchText: presenter.onGroupNameChanged,
                    groupName: state.groupName,
                    isMuted: state.chatSettings.isMuted,
                  ),
                ),
                stateObserver(
                  buildWhen: (previous, current) => previous.members != current.members,
                  builder: (context, state) => ChatMoreMembersTab(
                    members: state.members,
                    isRemoveUserEnabled: state.isRemoveUsersEnabled,
                    onTapUser: presenter.onTapUser,
                    onTapRemove: presenter.onTapRemoveMember,
                    onLoadMore: presenter.loadMoreMembers,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
