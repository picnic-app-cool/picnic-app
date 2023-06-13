import 'package:flutter/material.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/chat/chat_my_circles/chat_my_circles_initial_params.dart';
import 'package:picnic_app/features/chat/chat_my_circles/chat_my_circles_presentation_model.dart';
import 'package:picnic_app/features/chat/chat_my_circles/chat_my_circles_presenter.dart';
import 'package:picnic_app/features/chat/chat_my_circles/widgets/my_circles_list.dart';
import 'package:picnic_app/features/main/widgets/bottom_navigation_size_query.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/picnic_soft_search_bar.dart';
import 'package:picnic_app/ui/widgets/status_bars/dark_status_bar.dart';
import 'package:picnic_app/ui/widgets/view_in_foreground_detector.dart';

class ChatMyCirclesPage extends StatefulWidget with HasInitialParams {
  const ChatMyCirclesPage({
    Key? key,
    required this.initialParams,
  }) : super(key: key);

  @override
  final ChatMyCirclesInitialParams initialParams;

  @override
  State<ChatMyCirclesPage> createState() => _ChatMyCirclesPageState();
}

class _ChatMyCirclesPageState extends State<ChatMyCirclesPage>
    with
        PresenterStateMixinAuto<ChatMyCirclesViewModel, ChatMyCirclesPresenter, ChatMyCirclesPage>,
        AutomaticKeepAliveClientMixin {
  late final TextEditingController controller;
  late final FocusNode focusNode;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey();

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
    final bottomNavBarHeight = BottomNavigationSizeQuery.of(context).height;

    return DarkStatusBar(
      child: Scaffold(
        body: RefreshIndicator(
          displacement: Constants.toolbarHeight,
          key: _refreshIndicatorKey,
          onRefresh: () => presenter.loadMore(fromScratch: true),
          child: ViewInForegroundDetector(
            viewDidAppear: presenter.viewDidAppear,
            child: Padding(
              padding: EdgeInsets.only(
                left: Constants.mediumPadding,
                right: Constants.mediumPadding,
                bottom: bottomNavBarHeight,
              ),
              child: stateObserver(
                builder: (context, state) => Column(
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
                        child: MyCirclesList(
                          circleChats: state.circleChatItems,
                          loadMore: presenter.loadMore,
                          now: state.now,
                          onTapCircle: presenter.onTapCircle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
