import 'dart:async';

import 'package:flutter/material.dart';

const _refreshIndicatorDefaultDisplacement = 40.0;

class PicnicRefreshIndicator extends StatefulWidget {
  const PicnicRefreshIndicator({
    super.key,
    required this.isRefreshing,
    required this.onRefresh,
    required this.child,
    this.displacement = _refreshIndicatorDefaultDisplacement,
  });

  final bool isRefreshing;
  final double displacement;
  final Future<void> Function() onRefresh;
  final Widget child;

  @override
  State<PicnicRefreshIndicator> createState() => _PicnicRefreshIndicatorState();
}

class _PicnicRefreshIndicatorState extends State<PicnicRefreshIndicator> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey();
  Completer<void>? _onRefreshCompleter;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      _syncIsRefreshingWithIndicator();
    });
  }

  @override
  void didUpdateWidget(covariant PicnicRefreshIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isRefreshing != oldWidget.isRefreshing) {
      _syncIsRefreshingWithIndicator();
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      displacement: widget.displacement,
      onRefresh: _onRefresh,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _onRefreshCompleter?.complete();
    super.dispose();
  }

  void _syncIsRefreshingWithIndicator() {
    if (widget.isRefreshing && _onRefreshCompleter == null) {
      _onRefreshCompleter = Completer();
      _refreshIndicatorKey.currentState?.show();
    } else if (!widget.isRefreshing && _onRefreshCompleter != null) {
      _onRefreshCompleter?.complete();
      _onRefreshCompleter = null;
    }
  }

  Future<void> _onRefresh() async {
    if (_onRefreshCompleter == null) {
      // [RefreshIndicator] triggered manually by swiping it down
      assert(!widget.isRefreshing);

      return widget.onRefresh();
    }
    return _onRefreshCompleter?.future;
  }
}
