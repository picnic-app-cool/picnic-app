import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/utils/future_result.dart';

class PaginatedListPresentationModel<T> {
  PaginatedListPresentationModel()
      : paginatedList = PaginatedList<T>.empty(),
        searchText = '',
        loadingResult = const FutureResult.empty();

  /// Used for the copyWith method
  PaginatedListPresentationModel._({
    required this.paginatedList,
    required this.searchText,
    required this.loadingResult,
  });

  final PaginatedList<T> paginatedList;
  final String searchText;
  final FutureResult<void> loadingResult;

  bool get isLoading => loadingResult.isPending();

  Cursor get cursor => paginatedList.nextPageCursor(pageSize: Cursor.extendedPageSize);

  PaginatedListPresentationModel<T> byAppendingList(PaginatedList<T> newList) => copyWith(
        paginatedList: paginatedList + newList,
      );

  PaginatedListPresentationModel<T> copyWith({
    PaginatedList<T>? paginatedList,
    String? searchText,
    FutureResult<void>? loadingResult,
  }) {
    return PaginatedListPresentationModel._(
      paginatedList: paginatedList ?? this.paginatedList,
      searchText: searchText ?? this.searchText,
      loadingResult: loadingResult ?? this.loadingResult,
    );
  }
}
