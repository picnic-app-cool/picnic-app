import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/cursor_direction.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

/// Denotes page info of the PaginatedList
//ignore_for_file: unused-code, unused-files
class PageInfo extends Equatable {
  const PageInfo({
    required this.nextPageId,
    required this.previousPageId,
    required this.hasNextPage,
    required this.hasPreviousPage,
  });

  const PageInfo.empty() : this.firstPage();

  const PageInfo.firstPage()
      : previousPageId = const Id.none(),
        nextPageId = const Id.none(),
        hasNextPage = true,
        hasPreviousPage = true;

  const PageInfo.singlePage()
      : previousPageId = const Id.none(),
        nextPageId = const Id.none(),
        hasNextPage = false,
        hasPreviousPage = false;

  final Id previousPageId;
  final Id nextPageId;
  final bool hasNextPage;
  final bool hasPreviousPage;

  @override
  List<Object> get props => [
        nextPageId,
        previousPageId,
        hasNextPage,
        hasPreviousPage,
      ];

  Cursor nextPageCursor({int pageSize = Cursor.defaultPageSize}) => Cursor(
        id: nextPageId,
        pageSize: pageSize,
        direction: CursorDirection.forward,
      );

  Cursor previousPageCursor({int pageSize = Cursor.defaultPageSize}) => Cursor(
        id: previousPageId,
        pageSize: pageSize,
        direction: CursorDirection.back,
      );

  PageInfo copyWith({
    Id? previousPageId,
    Id? nextPageId,
    bool? hasNextPage,
    bool? hasPreviousPage,
  }) {
    return PageInfo(
      previousPageId: previousPageId ?? this.previousPageId,
      nextPageId: nextPageId ?? this.nextPageId,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      hasPreviousPage: hasPreviousPage ?? this.hasPreviousPage,
    );
  }
}
