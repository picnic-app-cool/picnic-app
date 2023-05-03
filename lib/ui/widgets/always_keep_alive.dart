import 'package:flutter/material.dart';

/// special widget that uses [AutomaticKeepAliveClientMixin] to keep the state alive of its children
class AlwaysKeepAlive extends StatefulWidget {
  const AlwaysKeepAlive({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  State<AlwaysKeepAlive> createState() => _AlwaysKeepAliveState();
}

class _AlwaysKeepAliveState extends State<AlwaysKeepAlive> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}
