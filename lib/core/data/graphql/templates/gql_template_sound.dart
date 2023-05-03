import 'package:picnic_app/core/data/graphql/templates/gql_template.dart';

extension GqlTemplateSound on GqlTemplate {
  String get sound => '''
          id
          title
          creator
          icon
          url
          usesCount
          duration
''';
}
