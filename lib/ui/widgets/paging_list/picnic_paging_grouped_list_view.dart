import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/ui/widgets/grouped_list/grouped_list_view.dart';
import 'package:picnic_app/ui/widgets/paging_list/load_more_scroll_notification.dart';

typedef PicnicPagingGroupedItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class PicnicPagingGroupedListView<T, E> extends StatelessWidget {
  const PicnicPagingGroupedListView({
    Key? key,
    required this.paginatedList,
    required this.groupBy,
    required this.groupSeparatorBuilder,
    required this.loadMore,
    required this.itemBuilder,
    required this.loadingBuilder,
    this.useStickyGroupSeparators = true,
    this.separator = const SizedBox.shrink(),
    this.padding,
    this.physics,
    this.shrinkWrap = false,
    this.reverse = false,
    this.clipBehavior = Clip.hardEdge,
  }) : super(key: key);

  final PaginatedList<T> paginatedList;
  final E Function(T element) groupBy;
  final Widget Function(E value) groupSeparatorBuilder;
  final Future<void> Function() loadMore;
  final bool useStickyGroupSeparators;
  final PicnicPagingGroupedItemWidgetBuilder<T> itemBuilder;
  final Widget separator;
  final WidgetBuilder loadingBuilder;
  final EdgeInsetsGeometry? padding;
  final bool shrinkWrap;
  final bool reverse;
  final ScrollPhysics? physics;
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    return LoadMoreScrollNotification(
      emptyItems: paginatedList.items.isEmpty,
      hasMore: paginatedList.hasNextPage,
      loadMore: loadMore,
      builder: (context) {
        return GroupedListView<T, E>(
          elements: paginatedList.items,
          groupBy: groupBy,
          groupHeaderBuilder: groupSeparatorBuilder,
          loadingBuilder: paginatedList.hasNextPage ? loadingBuilder : null,
          separator: separator,
          useStickyGroupSeparators: useStickyGroupSeparators,
          itemBuilder: itemBuilder,
          reverse: reverse,
          padding: padding,
          shrinkWrap: shrinkWrap,
          physics: physics,
          clipBehavior: clipBehavior,
        );
      },
    );
  }
}
