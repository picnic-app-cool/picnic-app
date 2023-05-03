import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';

class PaginatedListPresentationModel<T> {
  PaginatedListPresentationModel()
      : paginatedList = PaginatedList<T>.empty(),
        searchText = '';

  /// Used for the copyWith method
  PaginatedListPresentationModel._({
    required this.paginatedList,
    required this.searchText,
  });

  final PaginatedList<T> paginatedList;
  final String searchText;

  Cursor get cursor => paginatedList.nextPageCursor(pageSize: Cursor.extendedPageSize);

  PaginatedListPresentationModel<T> byAppendingList(PaginatedList<T> newList) => copyWith(
        paginatedList: paginatedList + newList,
      );

  PaginatedListPresentationModel<T> copyWith({
    PaginatedList<T>? paginatedList,
    String? searchText,
  }) {
    return PaginatedListPresentationModel._(
      paginatedList: paginatedList ?? this.paginatedList,
      searchText: searchText ?? this.searchText,
    );
  }
}
