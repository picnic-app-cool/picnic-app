import 'package:picnic_app/core/data/graphql/templates/gql_template.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_connection.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_post.dart';

String get getSavedPostsQuery => """
query(\$cursor: CursorInput!) {
  savedPostsConnection(cursor: \$cursor){
      ${GqlTemplate().connection(nodeTemplate: GqlTemplate().post)}
  }
}
""";
