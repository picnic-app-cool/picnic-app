import 'package:picnic_app/core/data/graphql/templates/gql_template.dart';

extension GqlTemplateEdge on GqlTemplate {
  String edge({required String nodeTemplate}) => '''
cursorId
node {
    $nodeTemplate
}
''';
}
