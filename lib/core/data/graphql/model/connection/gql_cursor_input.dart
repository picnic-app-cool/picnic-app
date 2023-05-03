import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/cursor_direction.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class GqlCursorInput {
  GqlCursorInput({
    required this.id,
    this.limit,
    this.dir,
  });

  final Id id;
  final int? limit;
  final CursorDirection? dir;

  Map<String, dynamic> toJson() {
    return {
      'id': id.value,
      if (limit != null) 'limit': limit,
      if (dir != null) 'dir': dir!.name,
    };
  }
}

extension GqlCursorInputMapper on Cursor {
  GqlCursorInput toGqlCursorInput() => GqlCursorInput(
        id: id,
        limit: pageSize,
        dir: direction,
      );
}
