import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/chat/chat_dms/chat_dms_presentation_model.dart';
import 'package:picnic_app/features/chat/chat_dms/chat_dms_presenter.dart';
import 'package:picnic_app/features/chat/chat_dms/widgets/dms_list.dart';
import 'package:picnic_app/features/chat/chat_dms/widgets/empty_chats_container.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/empty_view_switcher.dart';
import 'package:picnic_app/ui/widgets/picnic_floating_button.dart';
import 'package:picnic_app/ui/widgets/picnic_soft_search_bar.dart';
import 'package:picnic_app/ui/widgets/status_bars/dark_status_bar.dart';
import 'package:picnic_app/ui/widgets/view_in_foreground_detector.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class ChatDmsPage extends StatefulWidget with HasPresenter<ChatDmsPresenter> {
  const ChatDmsPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final ChatDmsPresenter presenter;

  @override
  State<ChatDmsPage> createState() => _ChatDmsPageState();
}

class _ChatDmsPageState extends State<ChatDmsPage>
    with PresenterStateMixin<ChatDmsViewModel, ChatDmsPresenter, ChatDmsPage>, AutomaticKeepAliveClientMixin {
  late final TextEditingController controller;
  late final FocusNode focusNode;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey();

  static const _bottomNavBarHeight = 64.0;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    controller = TextEditingController();
    focusNode = FocusNode();
    controller.addListener(() => presenter.onChangedSearchText(controller.text));
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        final bottomPadding = isKeyboardVisible ? 0.0 : _bottomNavBarHeight;
        return DarkStatusBar(
          child: Scaffold(
            body: RefreshIndicator(
              displacement: Constants.toolbarHeight,
              key: _refreshIndicatorKey,
              onRefresh: () => presenter.loadMore(fromScratch: true),
              child: ViewInForegroundDetector(
                viewDidAppear: presenter.viewDidAppear,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Constants.mediumPadding,
                  ),
                  child: stateObserver(
                    builder: (context, state) {
                      final dmsChats = state.chats.paginatedList;
                      return Column(
                        children: [
                          PicnicSoftSearchBar(
                            controller: controller,
                            hintText: appLocalizations.chatSearch,
                            focusNode: focusNode,
                            contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          ),
                          Expanded(
                            // Replaced AutomaticKeyboardHide with GestureDetector,
                            // because it has focus conflicts when user tap on TextField
                            child: GestureDetector(
                              onTap: focusNode.unfocus,
                              child: EmptyViewSwitcher(
                                isEmpty: dmsChats.isEmptyNoMorePage,
                                replacement: const EmptyChatsContainer(),
                                child: DmsList(
                                  dmChats: dmsChats,
                                  onTapChat: state.chatDetailsButtonEnabled ? presenter.onTapChat : null,
                                  now: state.now,
                                  loadMoreChats: presenter.loadMore,
                                  onTapConfirmLeaveChat: presenter.onTapConfirmLeaveChat,
                                ),
                              ),
                            ),
                          ),
                          Gap(bottomPadding),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
            floatingActionButton: Padding(
              padding: EdgeInsets.only(bottom: bottomPadding),
              child: PicnicFloatingButton(
                onTap: presenter.onTapCreateNewMessage,
                backgroundColor: PicnicTheme.of(context).colors.blue,
              ),
            ),
          ),
        );
      },
    );
  }
}
