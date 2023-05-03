import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/chat/chat_feed/chat_feed_presentation_model.dart';
import 'package:picnic_app/features/chat/chat_feed/chat_feed_presenter.dart';
import 'package:picnic_app/features/chat/chat_feed/widgets/feed_list.dart';
import 'package:picnic_app/ui/widgets/picnic_rainbow_background.dart';
import 'package:picnic_app/ui/widgets/status_bars/dark_status_bar.dart';
import 'package:picnic_app/ui/widgets/view_in_foreground_detector.dart';

class ChatFeedPage extends StatefulWidget with HasPresenter<ChatFeedPresenter> {
  const ChatFeedPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final ChatFeedPresenter presenter;

  @override
  State<ChatFeedPage> createState() => _ChatFeedPageState();
}

class _ChatFeedPageState extends State<ChatFeedPage>
    with
        PresenterStateMixin<ChatFeedViewModel, ChatFeedPresenter, ChatFeedPage>,
        AutomaticKeepAliveClientMixin,
        WidgetsBindingObserver {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    presenter.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    presenter.onAppLifecycleStateChange(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DarkStatusBar(
      child: Scaffold(
        body: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: presenter.refresh,
          child: stateObserver(
            builder: (context, state) => ViewInForegroundDetector(
              viewDidAppear: presenter.viewDidAppear,
              child: PicnicRainbowBackground(
                child: FeedList(
                  chatMessagesFeedList: state.chatMessagesFeedList,
                  loadMore: presenter.loadMore,
                  onTapCircle: presenter.onTapCircle,
                  onTapFeed: state.chatDetailsButtonEnabled ? presenter.onTapFeed : null,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
