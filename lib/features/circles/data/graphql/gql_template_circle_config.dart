import 'package:picnic_app/core/data/graphql/templates/gql_template.dart';

extension GqlTemplateCircleConfig on GqlTemplate {
  String get circleConfig => '''
  name
	value
	displayName
	emoji
	description
''';
}
