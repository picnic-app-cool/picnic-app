import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/collection.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/ui/widgets/paging_list/paging_grid_view.dart';
import 'package:picnic_app/ui/widgets/picnic_collection_card.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

typedef OnTapCollection = void Function(Collection collection);

class CollectionsTab extends StatelessWidget {
  const CollectionsTab({
    Key? key,
    required this.collections,
    required this.onLoadMore,
    required this.isLoading,
    required this.onTapCollection,
  }) : super(key: key);

  final PaginatedList<Collection> collections;
  final Future<void> Function() onLoadMore;
  final bool isLoading;
  final OnTapCollection onTapCollection;

  static const int _columns = 2;
  static const double _aspectRatio = 0.66;
  static const double _spacing = 8;

  @override
  Widget build(BuildContext context) => PagingGridView<Collection>(
        paging: collections,
        columns: _columns,
        aspectRatio: _aspectRatio,
        loadMore: onLoadMore,
        loadingBuilder: (_) => const PicnicLoadingIndicator(),
        crossAxisSpacing: _spacing,
        mainAxisSpacing: _spacing,
        itemBuilder: (context, index) {
          final collection = collections.items[index];
          return PicnicCollectionCard(
            images: collection.thumbnails,
            collection: collection,
            postCount: collection.counters.posts,
            onTap: () => onTapCollection(collection),
          );
        },
      );
}
