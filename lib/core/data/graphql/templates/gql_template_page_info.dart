import 'package:picnic_app/core/data/graphql/templates/gql_template.dart';

extension GqlTemplatePageInfo on GqlTemplate {
  String get pageInfo => '''
          firstId
          lastId
          hasNextPage
          hasPreviousPage
''';
}
