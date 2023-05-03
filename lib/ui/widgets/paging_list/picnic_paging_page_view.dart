import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/ui/widgets/paging_list/load_more_scroll_notification.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class PicnicPagingPageView<T> extends StatelessWidget {
  const PicnicPagingPageView({
    required this.paginatedList,
    required this.loadMore,
    required this.itemBuilder,
    required this.loadingBuilder,
    this.controller,
    this.physics,
    this.reverse = false,
    this.scrollDirection = Axis.horizontal,
    this.allowImplicitScrolling = false,
    this.loadMoreScrollOffset = LoadMoreScrollNotification.defaultScrollOffset,
  });

  final PaginatedList<T> paginatedList;
  final Future<void> Function() loadMore;
  final ItemWidgetBuilder<T> itemBuilder;
  final WidgetBuilder loadingBuilder;
  final bool reverse;
  final ScrollPhysics? physics;
  final Axis scrollDirection;
  final PageController? controller;
  final bool allowImplicitScrolling;
  final double loadMoreScrollOffset;

  @override
  Widget build(BuildContext context) {
    return LoadMoreScrollNotification(
      emptyItems: paginatedList.items.isEmpty,
      loadMoreScrollOffset: loadMoreScrollOffset,
      hasMore: paginatedList.hasNextPage,
      loadMore: loadMore,
      builder: (context) {
        return PageView.builder(
          controller: controller,
          reverse: reverse,
          allowImplicitScrolling: allowImplicitScrolling,
          scrollDirection: scrollDirection,
          physics: physics,
          itemCount: paginatedList.items.length + (paginatedList.hasNextPage ? 1 : 0),
          itemBuilder: (context, index) => index < paginatedList.items.length
              ? itemBuilder(context, paginatedList.items[index])
              : loadingBuilder(context),
        );
      },
    );
  }
}
