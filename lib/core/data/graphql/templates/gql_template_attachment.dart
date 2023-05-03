import 'package:picnic_app/core/data/graphql/templates/gql_template.dart';

extension GqlTemplateAttachment on GqlTemplate {
  String get attachment => '''
          id
          filename
          url
          size
          fileType
          createdAt
''';
}
