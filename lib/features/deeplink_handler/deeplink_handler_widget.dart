import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/deeplink_handler/deeplink_handler_presenter.dart';

class DeeplinkHandlerWidget extends StatefulWidget with HasPresenter<DeeplinkHandlerPresenter> {
  const DeeplinkHandlerWidget({
    Key? key,
    required this.presenter,
    required this.child,
  }) : super(key: key);

  final Widget child;
  @override
  final DeeplinkHandlerPresenter presenter;

  @override
  State<DeeplinkHandlerWidget> createState() => _DeeplinkHandlerWidgetState();
}

class _DeeplinkHandlerWidgetState extends State<DeeplinkHandlerWidget> {
  @override
  Widget build(BuildContext context) => Material(child: widget.child);

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
}
