import 'package:picnic_app/core/data/graphql/model/connection/gql_cursor_input.dart';

class GetSavedAppsInput {
  const GetSavedAppsInput({
    required this.cursor,
  });

  final GqlCursorInput cursor;

  Map<String, dynamic> toJson() {
    return {
      'cursor': cursor.toJson(),
    };
  }
}
