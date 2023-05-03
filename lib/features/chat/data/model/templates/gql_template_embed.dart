import 'package:picnic_app/core/data/graphql/templates/gql_template.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_link_metadata.dart';

extension GqlTemplateEmbed on GqlTemplate {
  String get embed => '''
          id
          status
          linkMetaData {
            ${GqlTemplate().linkMetadata}
          }
''';
}
