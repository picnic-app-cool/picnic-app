import 'package:picnic_app/features/circles/circle_details/models/posts_sorting_type.dart';

class SortingHandler {
  const SortingHandler({
    required this.selectedSortOption,
    required this.onTapSort,
  }) : showSorting = true;

  const SortingHandler._({
    required this.selectedSortOption,
    required this.onTapSort,
    required this.showSorting,
  });

  factory SortingHandler.noSorting() {
    return SortingHandler._(
      showSorting: false,
      selectedSortOption: () => PostsSortingType.popularAllTime,
      onTapSort: () => Future.value(),
    );
  }

  final PostsSortingType Function() selectedSortOption;

  final Future<PostsSortingType?> Function() onTapSort;
  final bool showSorting;
}
