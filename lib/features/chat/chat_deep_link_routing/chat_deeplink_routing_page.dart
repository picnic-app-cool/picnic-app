import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/chat/chat_deep_link_routing/chat_deeplink_routing.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class ChatDeeplinkRoutingPage extends StatefulWidget with HasPresenter<ChatDeeplinkRoutingPresenter> {
  const ChatDeeplinkRoutingPage({
    super.key,
    required this.presenter,
  });

  @override
  final ChatDeeplinkRoutingPresenter presenter;

  @override
  State<ChatDeeplinkRoutingPage> createState() => _ChatDeeplinkRoutingPageState();
}

class _ChatDeeplinkRoutingPageState extends State<ChatDeeplinkRoutingPage>
    with PresenterStateMixin<ChatDeeplinkRoutingViewModel, ChatDeeplinkRoutingPresenter, ChatDeeplinkRoutingPage> {
  @override
  void initState() {
    super.initState();
    presenter.init();
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async => false,
        child: const Scaffold(
          body: Center(
            child: PicnicLoadingIndicator(),
          ),
        ),
      );
}
