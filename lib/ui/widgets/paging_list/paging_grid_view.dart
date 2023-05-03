import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';

typedef ItemWidgetBuilder = Widget Function(BuildContext context, int index);

class PagingGridView<T> extends StatefulWidget {
  const PagingGridView({
    Key? key,
    required this.paging,
    required this.loadMore,
    required this.loadingBuilder,
    required this.itemBuilder,
    required this.columns,
    required this.aspectRatio,
    this.crossAxisSpacing = 0,
    this.mainAxisSpacing = 0,
  }) : super(key: key);

  final PaginatedList<T> paging;
  final int columns;
  final double aspectRatio;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final Future<void> Function() loadMore;
  final ItemWidgetBuilder itemBuilder;
  final WidgetBuilder loadingBuilder;

  @override
  State<StatefulWidget> createState() => _PagingGridViewState<T>();
}

class _PagingGridViewState<T> extends State<PagingGridView<T>> {
  bool _isLoading = false;

  static const double _scrollOffset = 300;

  @override
  void initState() {
    if (widget.paging.items.isEmpty && widget.paging.hasNextPage) {
      _loadMore();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) => NotificationListener<ScrollNotification>(
        onNotification: _handleScrollNotification,
        child: GridView.builder(
          itemCount: widget.paging.items.length + (widget.paging.isLoadingNext ? 1 : 0),
          itemBuilder: (context, index) =>
              index < widget.paging.items.length ? widget.itemBuilder(context, index) : widget.loadingBuilder(context),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: widget.columns,
            crossAxisSpacing: widget.crossAxisSpacing,
            mainAxisSpacing: widget.mainAxisSpacing,
            childAspectRatio: widget.aspectRatio,
          ),
        ),
      );

  bool _handleScrollNotification(ScrollNotification notification) {
    if (widget.paging.hasNextPage &&
        notification is UserScrollNotification &&
        notification.metrics.extentAfter <= _scrollOffset) {
      _loadMore();
    }

    return false;
  }

  Future<void> _loadMore() async {
    if (!widget.paging.hasNextPage || _isLoading) {
      return;
    }
    setState(() => _isLoading = true);
    await widget.loadMore();
    setState(() => _isLoading = false);
  }
}
