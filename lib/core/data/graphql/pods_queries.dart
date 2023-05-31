import 'package:picnic_app/core/data/graphql/templates/gql_template.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_app.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_connection.dart';

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
