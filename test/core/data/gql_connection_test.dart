import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/core/data/graphql/model/connection/gql_connection.dart';
import 'package:picnic_app/core/data/graphql/model/gql_auth_result.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

void main() {
  test(
    "should parse list of authInfos",
    () {
      final connection = GqlConnection.fromJson(
        jsonDecode(_sampleJson) as Map<String, dynamic>,
      );
      expect(connection.pageInfo.hasNextPage, true);
      expect(connection.edges.length, 1);
      expect(connection.edges[0].cursorId, "2");
      final domainObj = connection.toDomain(
        nodeMapper: (node) => GqlAuthResult.fromJson(node).toDomain(
          userId: const Id("userId"),
        ),
      );
      expect(domainObj.pageInfo.hasNextPage, true);
      expect(domainObj.pageInfo.hasPreviousPage, false);
      expect(domainObj.pageInfo.nextPageId, const Id("2"));
      expect(domainObj.pageInfo.previousPageId, const Id.empty());
    },
  );
}

const String _sampleJson = '''
{
  "edges": [
    {
      "cursorId": "2",
      "node": {
        "user": {
          "id": "id",
          "username": "username"
        },
        "authInfo": {
          "accessToken": "abajdsjsao21dsako1jm"
        }
      }
    }
  ],
  "pageInfo": {
    "hasNextPage": true,
    "hasPreviousPage": false,
    "lastId": "2"
  }
}
''';
