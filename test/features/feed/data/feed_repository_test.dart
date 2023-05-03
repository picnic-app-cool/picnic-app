import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/data/graphql/model/connection/gql_connection.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/feed/data/graphql_feed_repository.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/test_utils.dart';

void main() {
  late GraphQlFeedRepository repository;

  test("should parse feeds response", () async {
    final cacheable = await repository.getFeeds(nextPageCursor: const Cursor.empty()).first;
    expect(cacheable.result.getFailure(), isNull);
    expect(cacheable.result.getSuccess(), isNotNull);
    expect(
      cacheable.result.getSuccess()!.items.length,
      4,
    );
    expect(cacheable.result.getSuccess()!.items.first.name, 'custom feed');
  });

  setUp(() {
    when(
      () => Mocks.graphQlClient.watchQuery<GqlConnection>(
        document: any(named: 'document'),
        parseData: any(named: 'parseData'),
        variables: any(named: 'variables'),
        options: any(named: 'options'),
      ),
    ).thenAnswer((invocation) {
      final parseData = invocation.namedArguments[#parseData] as GqlConnection Function(Map<String, dynamic>);
      return successCacheableResult(parseData(jsonDecode(_feedSampleJson) as Map<String, dynamic>));
    });
    repository = GraphQlFeedRepository(
      Mocks.graphQlClient,
      Mocks.userStore,
    );
  });
}

String get _feedSampleJson => """
{
  "feedsConnection": {
    "pageInfo": {
      "hasNextPage": false,
      "hasPreviousPage": false
    },
    "edges": [
      {
        "cursorId": "71087365",
        "node": {
          "id": "71087365",
          "type": "CUSTOM",
          "name": "Custom Feed"
        }
      },
      {
        "cursorId": "75983212",
        "node": {
          "id": "75983212",
          "type": "CUSTOM",
          "name": "Custom Feed"
        }
      },
      {
        "cursorId": "10298302",
        "node": {
          "id": "10298302",
          "type": "CUSTOM",
          "name": "Custom Feed"
        }
      },
      {
        "cursorId": "98172491",
        "node": {
          "id": "98172491",
          "type": "CUSTOM",
          "name": "Custom Feed"
        }
      }
    ]
  }
}
""";
