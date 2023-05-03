//ignore_for_file: unused-files, unused-code
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/ui/widgets/paging_list/load_more_scroll_notification.dart';
import 'package:picnic_app/ui/widgets/paging_list/picnic_paging_list_view.dart';

class PicnicPagingStaggeredGridView<T> extends StatelessWidget {
  const PicnicPagingStaggeredGridView({
    Key? key,
    required this.paginatedList,
    required this.loadMore,
    required this.itemBuilder,
    required this.loadingBuilder,
    this.controller,
  }) : super(key: key);

  final PaginatedList<T> paginatedList;
  final Future<void> Function() loadMore;
  final ItemWidgetBuilder<T> itemBuilder;
  final WidgetBuilder loadingBuilder;
  final ScrollController? controller;

  static const _crossAxisCount = 2;
  static const _mainAxisSpacing = 12.0;

  @override
  Widget build(BuildContext context) {
    return LoadMoreScrollNotification(
      hasMore: paginatedList.hasNextPage,
      loadMore: loadMore,
      emptyItems: paginatedList.items.isEmpty,
      builder: (context) => MasonryGridView.count(
        controller: controller,
        crossAxisCount: _crossAxisCount,
        mainAxisSpacing: _mainAxisSpacing,
        itemCount: paginatedList.items.length + (paginatedList.hasNextPage ? 1 : 0),
        itemBuilder: (context, index) => index < paginatedList.items.length
            ? itemBuilder(context, paginatedList.items[index])
            : loadingBuilder(context),
      ),
    );
  }
}
