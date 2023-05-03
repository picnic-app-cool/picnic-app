import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/cursor_direction.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

/// used to define next page to fetch in paginated content
class Cursor extends Equatable {
  const Cursor({
    required this.id,
    required this.pageSize,
    required this.direction,
  });

  const Cursor.empty()
      : id = const Id.empty(),
        pageSize = 0,
        direction = CursorDirection.forward;

  const Cursor.firstPage({
    this.pageSize = Cursor.defaultPageSize,
    this.direction = CursorDirection.forward,
  }) : id = const Id.empty();

  static const defaultPageSize = 10;
  static const extendedPageSize = 20;

  /// id of the next page's cursor value
  final Id id;

  /// number of items to fetch
  final int pageSize;

  /// whether we want to go forward(default) or backward
  final CursorDirection direction;

  bool get isFirstPage => id.isNone;

  @override
  List<Object> get props => [
        id,
        pageSize,
        direction,
      ];

  Cursor copyWith({
    Id? id,
    int? limit,
    CursorDirection? direction,
  }) {
    return Cursor(
      id: id ?? this.id,
      pageSize: limit ?? pageSize,
      direction: direction ?? this.direction,
    );
  }
}
