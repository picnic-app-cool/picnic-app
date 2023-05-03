import 'package:picnic_app/core/data/graphql/templates/gql_template.dart';

extension GqlTemplateLinkMetadata on GqlTemplate {
  String get linkMetadata => '''
                title
                description
                imageUrl
                host
                url
''';
}
