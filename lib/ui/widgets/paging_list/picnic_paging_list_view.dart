import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class PicnicPagingListView<T> extends StatefulWidget {
  const PicnicPagingListView({
    Key? key,
    required this.paginatedList,
    required this.loadMore,
    required this.itemBuilder,
    this.separatorBuilder,
    required this.loadingBuilder,
    this.padding,
    this.physics,
    this.shrinkWrap = false,
    this.reverse = false,
    this.clipBehavior = Clip.hardEdge,
    this.scrollDirection = Axis.vertical,
  }) : super(key: key);

  final PaginatedList<T> paginatedList;
  final Future<void> Function() loadMore;
  final ItemWidgetBuilder<T> itemBuilder;
  final IndexedWidgetBuilder? separatorBuilder;
  final WidgetBuilder loadingBuilder;
  final EdgeInsetsGeometry? padding;
  final bool shrinkWrap;
  final bool reverse;
  final ScrollPhysics? physics;
  final Clip clipBehavior;
  final Axis scrollDirection;

  @override
  State<PicnicPagingListView<T>> createState() => _PicnicPagingListViewState<T>();
}

class _PicnicPagingListViewState<T> extends State<PicnicPagingListView<T>> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    if (widget.separatorBuilder != null) {
      return ListView.separated(
        reverse: widget.reverse,
        scrollDirection: widget.scrollDirection,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        separatorBuilder: widget.separatorBuilder!,
        padding: widget.padding,
        shrinkWrap: widget.shrinkWrap,
        physics: widget.physics,
        itemCount: widget.paginatedList.items.length + (widget.paginatedList.hasNextPage ? 1 : 0),
        itemBuilder: (context, index) => index < widget.paginatedList.items.length
            ? widget.itemBuilder(context, widget.paginatedList.items[index])
            : _LoadingBuilder(loadingBuilder: widget.loadingBuilder, loadMore: _loadMore),
        clipBehavior: widget.clipBehavior,
      );
    }

    return ListView.builder(
      scrollDirection: widget.scrollDirection,
      reverse: widget.reverse,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: widget.padding,
      shrinkWrap: widget.shrinkWrap,
      physics: widget.physics,
      itemCount: widget.paginatedList.items.length + (widget.paginatedList.hasNextPage ? 1 : 0),
      itemBuilder: (context, index) => index < widget.paginatedList.items.length
          ? widget.itemBuilder(context, widget.paginatedList.items[index])
          : _LoadingBuilder(loadingBuilder: widget.loadingBuilder, loadMore: _loadMore),
      clipBehavior: widget.clipBehavior,
    );
  }

  Future<void> _loadMore() async {
    if (!widget.paginatedList.hasNextPage || _isLoading) {
      return;
    }
    setState(() => _isLoading = true);
    await widget.loadMore();
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }
}

class _LoadingBuilder extends StatelessWidget {
  const _LoadingBuilder({
    Key? key,
    required this.loadingBuilder,
    required this.loadMore,
  }) : super(key: key);

  final WidgetBuilder loadingBuilder;
  final Future<void> Function() loadMore;

  @override
  Widget build(BuildContext context) {
    /// we load more as soon as loadingIndicator is built, because we want to make sure that short lists,
    /// where first page is not enough to fill entire viewport,
    /// start loading next pages until entire visible part of the list is filled with items.
    WidgetsBinding.instance.addPostFrameCallback((_) => loadMore());
    return Builder(builder: loadingBuilder);
  }
}
