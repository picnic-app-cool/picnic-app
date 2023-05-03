import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';

typedef ItemWidgetBuilder = Widget Function(BuildContext context, int index);

//ignore_for_file: unused-code, unused-files
class PagingSliverGrid<T> extends StatelessWidget {
  const PagingSliverGrid({
    Key? key,
    required this.paging,
    required this.loadMore,
    required this.loadingBuilder,
    required this.itemBuilder,
    required this.columns,
    required this.aspectRatio,
    this.crossAxisSpacing = 0,
    this.mainAxiesSpacing = 0,
  }) : super(key: key);

  final PaginatedList<T> paging;
  final int columns;
  final double aspectRatio;
  final double crossAxisSpacing;
  final double mainAxiesSpacing;
  final VoidCallback loadMore;
  final ItemWidgetBuilder itemBuilder;
  final WidgetBuilder loadingBuilder;

  static const double _scrollOffset = 300;

  @override
  Widget build(BuildContext context) => NotificationListener<ScrollNotification>(
        onNotification: _handleScrollNotification,
        child: SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            childAspectRatio: aspectRatio,
            crossAxisSpacing: crossAxisSpacing,
            mainAxisSpacing: mainAxiesSpacing,
          ),
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
