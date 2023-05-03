import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/chat/chat_dms/chat_dms_page.dart';
import 'package:picnic_app/features/chat/chat_feed/chat_feed_page.dart';
import 'package:picnic_app/features/chat/chat_my_circles/chat_my_circles_initial_params.dart';
import 'package:picnic_app/features/chat/chat_my_circles/chat_my_circles_page.dart';
import 'package:picnic_app/features/chat/chat_tabs/chat_tabs_presentation_model.dart';
import 'package:picnic_app/features/chat/chat_tabs/chat_tabs_presenter.dart';
import 'package:picnic_app/features/chat/chat_tabs/widgets/chat_profile_bar.dart';
import 'package:picnic_app/features/chat/chat_tabs/widgets/chat_tab_bar.dart';
import 'package:picnic_app/features/chat/chat_tabs/widgets/chat_tab_container.dart';
import 'package:picnic_app/features/chat/domain/model/chat_tab_type.dart';
import 'package:picnic_app/ui/widgets/status_bars/dark_status_bar.dart';

class ChatTabsPage extends StatefulWidget with HasPresenter<ChatTabsPresenter> {
  const ChatTabsPage({
    required this.presenter,
    Key? key,
    required this.chatFeedPage,
    required this.chatDmsPage,
  }) : super(key: key);

  final ChatFeedPage chatFeedPage;
  final ChatDmsPage chatDmsPage;

  @override
  final ChatTabsPresenter presenter;

  @override
  State<ChatTabsPage> createState() => _ChatTabsPageState();
}

class _ChatTabsPageState extends State<ChatTabsPage>
    with PresenterStateMixin<ChatTabsViewModel, ChatTabsPresenter, ChatTabsPage> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DarkStatusBar(
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  stateObserver(
                    builder: (context, state) {
                      return Expanded(
                        child: ChatTabBar(
                          selectedType: state.selectedChatTabType,
                          onTap: _onMenuItemTap,
                        ),
                      );
                    },
                  ),
                  ChatProfileBar(
                    onTapProfile: presenter.onTapProfile,
                    onTapSearch: presenter.onTapSearch,
                  ),
                  const Gap(Constants.mediumPadding),
                ],
              ),
              Expanded(
                child: ChatTabContainer(
                  initialChatTabType: state.selectedChatTabType,
                  chatFeedPage: widget.chatFeedPage,
                  chatMyCirclesPage: const ChatMyCirclesPage(initialParams: ChatMyCirclesInitialParams()),
                  chatDmsPage: widget.chatDmsPage,
                  onPageChanged: (type) => _onChangeTab(context, type),
                  pageController: _pageController,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onMenuItemTap(ChatTabType type) {
    presenter.onTabChanged(type);
    _pageController.jumpToPage(state.selectedChatTabType.stackIndex);
  }

  void _onChangeTab(BuildContext context, ChatTabType type) {
    FocusScope.of(context).unfocus();
    presenter.onTabChanged(type);
  }
}
