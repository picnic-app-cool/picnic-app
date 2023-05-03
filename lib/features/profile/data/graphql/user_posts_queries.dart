import 'package:picnic_app/core/data/graphql/templates/gql_template.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_connection.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_post.dart';

String getUserPostsQuery = """
query(\$userId: String!, \$cursor: CursorInput!) {
  userPostsConnection(userId: \$userId, cursor: \$cursor){
      ${GqlTemplate().connection(nodeTemplate: GqlTemplate().post)}
  }
}
""";
