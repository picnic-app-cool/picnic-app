import 'package:picnic_app/core/data/graphql/model/connection/gql_cursor_input.dart';
import 'package:picnic_app/core/domain/model/circle_role.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class GqlGetUserCirclesRequest {
  GqlGetUserCirclesRequest({
    this.userId,
    this.roles,
    this.searchQuery,
    this.cursor,
  });

  final Id? userId;
  final List<CircleRole>? roles;
  final String? searchQuery;
  final GqlCursorInput? cursor;

  Map<String, dynamic> toJson() {
    return {
      if (userId != null) 'userId': userId!.value,
      if (roles != null) 'roles': roles,
      if (searchQuery != null) 'searchQuery': searchQuery,
      if (cursor != null) 'cursor': cursor,
    };
  }
}
