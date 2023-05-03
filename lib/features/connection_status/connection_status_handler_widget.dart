import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/connection_status/connection_status_handler_presenter.dart';

class ConnectionStatusHandlerWidget extends StatefulWidget with HasPresenter<ConnectionStatusHandlerPresenter> {
  const ConnectionStatusHandlerWidget({
    super.key,
    required this.presenter,
    required this.child,
  });

  final Widget child;

  @override
  final ConnectionStatusHandlerPresenter presenter;

  @override
  State<ConnectionStatusHandlerWidget> createState() => _ConnectionStatusHandlerWidgetState();
}

class _ConnectionStatusHandlerWidgetState extends State<ConnectionStatusHandlerWidget> {
  @override
  void initState() {
    super.initState();
    widget.presenter.onInit();
  }

  @override
  void dispose() {
    widget.presenter.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Material(child: widget.child);
}
