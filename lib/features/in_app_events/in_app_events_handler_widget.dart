import 'package:flutter/material.dart';
import 'package:picnic_app/features/in_app_events/in_app_event_presentable.dart';

class InAppEventsHandlerWidget extends StatefulWidget {
  const InAppEventsHandlerWidget({
    super.key,
    required this.inAppEventsPresenters,
    required this.child,
  });

  final Widget child;

  final List<InAppEventPresentable> inAppEventsPresenters;

  @override
  State<InAppEventsHandlerWidget> createState() => _InAppEventsHandlerWidgetState();
}

class _InAppEventsHandlerWidgetState extends State<InAppEventsHandlerWidget> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) => Material(child: widget.child);

  @override
  void initState() {
    super.initState();
    for (final presenter in widget.inAppEventsPresenters) {
      presenter.onInit();
    }
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    for (final presenter in widget.inAppEventsPresenters) {
      presenter.dispose();
    }

    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    for (final presenter in widget.inAppEventsPresenters) {
      presenter.onAppLifecycleStateChange(state);
    }
  }
}
