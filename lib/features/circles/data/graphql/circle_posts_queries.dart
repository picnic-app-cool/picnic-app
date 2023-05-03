import 'package:picnic_app/core/data/graphql/templates/gql_template.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_connection.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_post.dart';

String getCircleSortedPostsQuery = """
query(\$circleId: String!, \$cursor: CursorInput!, \$sortingType: PostsSortingType!) {
  sortedCirclePostsConnection(
        circleId: \$circleId,
        cursor: \$cursor,
        sortingType:\$sortingType,
  ){
      ${GqlTemplate().connection(nodeTemplate: GqlTemplate().post)}

  }
}
""";

String getLastUsedSortingOptionQuery = """
query(\$circleId: String!) {
  postsSortingType(
      circleId: \$circleId,
  )
}
""";
