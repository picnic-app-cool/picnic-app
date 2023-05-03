//ignore_for_file: unused-files, unused-code
import 'package:flutter/material.dart';

class LoadMoreScrollNotification extends StatefulWidget {
  const LoadMoreScrollNotification({
    required this.builder,
    required this.hasMore,
    required this.loadMore,
    required this.emptyItems,
    this.loadMoreScrollOffset = defaultScrollOffset,
  });

  final WidgetBuilder builder;
  final double loadMoreScrollOffset;
  final bool hasMore;
  final bool emptyItems;
  final Future<void> Function() loadMore;

  static const double defaultScrollOffset = 300;

  @override
  State<LoadMoreScrollNotification> createState() => _LoadMoreScrollNotificationState();
}

class _LoadMoreScrollNotificationState extends State<LoadMoreScrollNotification> {
  bool _isLoading = false;

  @override
  void initState() {
    if (widget.emptyItems && widget.hasMore) {
      _loadMore();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: widget.builder(context),
    );
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (widget.hasMore && notification.metrics.extentAfter <= widget.loadMoreScrollOffset) {
      _loadMore();
    }

    return false;
  }

  Future<void> _loadMore() async {
    if (!widget.hasMore || _isLoading) {
      return;
    }
    setState(() => _isLoading = true);
    await widget.loadMore();
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }
}
