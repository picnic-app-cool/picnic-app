import 'package:picnic_app/core/data/graphql/templates/gql_template.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_connection.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_post.dart';

String get getFeedsQuery => '''
    query(\$cursor: CursorInput!){
        feedsConnection(cursor: \$cursor){
            pageInfo{
                firstId
                lastId
                hasNextPage
                hasPreviousPage
            }
            edges{
                cursorId
                node{
                    id,
                    type,
                    name,
                    circle {
                        id
                        membersCount
                        image
                        imageFile
                    }
                }
            }
        }
    }
''';

String get getPopularFeedPostsQuery => '''
query popularFeed(\$cursor: CursorInput!) {
  popularFeed {
    posts(cursor: \$cursor) {
      ${GqlTemplate().connection(nodeTemplate: GqlTemplate().post)}
    }
  }
}
''';
