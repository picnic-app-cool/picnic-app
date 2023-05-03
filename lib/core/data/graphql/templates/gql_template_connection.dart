import 'package:picnic_app/core/data/graphql/templates/gql_template.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_edge.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_page_info.dart';

extension GqlTemplateConnection on GqlTemplate {
  String connection({required String nodeTemplate}) => '''
pageInfo {
    $pageInfo
}
edges {
    ${edge(nodeTemplate: nodeTemplate)}
}
''';
}
