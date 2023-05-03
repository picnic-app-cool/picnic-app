import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';

typedef ItemWidgetBuilder = Widget Function(BuildContext context, int index);

class PagingSliverList<T> extends StatelessWidget {
  const PagingSliverList({
    Key? key,
    required this.paging,
    required this.loadMore,
    required this.loadingBuilder,
    required this.itemBuilder,
  }) : super(key: key);

  final PaginatedList<T> paging;
  final VoidCallback loadMore;
  final ItemWidgetBuilder itemBuilder;
  final WidgetBuilder loadingBuilder;

  static const double _scrollOffset = 300;

  @override
  Widget build(BuildContext context) => NotificationListener<ScrollNotification>(
        onNotification: _handleScrollNotification,
        child: SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => index < paging.items.length ? itemBuilder(context, index) : loadingBuilder(context),
            childCount: paging.items.length + (paging.isLoadingNext ? 1 : 0),
          ),
        ),
      );

  bool _handleScrollNotification(ScrollNotification notification) {
    if (paging.hasNextPage &&
        notification is UserScrollNotification &&
        notification.metrics.extentAfter <= _scrollOffset) {
      loadMore();
    }

    return false;
  }
}
