import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/discover/data/gql_discover_repository.dart';
import 'package:picnic_app/features/discover/data/model/gql_circle_group.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/test_utils.dart';

void main() {
  test("should parse feedGroups response", () async {
    final repository = GqlDiscoverRepository(Mocks.graphQlClient);
    when(
      () => Mocks.graphQlClient.query<List<GqlCircleGroup>>(
        document: any(named: 'document'),
        parseData: any(named: 'parseData'),
        variables: any(named: 'variables'),
      ),
    ).thenAnswer((invocation) {
      final parseData = invocation.namedArguments[#parseData] as List<GqlCircleGroup> Function(Map<String, dynamic>);
      return successFuture(parseData(jsonDecode(feedGroupsJson) as Map<String, dynamic>));
    });

    final result = await repository.getGroups();
    expect(result.isFailure, false);
  });
}

const feedGroupsJson = """
{
  "__typename": "Query",
  "feedGroups": [
    {
      "__typename": "FeedGroup",
      "group": {
        "__typename": "Group",
        "name": "gaming"
        },
      "topCircles": null
      }
      ]
}
""";
