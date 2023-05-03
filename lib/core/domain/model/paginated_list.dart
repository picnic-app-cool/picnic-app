import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/page_info.dart';
import 'package:picnic_app/utils/extensions/iterable_extensions.dart';
import 'package:picnic_app/utils/extensions/list_extension.dart';

//ignore_for_file: unused-code, unused-files
class PaginatedList<T> extends DelegatingList<T> with EquatableMixin implements List<T> {
  const PaginatedList({
    required this.pageInfo,
    required List<T> items,
  })  : _items = items,
        super(items);

  const PaginatedList.empty() : this.firstPage();

  const PaginatedList.firstPage()
      : pageInfo = const PageInfo.firstPage(),
        _items = const [],
        super(const []);

  const PaginatedList.singlePage([this._items = const []])
      : pageInfo = const PageInfo.singlePage(),
        super(_items);

  final PageInfo pageInfo;

  // we make this field private, since `empty()` const constructor is creating a list with `Never` generic type.
  // In order to avoid major refactor of the entire codebase, we expose `items` field as a getter that casts the list to proper
  // type before returning it
  final List<T> _items;

  List<T> get items => _items.cast();

  @override
  List<Object> get props => [
        items,
        pageInfo,
      ];

  @override
  @Deprecated("use `isEmptyNoMorePage or `listIsEmpty` instead")
  bool get isEmpty => throw UnsupportedError('use `isEmptyNoMorePage` or `listIsEmpty` instead');

  bool get isEmptyNoMorePage => listIsEmpty && !hasNextPage;

  bool get listIsEmpty => items.isEmpty;

  bool get hasNextPage => pageInfo.hasNextPage;

  bool get hasPreviousPage => pageInfo.hasPreviousPage;

  bool get isLoadingNext => hasNextPage;

  bool get isLoadingPrevious => hasPreviousPage;

  Cursor nextPageCursor({int pageSize = Cursor.defaultPageSize}) => pageInfo.nextPageCursor(pageSize: pageSize);

  Cursor previousPageCursor({int pageSize = Cursor.defaultPageSize}) => pageInfo.previousPageCursor(pageSize: pageSize);

  ///  creates new list by appending results from another PaginatedList
  PaginatedList<T> byAppending(PaginatedList<T> list) => PaginatedList(
        pageInfo: pageInfo.copyWith(
          nextPageId: list.pageInfo.nextPageId,
          hasNextPage: list.pageInfo.hasNextPage,
          hasPreviousPage: pageInfo.hasPreviousPage,
        ),
        items: listIsEmpty ? List.unmodifiable(list.items) : List.unmodifiable(items + list.items),
      );

  @override
  PaginatedList<T> operator +(List<T> other) =>
      other is PaginatedList<T> ? byAppending(other) : copyWith(items: List.unmodifiable([...items, ...other]));

  PaginatedList<T> byAddingFirst({required T element}) => PaginatedList(
        pageInfo: pageInfo,
        items: List.unmodifiable([element, ...items]),
      );

  PaginatedList<T> byAddingLast({required T element}) => PaginatedList(
        pageInfo: pageInfo,
        items: List.unmodifiable([...items, element]),
      );

  PaginatedList<T> byRemoving({required T element}) => PaginatedList(
        pageInfo: pageInfo,
        items: List.unmodifiable([...items]..remove(element)),
      );

  PaginatedList<T> byRemovingWhere(bool Function(T element) test) => PaginatedList(
        pageInfo: pageInfo,
        items: ([...items]..removeWhere(test)).unmodifiable,
      );

  PaginatedList<T2> mapItems<T2>(T2 Function(T) mapper) => PaginatedList(
        pageInfo: pageInfo,
        items: items.map(mapper).toList(),
      );

  Future<PaginatedList<T2>> mapItemsAsync<T2>(Future<T2> Function(T) mapper) async {
    return PaginatedList(
      pageInfo: pageInfo,
      items: (await items.mapAsync(mapper)).toList(),
    );
  }

  Future<PaginatedList<T2>> mapNotNullItemsAsync<T2>(Future<T2?> Function(T) mapper) async {
    return PaginatedList(
      pageInfo: pageInfo,
      items: (await mapItemsAsync(mapper)).whereType<T2>().toList(),
    );
  }

  PaginatedList<T> byUpdatingItem({
    required T Function(T) update,
    required bool Function(T) itemFinder,
  }) =>
      copyWith(
        items: items.byUpdatingItem(
          update: update,
          itemFinder: itemFinder,
        ),
      );

  PaginatedList<T> copyWith({
    PageInfo? pageInfo,
    List<T>? items,
  }) {
    return PaginatedList(
      pageInfo: pageInfo ?? this.pageInfo,
      items: items ?? _items,
    );
  }
}
