import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/data/graphql/model/connection/gql_connection.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/posts/data/graphql_comments_repository.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/posts_mocks.dart';

void main() {
  late GraphQlCommentsRepository repository;

  test("should parse comments response", () async {
    final result = await repository.getComments(
      post: const Post.empty(),
    );
    expect(result.getFailure(), isNull);
    expect(result.getSuccess(), isNotNull);
    expect(
      result.getSuccess()!.children.first.children.length,
      2,
    );
  });

  setUp(() {
    when(
      () => Mocks.graphQlClient.query<GqlConnection>(
        document: any(named: 'document'),
        parseData: any(named: 'parseData'),
        variables: any(named: 'variables'),
      ),
    ).thenAnswer((invocation) {
      final parseData = invocation.namedArguments[#parseData] as GqlConnection Function(Map<String, dynamic>);
      return successFuture(parseData(jsonDecode(_commentsSampleJson) as Map<String, dynamic>));
    });

    when(
      () => PostsMocks.getCommentsQueryGenerator.build(
        maxDepth: any(named: 'maxDepth'),
      ),
    ).thenAnswer((_) => '');
    repository = GraphQlCommentsRepository(
      Mocks.graphQlClient,
      PostsMocks.getCommentsQueryGenerator,
    );
  });
}

String get _commentsSampleJson => """
{
  "getComments": {
    "pageInfo": {
      "firstId": "Q3JlYXRlZEF0OjE2NjU1NTE4NzE2MjU5MDM=",
      "lastId": "Q3JlYXRlZEF0OjE2NjU1NTE4NzE2MjU5MDM=",
      "hasNextPage": false,
      "hasPreviousPage": false
    },
    "edges": [
      {
        "node": {
          "id": "b5008bc1-0b75-429f-aff9-0441b122e08a",
          "text": "Hello comment",
          "author": {
            "id": "2b7aa5cc-06f8-4baa-a9c0-07e7ef4c5357",
            "username": "12XBBHHHH2245",
            "profileImage": "https://storage.googleapis.com/picnic-storage-public-dev/1665495237456789_879237_297990044_8707290371177"
          },
          "repliesCount": 2,
          "repliesConnection": {
            "pageInfo": {
              "firstId": "Q3JlYXRlZEF0OjE2NjU1NTE5MzQ4NDgwMTU=",
              "lastId": "Q3JlYXRlZEF0OjE2NjYwNDU1NDAzNDY1MTE=",
              "hasNextPage": false,
              "hasPreviousPage": false
            },
            "edges": [
              {
                "node": {
                  "id": "4df69a8f-cfff-4a36-9a65-122584b7d467",
                  "text": "Hello comment 1",
                  "author": {
                    "id": "2b7aa5cc-06f8-4baa-a9c0-07e7ef4c5357",
                    "username": "12XBBHHHH2245",
                    "profileImage": "https://storage.googleapis.com/picnic-storage-public-dev/1665495237456789_879237_297990044_8707290371177"
                  },
                  "repliesCount": 0
                }
              },
              {
                "node": {
                  "id": "8c356c74-c67c-40fb-8160-47671340e06c",
                  "text": "Hello comment 1",
                  "author": {
                    "id": "2b7aa5cc-06f8-4baa-a9c0-07e7ef4c5357",
                    "username": "12XBBHHHH2245",
                    "profileImage": "https://storage.googleapis.com/picnic-storage-public-dev/1665495237456789_879237_297990044_8707290371177"
                  },
                  "repliesCount": 0
                }
              }
            ]
          }
        }
      }
    ]
  }
}
""";
