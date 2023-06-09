import 'package:picnic_app/core/data/graphql/templates/gql_template.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_app.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_circle.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_connection.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_success_payload.dart';

String get getGeneratedAppTokenMutation => '''
    mutation(\$appID: ID!) {
        generateUserScopedAppToken(
          appID: \$appID, 
        ) {
            tokenID
            jwtToken
        }
    }
''';

String getTrendingAppsQuery = '''
  query (\$cursor: CursorInput) {
    getTrendingApps(in: {
      cursor: \$cursor
    }) {
      ${GqlTemplate().connection(nodeTemplate: GqlTemplate().app)}
    }
  }
''';

String get getAppsTagsQuery => '''
    query(\$ids: [ID!]!) {
        getAppTags(
          ids: \$ids, 
        ) {
            ${GqlTemplate().appTag}
        }
    }
''';

String get savePodMutation => '''
    mutation(\$appID: ID!) {
        saveApp(
          appID: \$appID, 
        ) {
          ${GqlTemplate().successPayload}  
        }
    }
''';

String get getSavedAppsQuery => '''
    query(\$in: GetSavedAppsInput!) {
        getSavedApps(
          in: \$in
        ) {
          ${GqlTemplate().connection(nodeTemplate: GqlTemplate().app)}
        }
    }
''';

String searchAppsQuery = '''
  query (\$cursor: CursorInput, \$nameStartsWith: String!, \$tagIds: [ID!], \$orderBy: AppOrder!) {
    searchApps(search: {
      cursor: \$cursor,
      nameStartsWith: \$nameStartsWith,
      tagIds: \$tagIds,
      orderBy: \$orderBy
    }) {
      ${GqlTemplate().connection(nodeTemplate: GqlTemplate().app)}
    }
  }
''';

String getFeaturedApps = '''
  query (\$cursor: CursorInput) {
    getFeaturedApps(in: {
      cursor: \$cursor
    }) {
      ${GqlTemplate().connection(nodeTemplate: GqlTemplate().app)}
    }
  }
''';

String get enablePodMutation => '''
    mutation(\$podId: ID!, \$circleId: ID!) {
        enableApp(
          input: {
            appId: \$podId, 
            circleId: \$circleId
          }
        ) {
          ${GqlTemplate().successPayload}  
        }
    }
''';

String get getRecommendedCirclesQuery => '''
    query(\$input: GetRecommendedCirclesInput!) {
        getRecommendedCircles(
          input: \$input
        ) {
          ${GqlTemplate().connection(nodeTemplate: GqlTemplate().basicCircle)}
        }
    }
''';
